part of 'terminal_bloc.dart';

abstract class TerminalState {}

class TerminalInitialState extends TerminalState {}

class TerminalRow extends TerminalState {
  Color color;
  String message;
  TerminalRow({required this.message, required this.color});
}

class CleanTerminalList extends TerminalState {}

class CmdHistory extends TerminalState {
  List<String> cmdHistory;
  CmdHistory({required this.cmdHistory});
}
