import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rechord/models/record_model.dart';
import 'package:rechord/services/recording_service.dart';
import 'package:rechord/services/storage_service.dart';
import 'package:rechord/utils/app_colors.dart';
import 'package:rechord/utils/format_duration.dart';
import 'package:rechord/widgets/app_logo.dart';
import 'package:rechord/widgets/form_dialog.dart';

class RecordingScreen extends ConsumerStatefulWidget {
  const RecordingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecordingScreenState();
}

class _RecordingScreenState extends ConsumerState<RecordingScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      ref.watch(recordingService).startRecord();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = ref.watch(recordingService);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Row(
              children: [
                const AppLogo(),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
                      model.cancelRecord();
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              height: MediaQuery.of(context).size.height / 1.5,
              right: 0,
              left: 0,
              child: Center(
                child: Text(
                  formatDuration(model.currentDuration),
                  style: const TextStyle(
                    fontSize: 75,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
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
                        onPressed: () async {
                          await model.isRecording()
                              ? model.pauseRecord()
                              : model.playRecord();
                        },
                        icon: Icon(
                          model.isPaused
                              ? CupertinoIcons.pause
                              : CupertinoIcons.play,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          model.stopRecord();
                          Future.delayed(
                            const Duration(seconds: 1),
                            () async {
                              showDialog(
                                context: context,
                                builder: (_) => FormDialog(
                                  saveCallBack: (v) {
                                    if (model.recordPath == null) {
                                      //throw or display error.
                                    }
                                    ref.read(storageService).saveItem(
                                          RecordModel(
                                            path: model.recordPath!,
                                            name: v,
                                            date: DateTime.now()
                                                .toLocal()
                                                .toString(),
                                          ),
                                        );
                                    ref.read(storageService).getRecordings();
                                    Navigator.pop(context);
                                    ref.read(storageService).getRecordings();
                                  },
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          CupertinoIcons.stop,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
