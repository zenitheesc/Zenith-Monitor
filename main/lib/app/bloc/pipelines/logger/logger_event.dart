part of 'logger_bloc.dart';

@immutable
abstract class LoggerEvent {}

class LoggerNewPacket extends LoggerEvent {
  final TargetTrajectory packet;

  LoggerNewPacket(this.packet);
}

class LoggerStart extends LoggerEvent {}
