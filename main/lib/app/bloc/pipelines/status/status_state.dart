part of 'status_bloc.dart';

@immutable
abstract class StatusState {}

class StatusInitial extends StatusState {}

class StatusUpdate extends StatusState {
  final StatusPacket packet;

  StatusUpdate(this.packet);
}
