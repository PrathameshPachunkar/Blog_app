// import 'dart:developer';

// import 'package:blog_app/screens/homepageScreen.dart';
// import 'package:blog_app/screens/loginScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class splashScreen extends StatefulWidget {
//   const splashScreen({super.key});

//   @override
//   State<splashScreen> createState() => _splashScreenState();
// }

// class _splashScreenState extends State<splashScreen> {
//   void checklogin() async {
//     User? loginuser = await FirebaseAuth.instance.currentUser;
//     if (loginuser == null) {
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => loginScreen()),
//           (route) => false);
//     } else if (loginuser != null) {
//       //log(loginuser.email.toString());
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => homepageScreen()),
//           (route) => false);
//     } else {
//       log("error has occured");
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     checklogin();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text(
//           "Blog App",
//           style: TextStyle(color: Colors.blueAccent, fontSize: 50),
//         ),
//       ),
//     );
//   }
// }
