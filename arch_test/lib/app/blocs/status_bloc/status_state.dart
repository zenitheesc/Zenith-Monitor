part of 'status_bloc.dart';

abstract class StatusState {
  const StatusState();
}

class StatusInitial extends StatusState {}

class StatusTickSuccess extends StatusState {
  final StatusPacket packet;
  const StatusTickSuccess(this.packet);
}
