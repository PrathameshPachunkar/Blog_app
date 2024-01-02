import 'package:blog_app/models/userModel.dart';
import 'package:blog_app/screens/blogScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'loginScreen.dart';

class homepageScreen extends StatefulWidget {
  userModel user;
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  homepageScreen({super.key, required this.user});

  @override
  State<homepageScreen> createState() => _homepageScreenState();
}

class _homepageScreenState extends State<homepageScreen> {
  User? user;
  void logoutuser() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => loginScreen()),
        (route) => false);
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final height = AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoButton(
          padding: EdgeInsets.symmetric(horizontal: 10),
          onPressed: () {},
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.user.profilepic.toString()),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(widget.user.name.toString()),
            ],
          )
        ],
      ),
      body: SafeArea(
          child: Container(
        child: CupertinoButton(
            color: Colors.blueAccent,
            child: Text("logout"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => blogScreen(user: widget.user)));
            }),
      )),
    );
  }
}
