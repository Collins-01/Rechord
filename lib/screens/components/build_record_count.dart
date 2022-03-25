import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rechord/services/storage_service.dart';

class BuildRecordCount extends ConsumerStatefulWidget {
  const BuildRecordCount({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BuildRecordCountState();
}

class _BuildRecordCountState extends ConsumerState<BuildRecordCount> {
  @override
  void initState() {
    ref.read(storageService).getRecordings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = ref.watch(storageService);
    return Text(
      model.recordList.isEmpty || model.recordList.length <= 1
          ? '${model.recordList.length} Item'
          : '${model.recordList.length} Items',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
    );
  }
}
/*

*/