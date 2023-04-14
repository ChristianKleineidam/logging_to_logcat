part of 'log_cat_bloc.dart';

@immutable
abstract class LogCatState {
  final List<String> logEntryList;

  LogCatState(this.logEntryList);
}

class LogCatInitial extends LogCatState {
  LogCatInitial() : super(const ["message1", 'message2', 'message3']);

  List<String> get logEntryList => ["message1", 'message2', 'message3'];
}

class LogCatStatus extends LogCatState {
  LogCatStatus(List<String> logEntryList) : super(logEntryList);
}
