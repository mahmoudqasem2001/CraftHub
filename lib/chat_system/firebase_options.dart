import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
///
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyCb79IN5_J8g7DfHZq3mO4LpSYWJZXhYjw",
    appId: "1:713463220223:web:9f624ec56517d149bbc9ca",
    messagingSenderId: "713463220223",
    projectId: "crafthubchat",
    authDomain: "crafthubchat.firebaseapp.com",
    storageBucket: "crafthubchat.appspot.com",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEeRGkoHdg7WS7lOGvCpK-bOgFgtjvejM',
    appId: '1:713463220223:android:34f22ffec2d0a440bbc9ca',
    messagingSenderId: '713463220223',
    projectId: 'crafthubchat',
    storageBucket: 'crafthubchat.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJZIDtSh47Iq9f9Oif54oZKyHvkWlY7TI',
    appId: '1:1010552092173:ios:350b504ad71ed9503a8744',
    messagingSenderId: '1010552092173',
    projectId: 'final-chat-fe453',
    storageBucket: 'final-chat-fe453.appspot.com',
    iosClientId:
        '1010552092173-7snihmc30v1vn95ljb74n0ve88spg8gv.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatFinaly',
  );
}
