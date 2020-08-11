import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zenith_monitor/app/models/status_packet.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  final DataReceiver dataReceiver;
  final DataUploaderWithStaus dataUploader;
  final UsbManager usbManager;

  StreamSubscription<int> _recvrSub;
  StreamSubscription<int> _upldrSub;
  StreamSubscription<int> _usbSub;

  var currentStatus = StatusPacket(download: -1, upload: -1, usb: -1);

  StatusBloc(this.dataReceiver, this.dataUploader, this.usbManager)
      : super(StatusInitial());

  @override
  Stream<StatusState> mapEventToState(StatusEvent event) async* {
    if (event is StatusStart) {
      // listen to all at the same time
      _recvrSub?.cancel();
      _recvrSub = dataReceiver.status()?.listen((packet) {
        currentStatus.download = packet; //not sure if its best to do a copy
        add(StatusNewPacket(currentStatus));
      });
      _upldrSub?.cancel();
      _upldrSub = dataUploader.status()?.listen((packet) {
        currentStatus.upload = packet;

        add(StatusNewPacket(currentStatus));
      });
      _usbSub?.cancel();
      _usbSub = usbManager.status()?.listen((packet) {
        currentStatus.usb = packet;
        add(StatusNewPacket(currentStatus));
      });
    } else if (event is StatusNewPacket) {
      yield StatusUpdate(event.packet);
    }
  }

  void dispose() {
    _recvrSub?.cancel();
    _upldrSub?.cancel();
    _usbSub?.cancel();
  }
}

class UsbManager {
  Stream<int> status() {
    return Stream.fromFuture(Future.delayed(Duration(seconds: 1), () => 0));
  }
}

class DataUploaderWithStaus {
  Stream<int> status() {
    return Stream.fromFuture(Future.delayed(Duration(seconds: 2), () => 1));
  }
}

class DataReceiver {
  Stream<int> status() {
    return Stream.fromFuture(Future.delayed(Duration(seconds: 3), () => 2));
  }
}
