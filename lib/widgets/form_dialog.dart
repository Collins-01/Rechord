import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:rechord/utils/app_colors.dart';

class FormDialog extends StatelessWidget {
  final Function(String) saveCallBack;
  FormDialog({Key? key, required this.saveCallBack}) : super(key: key);
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Container(
          alignment: Alignment.center,
          height: 500,
          width: MediaQuery.of(context).size.width * 0.90,
          child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.black.withOpacity(.5),
              body: CupertinoAlertDialog(
                title: const Text("Save record?"),
                content: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Heisenberg',
                    contentPadding: EdgeInsets.only(
                      left: 0,
                      top: 15,
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        saveCallBack(_controller.text);
                      } else {
                        // ignore: deprecated_member_use
                        _scaffoldKey.currentState!.showSnackBar(
                          const SnackBar(
                            backgroundColor: AppColors.kBlue,
                            content: Text("please provide a name"),
                          ),
                        );
                      }
                    },
                    child: const Text("Save"),
                  ),
                ],
              )));
    } else {
      return Container(
          alignment: Alignment.center,
          height: 500,
          width: MediaQuery.of(context).size.width * 0.90,
          child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.black.withOpacity(.5),
              body: AlertDialog(
                title: const Text("Save record?"),
                content: TextFormField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Aud001019089081',
                    contentPadding: EdgeInsets.only(
                      left: 0,
                      top: 15,
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        saveCallBack(_controller.text);
                      } else {
                        // ignore: deprecated_member_use
                        _scaffoldKey.currentState!.showSnackBar(
                          const SnackBar(
                            backgroundColor: AppColors.kBlue,
                            content: Text("please provide a name"),
                          ),
                        );
                      }
                    },
                    child: const Text("Save"),
                  ),
                ],
              )));
    }
  }
}
