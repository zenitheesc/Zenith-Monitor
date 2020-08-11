part of 'terminal_bloc.dart';

@immutable
abstract class TerminalEvent {}

class TerminalStart extends TerminalEvent {}

class TerminalError extends TerminalEvent {
  final String message;

  TerminalError(this.message);
}

class TerminalNewData extends TerminalEvent {
  final dynamic packet;

  TerminalNewData(this.packet);
}

class TerminalClear extends TerminalEvent {}
