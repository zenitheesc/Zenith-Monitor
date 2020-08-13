import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zenith_monitor/app/components/firebase_receiver.dart';
import 'package:zenith_monitor/app/components/firebase_uploader.dart';
import 'package:zenith_monitor/app/components/usb.dart';
import 'package:zenith_monitor/app/models/status_packet.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  final FirebaseReceiver dataReceiver;
  final FirebaseUploader dataUploader;
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
        if (currentStatus.download != packet) {
          currentStatus.download = packet;
          add(StatusNewPacket(currentStatus));
        }
      });
      _upldrSub?.cancel();
      _upldrSub = dataUploader.status()?.listen((packet) {
        if (currentStatus.upload != packet) {
          currentStatus.upload = packet;
          add(StatusNewPacket(currentStatus));
        }
      });
      _usbSub?.cancel();
      _usbSub = usbManager.status()?.listen((packet) {
        if (currentStatus.usb != packet) {
          currentStatus.usb = packet;
          add(StatusNewPacket(currentStatus));
        }
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
