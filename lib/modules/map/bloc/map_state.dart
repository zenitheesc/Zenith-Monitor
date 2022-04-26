part of 'map_bloc.dart';

abstract class MapState {}

class MapInitialState extends MapState {}

class UserInfoState extends MapState {
  List newVariablesList;

  UserInfoState({required this.newVariablesList});
}
