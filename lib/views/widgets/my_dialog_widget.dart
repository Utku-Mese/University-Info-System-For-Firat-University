import 'package:flutter/material.dart';

class MyDilog {
  static Future<void> showMyDialog(
      {required context, required List<Widget> children}) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: children,
        );
      },
    );
  }
}
