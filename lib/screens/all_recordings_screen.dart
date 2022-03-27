import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rechord/screens/components/build_record_count.dart';
import 'package:rechord/screens/components/play_record_modal.dart';
import 'package:rechord/services/storage_service.dart';
import 'package:rechord/utils/app_colors.dart';
import 'package:rechord/widgets/build_dialog.dart';

class AllRecordingsScreen extends ConsumerStatefulWidget {
  const AllRecordingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllRecordingsScreenState();
}

class _AllRecordingsScreenState extends ConsumerState<AllRecordingsScreen> {
  @override
  void initState() {
    ref.read(storageService).getRecordings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = ref.watch(storageService);
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Recordings',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      BuildRecordCount(),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {
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
            const Divider(
              color: Colors.white,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) => SizedBox(
                  child: ListTile(
                    leading: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => PlayRecordModal(
                            recordModel: model.recordList[index],
                          ),
                        );
                      },
                      icon: const Icon(
                        CupertinoIcons.play,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    title: Text(
                      model.recordList[index].name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      model.recordList[index].date,
                      style: const TextStyle(
                        color: Color(0xff484848),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        await showDialog(
                            builder: (_) => BuildDialog(
                                  deleteCallBack: () async {
                                    await model.deleteItem(
                                        model.recordList[index].path);
                                    // Navigator.pop(context);
                                  },
                                ),
                            context: context);
                      },
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Color(0xff484848),
                        size: 24,
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.white,
                ),
                itemCount: model.recordList.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
