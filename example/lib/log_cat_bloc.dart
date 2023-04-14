import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logcat_monitor/logcat_monitor.dart';

part 'log_cat_event.dart';
part 'log_cat_state.dart';

class LogCatBloc extends Bloc<LogCatEvent, LogCatState> {
  List<String> logList = [];

  Future<void> initPlatformState() async {
    try {
      LogcatMonitor.addListen(_listenStream);
    } on PlatformException {
      debugPrint('Failed to listen Stream of log.');
    }
    await LogcatMonitor.startMonitor("*.*");
  }

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
