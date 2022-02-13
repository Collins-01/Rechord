import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rechord/screens/components/build_play_dialog.dart';
import 'package:rechord/screens/recorded_items_page.dart';
import 'package:rechord/services/record_service.dart';
import 'dart:io';
import 'package:rechord/utils/app_colors.dart';
import 'package:rechord/utils/format_duration.dart';
import 'package:rechord/widgets/build_ripple_button.dart';
import 'package:rechord/widgets/build_round_buttons.dart';
import 'package:rechord/widgets/form_dialog.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class RecordPage extends StatelessWidget {
  RecordPage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.primaryColor,
      body: Consumer<RecordService>(builder: (context, model, child) {
        return SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      formatDuration(model.currentDuration).toString(),
                      style: const TextStyle(
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
                child: model.currentDuration > 0
                    ? RippleAnimation(
                        repeat: true,
                        color: Colors.blue,
                        minRadius: 90,
                        ripplesCount: model.isPaused ? 1 : 9,
                        child: Container(),
                      )
                    : !model.getHasStopped
                        ? const Center(
                            child: Text(
                              "Start",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Center(
                            child: TextButton(
                              onPressed: model.getHasStopped
                                  ? () async {
                                      await showDialog(
                                        context: context,
                                        builder: (_) =>  BuildPlayDialog(),
                                      );
                                    }
                                  : () {},
                              child: const Text("Play"),
                            ),
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
                        model.isRecording
                            ? model.stopRecording()
                            : model.startRecording();
                      },
                    ),
                    BuildRoundButtons(
                      callback: () async {
                        //?if user is not recording, navigate to record list
                        if (model.currentDuration > 0) {
                          if (Platform.isIOS) {
                            await showCupertinoDialog(
                              context: context,
                              builder: (_) => FormDialog(
                                saveCallBack: (String value) {},
                              ),
                            );
                          } else {
                            await showDialog(
                              context: context,
                              builder: (_) => FormDialog(
                                saveCallBack: (String value) {},
                              ),
                            );
                          }
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
