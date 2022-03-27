import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rechord/models/record_model.dart';

// @immutable
class StorageService extends ChangeNotifier {
  List<RecordModel> _recordList = [];
  List<RecordModel> get recordList => _recordList;
  final String className = 'StorageService';

  // * Works
  saveItem(RecordModel recordModel) async {
    try {
      Directory directory = await getTemporaryDirectory();
      var data = directory.listSync().map((e) => e.path).toList().last;
      File _dir = File(data);
      String datePlusName = "${recordModel.date}*${recordModel.name}";
      _dir.rename(
          data.split('/cache/').first + '/cache/' + datePlusName + '.m4a');
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
        log("Path Exists");
        _file.deleteSync(recursive: true);
        await getRecordings();
      } else {
        log("Path does not exist");
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error: $e");
    }
  }

  Future<void> getRecordings() async {
    try {
      Directory directory = await getTemporaryDirectory();
      if (directory.existsSync()) {
        var data = directory.listSync().map((e) {
          log(e.path);
          return RecordModel(
            path: e.path,
            name: ((e.path.split('/cache/').last).split(".").first)
                .split("*")
                .last,
            date: ((e.path.split('/cache/').last).split(".").first)
                .split("*")
                .first,
          );
        });

        _recordList = (data.toList());
        notifyListeners();
      } else {
        //
        _recordList = [];
        notifyListeners();
      }
    } catch (e) {
      log("Error Fetching Records: $e");
    }
  }
}

// * Expose Insatnce of class, making it global
final storageService = ChangeNotifierProvider<StorageService>(
  (ref) => StorageService(),
);
