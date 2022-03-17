import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rechord/providers/fetch_all_recordings.dart';

class BuildRecordCount extends HookConsumerWidget {
  const BuildRecordCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var model = ref.watch(fetchRecordings);
    return model.when(
      data: (items) => Text(
        items.isEmpty || items.length <= 1
            ? '${items.length} Item'
            : '${items.length} Items',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
      error: (error, trace) => const SizedBox.shrink(),
      loading: () => const CircularProgressIndicator.adaptive(
        strokeWidth: 2,
      ),
    );
  }
}
