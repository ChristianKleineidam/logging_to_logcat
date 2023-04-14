part of 'log_cat_bloc.dart';

@immutable
abstract class LogCatEvent {}

class LogCatEntryEvent extends LogCatEvent {
  final String text;

  LogCatEntryEvent(this.text);
}
