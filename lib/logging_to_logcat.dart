import 'dart:async';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

/// Class containing the method channel
class _LoggerToLogcat {
  static const MethodChannel _channel =
      const MethodChannel('logging_to_logcat');
}

/// Extension for Logger of the logging package
extension LogcatExtension on Logger {
  /// write its output.
  /// be called once during the startup of the app.
  Future activateLogcat() async {
    this.onRecord.listen((LogRecord record) {
      _LoggerToLogcat._channel.invokeListMethod(
          "log", [record.level.name, record.message, record.loggerName]);
    });
  }
}
