part of 'data_bloc.dart';

abstract class DataState {}

class DataInitial extends DataState {}

class DataReceived extends DataState {
  final StdPacket packet;
  DataReceived(this.packet);
}
