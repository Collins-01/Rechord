import 'package:flutter/material.dart';
import 'package:rechord/screens/components/build_record_item_tile.dart';
import 'package:rechord/screens/components/playing_record.dart';
import 'package:rechord/utils/app_colors.dart';
import 'package:rechord/utils/size_config.dart';

class RecordedItemsPage extends StatefulWidget {
  const RecordedItemsPage({Key? key}) : super(key: key);

  @override
  State<RecordedItemsPage> createState() => _RecordedItemsPageState();
}

class _RecordedItemsPageState extends State<RecordedItemsPage> {
  final List<bool> _items = List.generate(20, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: SizeConfig.defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Record Library",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                  child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    children: List.generate(
                  20,
                  (index) {
                    //   if (_items[index] = true) {
                    //     return PlayingRecord();
                    //   } else {
                    //     return const BuildRecordItemTile();
                    //   }
                    // }

                    return index == 0
                        ? PlayingRecord()
                        : const BuildRecordItemTile();
                  },
                )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
