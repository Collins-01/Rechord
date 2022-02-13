import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rechord/utils/app_colors.dart';
import 'package:rechord/widgets/build_dialog.dart';

class BuildRecordItemTile extends StatelessWidget {
  const BuildRecordItemTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: InkWell(
        onLongPress: () async {
          if (Platform.isIOS) {
            await showCupertinoDialog(
                barrierDismissible: true,
                context: context,
                builder: (_) => BuildDialog(
                      deleteCallBack: () {},
                    ));
          } else {
            await showDialog(
                context: context,
                builder: (_) => BuildDialog(
                      deleteCallBack: () {},
                    ));
          }
        },
        child: Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: AppColors.primaryColorBlured,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                const Icon(
                  Icons.music_note,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Podcast1",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "2:00",
                  style: TextStyle(
                    color: Colors.white.withOpacity(.5),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}