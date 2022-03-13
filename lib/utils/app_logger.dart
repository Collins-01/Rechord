import 'dart:developer';

class AppLogger {
  static debug({required String className, dynamic message}) {
    log("*" * 40, name: className);
    log("---->[Message] : ${message.toString()}", name: className);
    log("*" * 40, name: className);
  }
}
