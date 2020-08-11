part of 'data_bloc.dart';

abstract class DataEvent {
  const DataEvent();
}

class DataNewPacket extends DataEvent {
  final StdPacket packet;
  DataNewPacket(this.packet);
}

class LoggerSaved extends DataEvent {}

class BluetoothInit extends DataEvent {}

class UsbInit extends DataEvent {}

class LoggerInit extends DataEvent {}

// class BluetoothClose extends DataEvent {}

// class UsbClose extends DataEvent {}

// class LoggerClose extends DataEvent {}
class DataStop extends DataEvent {}

class LoggerSave extends DataEvent {
  final int data;
  LoggerSave(this.data);
}
