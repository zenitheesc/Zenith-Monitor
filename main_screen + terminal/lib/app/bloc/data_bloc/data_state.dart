part of 'data_bloc.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}

class DataUpdated extends DataState {
  final TargetTrajectory packet;

  DataUpdated(this.packet);
}
