import 'dart:async';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

class _LoggerToLogcat {
  static const MethodChannel _channel =
      const MethodChannel('logging_to_logcat');
}

/// Extension for Logger of the logging package
extension LogcatExtension on Logger {
  /// Makes the logger write it's output to Androids logcat
  Future activateLogcat() async {
    this.onRecord.listen((record) {
      _LoggerToLogcat._channel.invokeListMethod(
          "log", [record.level.name, record.message, record.loggerName]);
    });
  }
}
