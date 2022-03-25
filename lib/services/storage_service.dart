import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rechord/models/record_model.dart';
import 'package:rechord/utils/app_logger.dart';
import 'package:rechord/utils/constants.dart';

// @immutable
class StorageService extends ChangeNotifier {
  List<RecordModel> _recordList = [];
  List<RecordModel> get recordList => _recordList;
  // const StorageService._();
  // static  StorageService _instance = const StorageService._();
  // factory StorageService() => _instance;
  final String className = 'StorageService';

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
        log("Path Exists");
        _file.deleteSync(recursive: true);
        await getRecordings();
      } else {
        log("Path does not exist");
        // File('/data/user/0/com.example.rechord/cache/testing002.m4a')
        //     .deleteSync();
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
        var data = directory.listSync().map(
              (e) => RecordModel(
                  path: e.path, name: e.path.split('/cache/').last, date: ''),
            );

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
