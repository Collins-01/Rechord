import 'package:flutter/material.dart';
import 'package:rechord/locator.dart';
import 'package:rechord/models/record_model.dart';
import 'package:rechord/services/record_service.dart';
import 'package:rechord/utils/app_colors.dart';

class PlayingRecord extends StatefulWidget {
  final RecordModel model;
  const PlayingRecord({Key? key, required this.model}) : super(key: key);

  @override
  State<PlayingRecord> createState() => _PlayingRecordState();
}

class _PlayingRecordState extends State<PlayingRecord> {
  final RecordService _service = locator<RecordService>();
  double value = 0;
  change(double val) {
    setState(() {
      value = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColors.kBlue,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.music_note,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    // widget.model.name.split('.').first,
                    'Name',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
                    onPressed: () async {
                      print(widget.model.path);
                      await _service.audioPlayer.stop();
                      await _service.audioPlayer
                          .setUrl(widget.model.path)
                          .then((duration) async {
                        // ignore: avoid_print

                        await _service.audioPlayer.play();
                      });
                    },
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Slider.adaptive(
                // inactiveColor: Colors.white,
                min: 0,
                max: 100,
                value: value,

                onChanged: (value) {
                  change(value);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
