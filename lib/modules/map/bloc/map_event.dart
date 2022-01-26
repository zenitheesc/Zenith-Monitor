part of 'map_bloc.dart';

abstract class MapEvent {}

class UserInfoEvent extends MapEvent {
  MissionVariablesList newPackage;

  UserInfoEvent({required this.newPackage});

  
  List returnValuesList() {
    return newPackage.getVariablesList();
  }
}

