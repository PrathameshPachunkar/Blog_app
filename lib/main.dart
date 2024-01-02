import 'dart:developer';

import 'package:blog_app/models/userModel.dart';
import 'package:blog_app/screens/SignupScreen.dart';
import 'package:blog_app/screens/blogScreen.dart';
import 'package:blog_app/screens/detailScreen.dart';
import 'package:blog_app/screens/homepageScreen.dart';
import 'package:blog_app/screens/loginScreen.dart';
import 'package:blog_app/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blog_app/support/firebasefetcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  User? user = FirebaseAuth.instance.currentUser;
  log("Logged in state");
  if (user != null) {
    userModel? UserData = await FirebaseHelper.getUserModelById(user.uid);
    if (UserData != null) {
      runApp(MyAppLoggedIn(user: UserData));
    } else {
      runApp(blogApp());
    }
  } else {
    runApp(blogApp());
  }
}

class blogApp extends StatefulWidget {
  const blogApp({super.key});

  @override
  State<blogApp> createState() => _blogAppState();
}

class _blogAppState extends State<blogApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginScreen(),
    );
  }
}

class MyAppLoggedIn extends StatelessWidget {
  final userModel user;

  const MyAppLoggedIn({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homepageScreen(
        user: user,
      ),
    );
  }
}
