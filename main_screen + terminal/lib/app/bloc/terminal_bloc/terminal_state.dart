part of 'terminal_bloc.dart';

@immutable
abstract class TerminalState {}

class TerminalInitial extends TerminalState {
  final List<dynamic> data = [];
}

class TerminalUpdate extends TerminalState {
  final List<dynamic> data;

  TerminalUpdate(this.data);
}

class TerminalFailure extends TerminalState {
  final String message;

  TerminalFailure(this.message);
}
