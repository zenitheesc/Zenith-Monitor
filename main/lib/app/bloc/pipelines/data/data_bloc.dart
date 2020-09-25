import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zenith_monitor/app/bloc/pipelines/logger/logger_bloc.dart';
import 'package:zenith_monitor/app/services/data/firebase_downloader.dart';
import 'package:zenith_monitor/app/services/usb/usb.dart';
import 'package:zenith_monitor/app/models/data_packet.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final FirebaseReceiver dataReceiver;
  final UsbManager usbManager;
  // final LoggerBloc logger;
  StreamSubscription _src;
  StreamSubscription _usbConnection;
  DataBloc(this.dataReceiver, this.usbManager) : super(DataInitial());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is DataStart) {
      // First start listening to Firebase
      _src?.cancel();
      await dataReceiver.init();

      _src = dataReceiver.receive().listen((packet) {
        add(DataNewPacket(packet));
      });

      // Also wait for USB connection
      _usbConnection?.cancel();
      _usbConnection = usbManager.attached().listen((isAttached) {
        if (isAttached) {
          // logger.add(LoggerStart());
          add(UsbStart());
        } else {
          // Go back to listening to Firebase
          add(DataStart()); //? loop?
          print("Going back to Firebase...");
        }
      });
    }
    if (event is UsbStart) {
      _src?.cancel();
      // await usbManager.init();
      _src = usbManager.receive().listen((packet) {
        add(DataNewPacket(packet));
      });
    }
    if (event is DataNewPacket) {
      yield DataUpdated(event.packet);
    }
  }

  void dispose() {
    _src?.cancel();
    _usbConnection?.cancel();
  }
}
