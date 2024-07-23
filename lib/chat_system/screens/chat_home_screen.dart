import 'dart:developer';

import 'package:grad_new_project/core/utils/router/AppColors.dart';

import '../api/FirebaseServices.dart';
import '../auth/profile_screen.dart';
import '../model/chat_user.dart';
import '../widget/chat_user_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../helper/dialogs.dart';

class ChatHomeScreen extends StatefulWidget {
  static String routeName = "chat-home";
  ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  // for storing all users
  List<ChatUser> list = [];
  // for storing searched users
  final List<ChatUser> _searchList = [];
  // for storing search status
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
    SystemChannels.lifecycle.setMessageHandler((message) {
      log('message :$message');
      if (APIs.firebaseAuth.currentUser != null) {
        if (message!.contains('pause')) {
          APIs.updateActiveStatus(false);
        }
        if (message!.contains('resume')) {
          APIs.updateActiveStatus(true);
        }
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_isSearching) {
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            shadowColor: AppColors.orange,
            surfaceTintColor: AppColors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Image.asset(
                'assets/images/Icon.png',
                height: 40,
              ),
            ),
            foregroundColor: AppColors.brown,
          ),
          body: StreamBuilder(
            // stream: FirebaseFirestore.instance.collection('users').snapshots(),
            stream: APIs.getAllUsers(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                // if data is loading
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                // if some or all data is loadde then show it
                case ConnectionState.active:
                case ConnectionState.done:

                  // if (snapshot.hasData) {
                  final data = snapshot.data!.docs;
                  // data here is all the document in collectoin"user"
                  // i here represent one document in the collection user
                  // for (var i in data) {
                  //   log('Data: ${i.data()}');
                  //   list.add(i.data()['name']);
                  // }
                  // }
                  list = data.map((e) => ChatUser.fromJson(e.data())).toList();
                  if (list.isNotEmpty) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return ChatUserCard(
                          user: _isSearching ? _searchList[index] : list[index],
                        );
                      },
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      itemCount:
                          _isSearching ? _searchList.length : list.length,
                      physics: const BouncingScrollPhysics(),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No Connections Found!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                    );
                  }
              }
            },
          ),
          /*floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
                onPressed: () async {
                  _addChatUserDialog();
                },
                child: const Icon(Icons.add_comment_rounded)),
          ),*/
        ),
      ),
    );
  }

//// to handel add
  void _addChatUserDialog() {
    String email = '';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),

              //title
              title: Row(
                children: const [
                  Icon(
                    Icons.person_add,
                    color: Colors.blue,
                    size: 28,
                  ),
                  Text('  Add User')
                ],
              ),

              //content
              content: TextFormField(
                maxLines: null,
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                    hintText: 'Email Id',
                    prefixIcon: const Icon(Icons.email, color: Colors.blue),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              //actions
              actions: [
                //cancel button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.blue, fontSize: 16))),

                //add button
                MaterialButton(
                    onPressed: () async {
                      //hide alert dialog
                      Navigator.pop(context);
                      if (email.isNotEmpty) {
                        await APIs.addChatUser(email).then((value) {
                          if (!value) {
                            Dialogs.showSnackbar(
                                context, 'User does not Exists!');
                          }
                        });
                      }
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ))
              ],
            ));
  }
}
