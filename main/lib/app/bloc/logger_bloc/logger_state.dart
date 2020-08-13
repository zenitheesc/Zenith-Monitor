part of 'logger_bloc.dart';

@immutable
abstract class LoggerState {}

class LoggerInitial extends LoggerState {}

class LoggerSaved extends LoggerState {
  final int id;

  LoggerSaved(this.id);
}

class LoggerSaving extends LoggerState {}
