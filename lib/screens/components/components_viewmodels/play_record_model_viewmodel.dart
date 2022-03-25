import 'dart:developer';
import 'dart:math';

import 'package:rechord/screens/base_model.dart';
import 'package:just_audio/just_audio.dart';

class PlayRecordModelViewModel extends BaseModel {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  Duration? _currentDuration;
  Duration? get currentDuration => _currentDuration;
  Duration? _totalDuration;
  Duration? get totalDuration => _totalDuration;

  init(String url) async {
    await _audioPlayer.setUrl(url);
    // _currentDuration = _audioPlayer.position;
    // notifyListeners();
    _audioPlayer.positionStream.listen((event) {
      _currentDuration = event;
      notifyListeners();
    });
    _audioPlayer.durationStream.listen((event) {
      _totalDuration = event;
    });
  }

  double _value = 20;

  double get value => _value;
  seek(double val) async {
    // await _audioPlayer.seek(Duration(seconds: val.toInt()));
    _value = val;
    notifyListeners();
  }

  play() async {
    try {
      _isPlaying = true;
      notifyListeners();
      await _audioPlayer.play();
    } catch (e) {
      //
    }
  }

  pause() async {
    try {
      _isPlaying = false;
      notifyListeners();
      await _audioPlayer.pause();
    } catch (e) {
      //
    }
  }
}
