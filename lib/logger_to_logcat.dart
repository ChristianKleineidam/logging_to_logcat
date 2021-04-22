import 'dart:async';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

class LoggerToLogcat {
  static const MethodChannel _channel = const MethodChannel('logger_to_logcat');
}

extension LogcatExtension on Logger {
  Future activateLogcat() async {
    this.onRecord.listen((record) {
      LoggerToLogcat._channel.invokeListMethod(
          "log", [record.level.name, record.message, record.loggerName]);
    });
  }
}
