import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rechord/utils/app_colors.dart';
import 'package:rechord/widgets/app_logo.dart';

class RecordingScreen extends StatelessWidget {
  const RecordingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              const AppLogo(),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              )
            ],
          ),
          const Text(
            "00:21",
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 70,
            width: 137,
            decoration: const BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.all(
                Radius.circular(200),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.pause,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    CupertinoIcons.stop,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
