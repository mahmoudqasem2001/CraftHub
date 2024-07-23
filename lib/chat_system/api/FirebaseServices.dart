import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../model/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import '../model/chat_user.dart';

class APIs {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  static late ChatUser me;
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  static User get user => firebaseAuth.currentUser!;
  static Future<bool> userExsist() async {
    return (await firebaseFirestore.collection('users').doc(user.uid).get())
        .exists;
  }

//// this
  static Future<bool> addChatUser(String email) async {
    final data = await firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    log('data: ${data.docs}');

    if (data.docs.isNotEmpty && data.docs.first.id != user.uid) {
      //user exists

      log('user exists: ${data.docs.first.data()}');

      firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .collection('my_users')
          .doc(data.docs.first.id)
          .set({});

      return true;
    } else {
      //user doesn't exists

      return false;
    }
  }

  static Future<void> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();
    await fMessaging.getToken().then((t) {
      if (t != null) {
        me.pushToken = t;

        log('Push Token: $t');
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  static Future<void> sendPushNotification(
      ChatUser chatUser, String msg) async {
    try {
      final body = {
        "to": chatUser.pushToken,
        "notification": {
          "title": me.name, //our name should be send
          "body": msg,
          "android_channel_id": "chats"
        },
        "data": {"some_data": "User ID: ${me.id}"}
      };

      var res =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader:
                    'key=AAAA60mZNg0:APA91bE2fOk51Aus8u0tpdj23sery7fxXDPUV0gsYGYwW8hve4nU9dUz5qpRBAIZC-_0_bUQm9Jclat67W_BxdfH0_F7141fM1_8PguXQts9tJbaFTbjsP5xHPwq5ZE8PXUnMxh4fonm'
              },
              body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }

  static Future<void> getSelfInfo() async {
    return await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .get()
        .then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        getFirebaseMessagingToken();
        await APIs.updateActiveStatus(true);
        log('My Data ${user.data()}');
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  static String getConversationId(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firebaseFirestore
        .collection('chats/${getConversationId(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  static Future<void> sendMessage(
      ChatUser chatUser, String msg, Type type) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    Message message = Message(
        toId: chatUser.id,
        msg: msg,
        read: '',
        type: type,
        fromId: user.uid,
        sent: time);
    final ref = firebaseFirestore
        .collection('chats/${getConversationId(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson()).then((value) =>
        sendPushNotification(chatUser, type == Type.text ? msg : 'image'));
  }

  static Future<void> updateMessageReadStatus(Message message) async {
    firebaseFirestore
        .collection('chats/${getConversationId(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().microsecondsSinceEpoch.toString()});
  }

/**************************** Create user  *************************************** */
  static Future<void> createUser() async {
    print(firebaseAuth.currentUser);
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey , im new user",
        image:
            "https://th.bing.com/th/id/OIP.tcQw64SapXKWh0PP5fGvJgAAAA?w=474&h=474&rs=1&pid=ImgDetMain",
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');
    return await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  static Future<void> createUserWithData(String name, String imageUrl) async {
    print(firebaseAuth.currentUser);
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        id: user.uid,
        name: name,
        email: user.email.toString(),
        about: " ",
        image: imageUrl,
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');
    return await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  /**************************   get all users ************************************* */

  static Future<List<Map<String, dynamic>>> getAllChatUsers() async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .collection('my_users')
          .get();

      List<Map<String, dynamic>> users = [];

      for (var doc in querySnapshot.docs) {
        users.add(doc.data());
      }
      return users;
      //check if users are empty
    } catch (e) {
      print('Error retrieving users: $e');
      return [];
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firebaseFirestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  /************************     update user Info     **************************** */
  static Future<void> updateEmail(String newEmail, String password) async {
    try {
      // Step 1: Reauthenticate the user
      User user = firebaseAuth.currentUser!;
      AuthCredential credential =
          EmailAuthProvider.credential(email: user.email!, password: password);
      await user.reauthenticateWithCredential(credential);

      // Step 2: Update the email
      await user.updateEmail(newEmail);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'email': newEmail,
      });
      print('Email updated successfully.');
    } catch (e) {
      print('Failed to update email: $e');
      // Handle the exception as per your application's requirements
    }
  }

  static Future<void> updatePassword(String email, String neWPassword) async {
    try {
      // Step 1: Reauthenticate the user
      User user = firebaseAuth.currentUser!;
      user.updatePassword('neWPassword');
      // Step 2: Update the email

      print('Password updated successfully.');
    } catch (e) {
      print('Failed to update passWord: $e');
      // Handle the exception as per your application's requirements
    }
  }

  static Future<void> updateUserInfo() async {
    return await firebaseFirestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

//******************  Profile Picture ********************************* */
  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split('.').last;
    log('extensions is ${ext}');
    final ref =
        firebaseStorage.ref().child('profile_pictures/${user.uid}.$ext');
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });
    String imageUrl = await ref.getDownloadURL();
    me.image = imageUrl;

    /*return await firebaseFirestore.collection('users').doc(user.uid).update({
      'image': me.image,
    });*/
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({
      'image': imageUrl,
    });
  }

  static Future<String> uploadProfileImage(ChatUser chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = firebaseStorage.ref().child(
        'profileImages/$chatUser.id/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    log(imageUrl);
    return imageUrl;
  }
/******************************************************** */

  static Stream<QuerySnapshot> getLastMessage(ChatUser chatUser) {
    return firebaseFirestore
        .collection('chats/${getConversationId(chatUser.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUser chatUser) {
    return firebaseFirestore
        .collection('users')
        .where('id', isEqualTo: chatUser.id)
        .snapshots();
  }

  static Future<void> updateActiveStatus(bool isOnline) async {
    firebaseFirestore.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }
/*
  static Future<void> sendChatImage(ChatUser chatUser, dynamic file) async {
    try {
      // Getting image file extension
      final ext =
          kIsWeb ? path.extension(file.name) : path.extension(file.path);
      
      // Storage file ref with path
      final ref = FirebaseStorage.instance.ref().child(
          'images/${getConversationId(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');
      log(ref.toString());

      // Uploading image
      UploadTask uploadTask;
      if (kIsWeb) {
        log('is web');
        // Web specific file upload
        final fileBytes = await file.arrayBuffer(); // Read file as byte array
        final Uint8List fileData = Uint8List.fromList(fileBytes);
        final metaData = SettableMetadata(contentType: 'image/$ext');
        uploadTask = ref.putData(fileData, metaData);
      } else {
        // Mobile specific file upload
        final fileMetaData = SettableMetadata(contentType: 'image/$ext');
        uploadTask = ref.putFile(file, fileMetaData);
      }

      // Listening for upload completion and logging data transferred
      final snapshot = await uploadTask.whenComplete(() => {});
      final bytesTransferred = snapshot.bytesTransferred;
      log('Data Transferred: ${bytesTransferred / 1000} kb');

      // Updating image in Firestore database
      final imageUrl = await ref.getDownloadURL();
      await sendMessage(chatUser, imageUrl, Type.image);
    } catch (e) {
      log('Error occurred: $e');
    }
  }
  */

  static Future<void> sendChatImage(ChatUser chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = firebaseStorage.ref().child(
        'images/${getConversationId(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');
    log(ref.toString());
    //uploading image
    await ref
      ..putFile(file, SettableMetadata(contentType: 'image/$ext')).then((p0) {
        log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
      });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }

  //delete message
  static Future<void> deleteMessage(Message message) async {
    await firebaseFirestore
        .collection('chats/${getConversationId(message.toId)}/messages/')
        .doc(message.sent)
        .delete();

    if (message.type == Type.image) {
      await firebaseStorage.refFromURL(message.msg).delete();
    }
  }

  //update message
  static Future<void> updateMessage(Message message, String updateMsg) async {
    await firebaseFirestore
        .collection('chats/${getConversationId(message.toId)}/messages/')
        .doc(message.sent)
        .update({'msg': updateMsg});
  }
}
