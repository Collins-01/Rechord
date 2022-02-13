import 'package:flutter/foundation.dart';
import 'package:record/record.dart';
import 'dart:async';

class RecordService extends ChangeNotifier {
  // *disspose method
  @override
  void dispose() {
    _timer.cancel();
    _record.dispose();
    super.dispose();
  }

  late Timer _timer;
  // late Amplitude _amplitude;
  bool _isPaused = true;
  bool get isPaused => _isPaused;
  int _currentDuration = 0;
  int get currentDuration => _currentDuration;
  final Record _record = Record();
  bool _isRecording = false;
  bool get isRecording => _isRecording;
// *Stop Recording Function here
  stopRecording() async {
    await _record.stop();
    _isRecording = false;
    _timer.cancel();
    notifyListeners();
  }

//*Start Recording function here

  startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentDuration = timer.tick;
      notifyListeners();
      print("New Time: $_currentDuration");
    });
  }

  startRecording() async {
    if (await _record.hasPermission()) {
      await _record.start();
      _isRecording = true;
      startTimer();

      notifyListeners();
    } else {
      await requestPermission();
    }
  }

  pauseRecord() async {
    await _record.pause();
    _isPaused = true;
    notifyListeners();
  }

  playRecord() async {
    await _record.resume();
    _isPaused = false;
    notifyListeners();
  }

  requestPermission() async {
//     Map<Permission, PermissionStatus> statuses = await [
//   Permission.location,
//   Permission.storage,
// ].request();
// print(statuses[Permission.location]);
  }
}
