part of 'map_bloc.dart';

abstract class MapState {}

class MapInitialState extends MapState {}

class NewPackageState extends MapState {
  List newVariablesList;

  NewPackageState({required this.newVariablesList});
}

class MapError extends MapState {
  String errorMessage;
  MapError({required this.errorMessage});
}
