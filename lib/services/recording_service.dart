import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';

class RecordingService extends ChangeNotifier {
  //* VARIABLES
  final Record _record = Record();
  int _currentDuration = 0;
  int get currentDuration => _currentDuration;
  int _durationBeforePause = 0;
  late Timer _timer;
  bool _isPaused = false;
  bool get isPaused => _isPaused;

  // *METHODS
  // * Start Audio Record
  startRecord() async {
    try {
      if (await _record.hasPermission()) {
        log("Recording Has Strted");

        await _record.start();
        _startTimer();
      }
      //* Start  Recording
    } catch (e) {
      //
    }
  }

//* Stop Recording
  stopRecord() async {
    try {
      await _record.stop();
      _stopTimer();
    } catch (e) {
      //
    }
  }

  pauseRecord() async {
    try {
      await _record.pause();
      _isPaused = true;
      _stopTimer();

      notifyListeners();
    } catch (e) {
      //
    }
  }

  playRecord() async {
    try {
      await _record.resume();
      _startTimer();
      _isPaused = false;
      _currentDuration += _durationBeforePause;
      log("Just Assinged values of old duration to new");
      log("Starting Timer....");
      _startTimer();
      notifyListeners();
    } catch (e) {
      //
    }
  }

  cancelRecord() async {
    await _record.pause();
    await _record.dispose();
  }

  Future<bool> isRecording() async => await _record.isRecording();

// * PRIVATE METHODS
  _startTimer() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (value) async {
      log("Tick : ${value.tick.toString()}");
      _currentDuration = value.tick;
      _durationBeforePause = value.tick;
      notifyListeners();
    });
    notifyListeners();
  }

  _stopTimer() {
    _timer.cancel();
    notifyListeners();
  }
}

final recordingService = ChangeNotifierProvider<RecordingService>(
  (ref) => RecordingService(),
);
