part of 'terminal_bloc.dart';

abstract class TerminalEvent {}

class NewPackageEvent extends TerminalEvent {
  String usbResponse;
  NewPackageEvent({required this.usbResponse});
}
