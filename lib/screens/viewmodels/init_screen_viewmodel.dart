import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechord/models/record_model.dart';
import 'package:rechord/screens/base_model.dart';
import 'package:rechord/services/storage_service.dart';

class InitScreenViewModel extends BaseModel {
  late final AsyncValue<List<RecordModel>> _recordList;
  AsyncValue<List<RecordModel>> get recordList => _recordList;

  final futureProvider = FutureProvider<int>((ref) {
    return Future.value(36);
  });
}
