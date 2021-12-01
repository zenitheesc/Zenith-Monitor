part of 'terminal_bloc.dart';

abstract class TerminalState {}

class TerminalInitialState extends TerminalState {}

class NewPackageState extends TerminalState {
  String usbResponse;
  NewPackageState({required this.usbResponse});
}
