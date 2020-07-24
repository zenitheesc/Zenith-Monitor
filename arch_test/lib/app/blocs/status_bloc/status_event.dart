part of 'status_bloc.dart';

abstract class StatusEvent {
  const StatusEvent();
}

class StatusStarted extends StatusEvent {}

class StatusTicked extends StatusEvent {
  final StatusPacket packet;

  const StatusTicked(this.packet);

  @override
  String toString() => 'Tick $packet';
}
