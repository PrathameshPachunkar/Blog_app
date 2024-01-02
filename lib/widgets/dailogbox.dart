import 'package:flutter/material.dart';

class widgetsclass {
  BuildContext context;
  String? alertTitlte;
  widgetsclass({required this.context, this.alertTitlte});

  Future<dynamic> AlertDailogBox() {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text("Password Do Not Match"),
          );
        }));
  }
}
