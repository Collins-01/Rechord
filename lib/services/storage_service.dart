import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rechord/models/record_model.dart';
import 'package:rechord/utils/app_logger.dart';
import 'package:rechord/utils/constants.dart';

class StorageService {
  StorageService._();
  static final StorageService _instance = StorageService._();
  factory StorageService() => _instance;
  String className = 'StorageService';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  // * Works
  saveItem(RecordModel recordModel) async {
    try {
      Directory directory = await getTemporaryDirectory();
      var data = directory.listSync().map((e) => e.path).toList().last;
      File _dir = File(data);
      // _dir.rename(data.split('/cache/').first + '/cache/' + fileName + '.m4a');
      //get the prvious list, then add to the list and save.
    } catch (e) {
      // ignore: avoid_print
      print("Error: $e");
    }
  }

// * Works
  deleteItem(String audioPath) async {
    try {
      Directory directory = await getTemporaryDirectory();
      var data = directory
          .listSync()
          .map((e) => e.path)
          .toList()
          .where((element) => element == audioPath)
          .toList();
      File _file = File(data.isEmpty ? '' : data.first);
      if (_file.existsSync()) {
        print("Path Exists");
        _file.deleteSync(recursive: true);
      } else {
        print("Path does not exist");
        // File('/data/user/0/com.example.rechord/cache/testing002.m4a')
        //     .deleteSync();
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error: $e");
    }
  }

  Future<List<RecordModel>> getRecordings() async {
    try {
      // var hasKey = await _storage.read(key: Constants.record);
      // if (hasKey == null || hasKey.isEmpty) {
      //   return [];
      //   //no key stored
      // } else {
      //   var decodedData = jsonDecode(hasKey);
      //   List<RecordModel> _recordList = decodedData
      //       .map<RecordModel>((e) => RecordModel.fromJson(e))
      //       .toList();
      //   return _recordList;
      // }
      Directory directory = await getTemporaryDirectory();
      if (directory.existsSync()) {
        var data = directory.listSync().map((e) => RecordModel(
            path: e.path, name: e.path.split('/cache/').last, date: ''));
        for (var element in data) {
          AppLogger.debug(
              className: className, message: "Audio Paths: ${element.path}");
        }
        return data.toList();
      } else {
        //
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}

// * Expose Insatnce of class, making it global
final storageService = Provider<StorageService>(
  (ref) => StorageService(),
);
