import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class BuildDialog extends StatelessWidget {
  final VoidCallback deleteCallBack;
  const BuildDialog({Key? key, required this.deleteCallBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: deleteCallBack,
            child: const Text("Yes"),
          ),
        ],
        content: const Text("Are you sure you want to delete this file?"),
      );
    } else {
      return AlertDialog(
        content: const Text("Are you sure you want to delete this file?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              deleteCallBack();
              Navigator.pop(context);
            },
            child: const Text("Yes"),
          ),
        ],
      );
    }
  }
}
