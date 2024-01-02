import 'package:blog_app/models/userModel.dart';
import 'package:blog_app/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  static Future<userModel?> getUserModelById(String uid) async {
    userModel? user;

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection("user").doc(uid).get();

    if (docSnap.data() != null) {
      user = userModel.frommap(docSnap.data() as Map<String, dynamic>);
    }

    return user;
  }
}
