import 'dart:developer';

import 'package:blog_app/models/userModel.dart';
import 'package:blog_app/screens/SignupScreen.dart';
import 'package:blog_app/screens/homepageScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  UserCredential? userCredential;
  Future<dynamic> AlertDailogBox(String title) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            icon: Icon(
              Icons.warning_amber_rounded,
              color: Colors.redAccent,
            ),
            title: Text(title),
          );
        }));
  }

  void loginUser() async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AlertDailogBox("Not Registered");
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        AlertDailogBox("Wrong Password");
        // print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        AlertDailogBox("Wrong Password");
        // print('Wrong password provided for that user.');
      }
    }
    if (userCredential != null) {
      String uid = userCredential!.user!.uid.toString();
      DocumentSnapshot _userdata =
          await FirebaseFirestore.instance.collection("user").doc(uid).get();

      userModel? User =
          userModel.frommap(_userdata.data() as Map<String, dynamic>);

      log("login succesfull");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => homepageScreen(
                    user: User,
                  )),
          (route) => false);
    }
  }

  void checkFields() {
    String Email = email.text.trim();
    String Password = password.text.trim();
    if (Email.isEmpty || Password.isEmpty) {
      AlertDailogBox("Fields cannot be empty");
      log("Check Fileds");
    } else {
      loginUser();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //email field
            TextField(
              style: TextStyle(
                  //color: Theme.of(context).secondaryHeaderColor,
                  ),
              controller: email,
              decoration: InputDecoration(
                  enabled: true,
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15))),
            ),
            SizedBox(
              height: 20,
            ),

            //password field
            TextField(
              style: TextStyle(
                  //color: Theme.of(context).secondaryHeaderColor,
                  ),
              obscureText: true,
              controller: password,
              decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),

            SizedBox(
              height: 100,
            ),

            //submit button for login screen
            CupertinoButton(
                color: Colors.blueAccent,
                child: Text("Submit"),
                onPressed: () {
                  setState(() {});
                  checkFields();
                }),

            SizedBox(
              height: 40,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have a Account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => signupScreen()));
                    },
                    child: Text("Sign In"))
              ],
            )
          ],
        ),
      )),
    );
  }
}
