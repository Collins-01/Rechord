import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rechord/services/record_service.dart';
import 'package:just_audio/just_audio.dart' as ap;

class BuildPlayDialog extends StatefulWidget {
  BuildPlayDialog({Key? key}) : super(key: key);

  @override
  State<BuildPlayDialog> createState() => _BuildPlayDialogState();
}

class _BuildPlayDialogState extends State<BuildPlayDialog> {
  final ap.AudioPlayer _audioPlayer = ap.AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordService>(builder: (context, model, child) {
      return Container(
        alignment: Alignment.center,
        height: 150,
        child: Center(
          child: Scaffold(
            backgroundColor: Colors.black.withOpacity(.5),
            body: AlertDialog(
              content: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        model.isPausedRecordedAudio
                            ? model.playRecordedAudio()
                            : model.pauseRecordedAudio();
                      });
                    },
                    icon: model.isPausedRecordedAudio
                        ? const Icon(
                            Icons.play_arrow,
                          )
                        : const Icon(Icons.pause),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // Slider.adaptive(
                  //   min: 0,
                  //   max: 100,
                  //   value: 10,
                  //   onChanged: (val) {},
                  // )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
