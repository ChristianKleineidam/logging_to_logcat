import 'dart:async';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

class _LoggerToLogcat {
  static const MethodChannel _channel =
      const MethodChannel('logging_to_logcat');
}

/// Extension for Logger of the logging package
extension LogcatExtension on Logger {
  /// Makes the logger write it's output to Androids logcat. Does only have to
  /// be called once during the startup of the app.
  Future activateLogcat() async {
    this.onRecord.listen((LogRecord record) {
      _LoggerToLogcat._channel.invokeListMethod(
          "log", [record.level.name, record.message, record.loggerName]);
    });
  }
}
