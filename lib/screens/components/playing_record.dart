import 'package:flutter/material.dart';
import 'package:rechord/utils/app_colors.dart';

class PlayingRecord extends StatefulWidget {
  const PlayingRecord({Key? key}) : super(key: key);

  @override
  State<PlayingRecord> createState() => _PlayingRecordState();
}

class _PlayingRecordState extends State<PlayingRecord> {
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
