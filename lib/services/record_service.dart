import 'package:flutter/foundation.dart';
import 'package:record/record.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart' as ap;

class RecordService extends ChangeNotifier {
  final ap.AudioPlayer _audioPlayer = ap.AudioPlayer();
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
  int _recordedAudioMaxDuration = 0;
  int get recordedAudioMaxDuration => _recordedAudioMaxDuration;
  bool _isPausedRecordedAudio = false;
  bool get isPausedRecordedAudio => _isPausedRecordedAudio;
  bool _hasStopped = false;
  bool get getHasStopped => _hasStopped;
  bool get isPaused => _isPaused;
  int _currentDuration = 0;
  int get currentDuration => _currentDuration;
  final Record _record = Record();
  bool _isRecording = false;
  bool get isRecording => _isRecording;
  String _audioPath = '';
  String get audioPath => _audioPath;
// *Stop Recording Function here
  stopRecording() async {
    var path = await _record.stop();
    _audioPath = path!;
    ap.UriAudioSource uriAudio = ap.AudioSource.uri(Uri.parse(path));
    _isRecording = false;
    _timer.cancel();
    _currentDuration = 0;
    _hasStopped = true;
    notifyListeners();
    // ignore: avoid_print
    print("Recorder Audio Paths: $path");
    // ignore: avoid_print
    print("Uri Audio Source: ${uriAudio.uri}");
  }

  // *Timer Function
  startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentDuration = timer.tick;
      notifyListeners();
      // ignore: avoid_print
      print("New Time: $_currentDuration");
    });
  }

//*Start Recording function here

  startRecording() async {
    if (await _record.hasPermission()) {
      _hasStopped = false;
      await _record.start();
      _isRecording = true;
      startTimer();

      notifyListeners();
    } else {}
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

  playRecordedAudio() async {
    _isPausedRecordedAudio = false;
    await _audioPlayer.stop();
    await _audioPlayer.setUrl(_audioPath).then((duration) async {
      _recordedAudioMaxDuration = duration!.inSeconds;
      await _audioPlayer.play();
      // notifyListeners();
    });
    notifyListeners();
  }

  pauseRecordedAudio() async {
    await _audioPlayer.pause();
    _isPausedRecordedAudio = true;
    notifyListeners();
  }
}
