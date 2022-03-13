import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:rechord/models/record_model.dart';
import 'package:rechord/utils/app_logger.dart';

class StorageService {
  String className = 'StorageService';
  // * Works
  saveItem(String fileName, String audioPath) async {
    try {
      Directory directory = await getTemporaryDirectory();
      var data = directory.listSync().map((e) => e.path).toList().last;
      File _dir = File(data);
      _dir.rename(data.split('/cache/').first + '/cache/' + fileName + '.m4a');
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
      Directory directory = await getTemporaryDirectory();
      if (directory.existsSync()) {
        var data = directory.listSync().map((e) =>
            RecordModel(path: e.path, name: e.path.split('/cache/').last));
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
