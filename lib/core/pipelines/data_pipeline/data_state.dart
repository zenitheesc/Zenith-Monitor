part of 'data_bloc.dart';

abstract class DataState {}

class DataStateInitial extends DataState {}

class NewPackageStateData extends DataState {
  final String noParsedString;
  final MissionVariablesList newPackage;

  NewPackageStateData({required this.noParsedString, required this.newPackage});
}
