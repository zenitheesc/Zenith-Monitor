part of 'data_bloc.dart';

@immutable
abstract class DataEvent {}

class DataStart extends DataEvent {}

class UsbStart extends DataEvent {}

class DataNewPacket extends DataEvent {
  final TargetTrajectory packet;

  DataNewPacket(this.packet);
}
