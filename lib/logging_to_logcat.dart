import 'dart:async';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';

/// Class containing the method channel
/// Static utilities to interact with logcat.
class LogcatMonitor {
  static const MethodChannel _channel =
      const MethodChannel('logging_to_logcat');
  static const EventChannel _event =
      const EventChannel('logging_to_logcat/events');
  static StreamSubscription? _subscription;

  /// Adds a subscription to the logcat stream.
  static void addListen(void Function(dynamic) onData) {
    _subscription = _event.receiveBroadcastStream().listen(onData);
  }

  /// Cancels the logcat stream subscription.
  static void cancelListen() {
    _subscription?.cancel();
  }

  /// Starts monitoring logcat with the provided options.
  static Future<bool?> startMonitor(String options) async {
    return _channel.invokeMethod('startMonitor', {'options': options});
  }

  /// Stops monitoring logcat.
  static Future<bool?> stopMonitor() async {
    return _channel.invokeMethod('stopMonitor');
  }

  /// Runs a logcat command and returns the result.
  static Future<String?> runLogcat(String options) async {
    return _channel.invokeMethod('runLogcat', {'options': options});
  }

  /// Dump the current logcat buffer.
  static Future<String?> get getLogcatDump async {
    return _channel.invokeMethod('runLogcat', {'options': '-d'});
  }

  /// Clears the logcat buffer.
  static Future<String?> get clearLogcat async {
    return _channel.invokeMethod('runLogcat', {'options': '-c'});
  }
}

/// Extension for Logger of the logging package
extension LogcatExtension on Logger {
  /// write its output.
  /// be called once during the startup of the app.
  Future<void> activateLogcat() async {
    this.onRecord.listen((LogRecord record) {
      LogcatMonitor._channel.invokeListMethod(
          "log", [record.level.name, record.message, record.loggerName]);
    });
  }
}
