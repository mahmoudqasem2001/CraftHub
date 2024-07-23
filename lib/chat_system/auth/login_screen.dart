// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import '../api/FirebaseServices.dart';
import '../screens/chat_home_screen.dart';
import 'package:flutter/material.dart';
import '../widget/my_button.dart';
import '../widget/my_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String pass;
  //bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Container(
            //   height: 180,
            //   child: Image.asset(
            //     'images/logo.png',
            //     errorBuilder: (context, error, stackTrace) {
            //       return Icon(Icons.sim_card_alert_outlined);
            //     },
            //   ),
            // ),
            SizedBox(height: 50),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your Email',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                pass = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your password',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            MyButton(
              color: Colors.blue[800]!,
              title: 'register',
              onPressed: () async {
                try {
                  if ((await APIs.userExsist())) {
                    _auth
                        .signInWithEmailAndPassword(
                            email: email, password: pass)
                        .then((value) async {
                      if (value != null) {
                        log('\n User : ${value.user}');
                        log('\n User Add info : ${value.additionalUserInfo}');
                      }
                    });
                  } else {
                    APIs.createUser().then((value) {});
                  }
                  // setState(() {});
                } on Exception catch (e) {
                  // print
                  log('exc occur');
                  print(e);

                  setState(() {
                    //showSpinner = false;
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
