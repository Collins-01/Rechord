import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechord/models/record_model.dart';
import 'package:rechord/screens/components/components_viewmodels/play_record_model_viewmodel.dart';
import 'package:rechord/utils/app_colors.dart';

final _playRecordModalViewModel =
    ChangeNotifierProvider<PlayRecordModelViewModel>(
        (ref) => PlayRecordModelViewModel());

class PlayRecordModal extends ConsumerStatefulWidget {
  final RecordModel recordModel;
  const PlayRecordModal({Key? key, required this.recordModel})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlayRecordModalState();
}

class _PlayRecordModalState extends ConsumerState<PlayRecordModal> {
  @override
  void initState() {
    super.initState();
    ref.read(_playRecordModalViewModel).init(widget.recordModel.path);
  }

  @override
  Widget build(BuildContext context) {
    var model = ref.watch(_playRecordModalViewModel);
    //viewmodel listening to the data
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const Text(
                  'My Recording',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (model.isPlaying) {
                      model.pause();
                    } else {
                      model.play();
                    }
                  },
                  icon: Icon(
                    model.isPlaying
                        ? CupertinoIcons.pause
                        : CupertinoIcons.play,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                Expanded(
                  child: Slider.adaptive(
                    min: 0,
                    max: model.totalDuration == null
                        ? 0
                        : model.totalDuration!.inMilliseconds.toDouble(),
                    value: model.currentDuration == null
                        ? 0
                        : model.currentDuration!.inMilliseconds.toDouble(),
                    // value: 30,
                    onChanged: (val) {
                      // model.seek(val);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      decoration: const BoxDecoration(
        color: AppColors.lightBlack,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: 170,
    );
  }
}
