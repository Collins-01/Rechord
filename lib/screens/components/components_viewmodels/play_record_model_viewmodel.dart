import 'package:rechord/screens/base_model.dart';

class PlayRecordModelViewModel extends BaseModel {
  double _value = 20;
  double get value => _value;
  seek(double val) {
    _value = val;
    notifyListeners();
  }
}
