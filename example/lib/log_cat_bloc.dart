import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// Log monitoring is disabled in this simplified example, so the
// logcat_monitor package is no longer required.

part 'log_cat_event.dart';
part 'log_cat_state.dart';

class LogCatBloc extends Bloc<LogCatEvent, LogCatState> {
  List<String> logList = [];

  /// Log monitoring is disabled. This method is retained so the
  /// constructor's call remains valid but it performs no work.
  Future<void> initPlatformState() async {}

  LogCatBloc() : super(LogCatInitial()) {
    initPlatformState();

    on<LogCatEntryEvent>((event, emit) {
      logList.add(event.text);
      emit(LogCatStatus(logList.sublist(max(0, logList.length - 8))));
    });
  }

  void _listenStream(dynamic value) {
    if (value is String) {
      this.add(LogCatEntryEvent(value));
    }
  }
}
