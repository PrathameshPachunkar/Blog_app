import 'dart:developer';
import 'dart:io';
import 'package:blog_app/models/detailsModel.dart';
import 'package:blog_app/models/userModel.dart';
import 'package:blog_app/screens/homepageScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class detailScreen extends StatefulWidget {
  String email;
  User FirebaseUser;
  final UserCredential credential;
  // String uid;
  detailScreen(
      {super.key,
      //required this.uid,
      required this.credential,
      required this.email,
      required this.FirebaseUser});

  @override
  State<detailScreen> createState() => _detailScreenState();
}

class _detailScreenState extends State<detailScreen> {
  @override
  File? imageFile;
  UserCredential? createNewUser;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ScrollController _descriptionScrollbar = ScrollController();

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

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 20);

    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });
    }
  }

  showoptions() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Upload Profile Picture"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.gallery);
                  },
                  leading: Icon(Icons.photo_album),
                  title: Text("Select from Gallery"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.camera);
                  },
                  leading: Icon(Icons.camera_alt),
                  title: Text("Take a photo"),
                ),
              ],
            ),
          );
        });
  }

  void createdUserDB(
      {required String name,
      required DateTime createdon,
      required String description}) async {
    String? imageurl;
    TaskSnapshot _profilepic = await FirebaseStorage.instance
        .ref("profilepic")
        .child(widget.FirebaseUser.uid.toString())
        .putFile(imageFile!);
    imageurl = await _profilepic.ref.getDownloadURL();

    userModel createdUser = userModel(
        name: name,
        uid: widget.FirebaseUser.uid.toString(),
        description: description,
        profilepic: imageurl,
        createdon: createdon);
    await FirebaseFirestore.instance
        .collection("user")
        .doc(widget.credential.user!.uid)
        .set(createdUser.tomap())
        .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => homepageScreen(
                      user: createdUser,
                    )),
            (route) => false));
  }

  void checkfields() {
    String description = descriptionController.text.trim();
    String name = nameController.text.trim();
    DateTime createdon = DateTime.now();
    if (description.isEmpty || name.isEmpty || imageFile == null) {
      AlertDailogBox("Enter All Fields");
    } else {
      //createUser();
      createdUserDB(name: name, createdon: createdon, description: description);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          CupertinoButton(
            onPressed: () {
              showoptions();
            },
            child: CircleAvatar(
              radius: 60,
              backgroundImage:
                  (imageFile != null) ? FileImage(imageFile!) : null,
              child: (imageFile == null)
                  ? Icon(
                      Icons.person,
                      size: 60,
                    )
                  : null,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            style: TextStyle(
                //color: Theme.of(context).secondaryHeaderColor,
                ),
            controller: nameController,
            decoration: InputDecoration(
                enabled: true,
                labelText: "NAME",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15))),
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: TextField(
              controller: descriptionController,
              minLines: 1,
              scrollController: _descriptionScrollbar,
              maxLines: 10,
              maxLength: 200,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  enabled: true,
                  labelText: "Descpription",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(15))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CupertinoButton(
              color: Colors.blueAccent,
              child: Text("Sign In"),
              onPressed: () {
                checkfields();
              })
        ]),
      )),
    );
  }
}
