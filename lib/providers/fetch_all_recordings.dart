import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rechord/models/record_model.dart';
import 'package:rechord/services/storage_service.dart';

final fetchRecordings = FutureProvider<List<RecordModel>>((ref) async {
  return ref.watch(storageService).getRecordings();
});
