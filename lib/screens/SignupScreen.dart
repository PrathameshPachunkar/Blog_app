import 'dart:developer';

import 'package:blog_app/screens/detailScreen.dart';
import 'package:blog_app/widgets/dailogbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signupScreen extends StatefulWidget {
  const signupScreen({super.key});

  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  @override
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cfnpassword = TextEditingController();
  UserCredential? createNewUser;
  User? FirebaseUser;

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

  late String confirmedPassword;
  late String Email = email.text.trim();

  void createUser() async {
    UserCredential? credentials;
    String Email = email.text.trim();
    String Password = password.text.trim();
    try {
      credentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: Email, password: Password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        log("weak password");
      } else if (e.code == "email-already-in-use") {
        AlertDailogBox("Account Already Exists");

        log("Email Exists");
      }
    }

    if (credentials != null) {
      String uid = credentials.user!.uid;
      log("user Present");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => detailScreen(
                  credential: credentials!,
                  email: Email,
                  FirebaseUser: credentials!.user!)));
    }
  }

  void checkpassword() {
    String pass = password.text.trim();
    String cnpass = cfnpassword.text.trim();
    if (pass != cnpass) {
      AlertDailogBox("Password Do Not Match");
      log("Incorrect paswword!!");
    } else if (pass.isEmpty || cnpass.isEmpty) {
      AlertDailogBox("Password cannot be empty");
      log("Enter the password");
    } else {
      createUser();
      confirmedPassword = pass;
      log("no error");
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //email field
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
                SizedBox(
                  height: 20,
                ),

                //password field
                TextField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),

                SizedBox(
                  height: 20,
                ),

                //password field
                TextField(
                  obscureText: true,
                  controller: cfnpassword,
                  decoration: InputDecoration(
                      labelText: "ConfirmPassword",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),

                SizedBox(
                  height: 20,
                ),

                //submit button for login screen
                CupertinoButton(
                    color: Colors.blueAccent,
                    child: Text("Submit"),
                    onPressed: () {
                      setState(() {});
                      checkpassword();
                    }), //submit button

                SizedBox(
                  height: 80,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have a Account?"),
                    TextButton(onPressed: () {}, child: Text("Login In"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
