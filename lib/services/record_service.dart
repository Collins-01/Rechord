import 'package:flutter/foundation.dart';
import 'package:rechord/locator.dart';
import 'package:rechord/models/record_model.dart';
import 'package:rechord/services/storage_service.dart';
import 'package:rechord/utils/app_logger.dart';
import 'package:record/record.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart' as ap;

class RecordService extends ChangeNotifier {
  final StorageService _storageService = locator<StorageService>();
  String className = "RecordService";
  final ap.AudioPlayer _audioPlayer = ap.AudioPlayer();
  ap.AudioPlayer get audioPlayer => _audioPlayer;
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
    notifyListeners();
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
      await _record.start(
        
      );
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
      // ignore: avoid_print

      _recordedAudioMaxDuration = duration!.inSeconds;
      await _audioPlayer.play();
      notifyListeners();
      AppLogger.debug(className: className, message: _audioPath);
    });
    notifyListeners();
    AppLogger.debug(className: className, message: 'Audio Played');
  }

  pauseRecordedAudio() async {
    await _audioPlayer.pause();
    _isPausedRecordedAudio = true;
    notifyListeners();
    AppLogger.debug(className: className, message: 'Audio Paused');
  }

  List<RecordModel> _recordList = [];
  List<RecordModel> get recordList => _recordList;
  bool _loadingItems = false;
  bool get loadingItems => _loadingItems;
  fetchItems() async {
    try {
      var tempList = await _storageService.getRecordings();
      _recordList = tempList;
      notifyListeners();
      AppLogger.debug(className: className, message: _recordList.toList());
    } catch (e) {
      //
      _loadingItems = false;
      notifyListeners();
      AppLogger.debug(
          className: className, message: "Error Fetching Items was: $e");
    }
  }
}
