import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rechord/screens/recorded_items_page.dart';
import 'package:rechord/services/record_service.dart';
import 'dart:io';
import 'package:rechord/utils/app_colors.dart';
import 'package:rechord/widgets/build_ripple_button.dart';
import 'package:rechord/widgets/build_round_buttons.dart';
import 'package:rechord/widgets/form_dialog.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Consumer<RecordService>(builder: (context, model, child) {
        return SafeArea(
          child: Stack(
            children: [
              Column(
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      "00:00",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 3,
                left: 0,
                right: 0,
                child: RippleAnimation(
                  repeat: true,
                  color: Colors.blue,
                  minRadius: 90,
                  ripplesCount: 9,
                  child: Container(),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 0,
                left: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BuildRoundButtons(
                      callback: () {
                        //delete current recording
                      },
                      icon: Icons.delete,
                    ),
                    BuildRippleButton(
                      isRecording: model.isRecording,
                      callback: () {
                        model.startRecording();
                      },
                    ),
                    BuildRoundButtons(
                      callback: () async {
                        //?if user is not recording, navigate to record list
                        if (model.isRecording) {
                          // if (Platform.isIOS) {
                          //   await showCupertinoDialog(
                          //     context: context,
                          //     builder: (_) => FormDialog(
                          //       saveCallBack: (String value) {},
                          //     ),
                          //   );
                          // } else {
                          //   await showDialog(
                          //     context: context,
                          //     builder: (_) => FormDialog(
                          //       saveCallBack: (String value) {},
                          //     ),
                          //   );
                          // }
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const RecordedItemsPage(),
                            ),
                          );
                        }
                      },
                      icon: Icons.layers,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
