import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rechord/providers/fetch_all_recordings.dart';
import 'package:rechord/screens/components/build_record_count.dart';
import 'package:rechord/screens/components/play_record_modal.dart';
import 'package:rechord/utils/app_colors.dart';

class AllRecordingsScreen extends HookConsumerWidget {
  const AllRecordingsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var recordings = ref.watch(fetchRecordings);
    return recordings.when(
      data: (items) {
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
                                recordModel: items[index],
                              ),
                            );
                          },
                          icon: const Icon(
                            CupertinoIcons.play,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        title: const Text(
                          "My Recording",
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: const Text(
                          "2/01/2001",
                          style: TextStyle(
                            color: Color(0xff484848),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
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
                    itemCount: items.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
      error: (err, trace) => Center(
        child: Text("Error: $err"),
      ),
      loading: () => const CircularProgressIndicator.adaptive(),
    );
  }
}
