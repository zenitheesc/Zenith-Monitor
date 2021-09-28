part of 'data_bloc.dart';

@immutable
abstract class DataEvent {}

class DataStart extends DataEvent {
  final String missionName;

  DataStart(this.missionName);
}

class DataNewPacket extends DataEvent {
  final MissionVariablesList packet;

  DataNewPacket(this.packet);
}
