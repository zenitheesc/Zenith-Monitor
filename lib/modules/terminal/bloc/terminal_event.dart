part of 'terminal_bloc.dart';

abstract class TerminalEvent {}

class TerminalCommand extends TerminalEvent {
  String command;
  TerminalCommand({required this.command});
}

class NewPackageEvent extends TerminalEvent {
  String usbResponse;
  NewPackageEvent({required this.usbResponse});
}

class UsbConnectedEvent extends TerminalEvent {}

class UsbDisconnectedEvent extends TerminalEvent {}
