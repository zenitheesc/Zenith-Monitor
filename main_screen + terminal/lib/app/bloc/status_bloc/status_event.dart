part of 'status_bloc.dart';

@immutable
abstract class StatusEvent {}

class StatusStart extends StatusEvent {}

class StatusNewPacket extends StatusEvent {
  final StatusPacket packet;

  StatusNewPacket(this.packet);
}
