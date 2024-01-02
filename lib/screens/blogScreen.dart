import 'package:blog_app/models/blogModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/userModel.dart';

class blogScreen extends StatefulWidget {
  userModel user;
  blogScreen({super.key, required this.user});

  @override
  State<blogScreen> createState() => _blogScreenState();
}

class _blogScreenState extends State<blogScreen> {
  TextEditingController blogController = TextEditingController();
  TextEditingController blogTitle = TextEditingController();

  void submitblog() async {
    blogModel blog = blogModel(
        author: widget.user.name,
        blog: blogController.text.trim(),
        createdOn: DateTime.now(),
        read: false,
        title: blogTitle.text.trim());
    await FirebaseFirestore.instance
        .collection("blogs")
        .doc(widget.user.uid)
        .set(blog.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              TextField(
                controller: blogTitle,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: blogController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
                minLines: 1,
                maxLines: 100,
                maxLength: 10000,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(
                height: 20,
              ),
              CupertinoButton(
                  child: Text("Submit"),
                  onPressed: () {
                    submitblog();
                  })
            ],
          ),
        ),
      )),
    );
  }
}
