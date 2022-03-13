import 'package:flutter/material.dart';
import 'package:rechord/locator.dart';
import 'package:rechord/screens/components/build_record_item_tile.dart';
import 'package:rechord/screens/components/playing_record.dart';
import 'package:rechord/services/record_service.dart';
import 'package:rechord/utils/app_colors.dart';
import 'package:rechord/utils/size_config.dart';

class RecordedItemsPage extends StatefulWidget {
  const RecordedItemsPage({Key? key}) : super(key: key);

  @override
  State<RecordedItemsPage> createState() => _RecordedItemsPageState();
}

class _RecordedItemsPageState extends State<RecordedItemsPage> {
  final RecordService _recordService = locator<RecordService>();
  @override
  void initState() {
    _recordService.fetchItems();
    super.initState();
  }

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
              _recordService.loadingItems
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Expanded(
                      child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                          children: List.generate(
                        _recordService.recordList.length,
                        (index) {
                          return index == 0
                              ? PlayingRecord(
                                  model: _recordService.recordList[index],
                                )
                              : BuildRecordItemTile(
                                  model: _recordService.recordList[index],
                                );
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
