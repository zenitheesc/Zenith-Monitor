import 'dart:async';
import 'package:arch_test/app/blocs/bluetooth/bluetooth.dart';
import 'package:arch_test/app/blocs/logger/logger.dart';
import 'package:arch_test/app/blocs/usb/usb.dart';
import 'package:arch_test/app/models/StandartPacket.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'data_events.dart';
part 'data_states.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final Bluetooth bluetooth;
  final UsbSerial usb;
  final Logger logger;

  DataBloc(this.bluetooth, this.usb, this.logger) : super(DataInitial());
  StreamSubscription source;

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is BluetoothInit) {
      source?.cancel();
      source = bluetooth.receive().listen((data) {
        add(DataNewPacket(StdPacket(data)));
      });
    } else if (event is UsbInit) {
      source?.cancel();
      source = usb.receive().listen((data) {
        add(DataNewPacket(StdPacket(data)));
      });
    } else if (event is LoggerInit) {
      // This is acting as Follower
      source?.cancel();
      source = logger.receive().listen((data) {
        add(DataNewPacket(StdPacket(data)));
      });
    }
    //
    else if (event is LoggerSave) {
      await logger.savePacket(StdPacket(event.data));
      // yield
    } else if (event is DataStop) {
      source?.cancel();
    } else if (event is DataNewPacket) {
      yield DataReceived(event.packet);
    }
  }

  @override
  Future<void> close() {
    source?.cancel();
    return super.close();
  }
}
