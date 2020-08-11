import 'dart:async';
import 'package:arch_test/app/blocs/bluetooth/bluetooth.dart';
import 'package:arch_test/app/blocs/logger/logger.dart';
import 'package:arch_test/app/blocs/usb/usb.dart';
import 'package:arch_test/app/models/StatusPacket.dart';
import 'package:arch_test/app/repos/CloudRepo.dart';
import 'package:bloc/bloc.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  Bluetooth bluetooth;
  UsbSerial usb;
  Logger logger;
  StreamSubscription sBluetooth, sUsb, sCloud;
  StatusPacket p = StatusPacket(bluetooth: 0, usb: 0, logger: 0);

  StatusBloc(this.bluetooth, this.usb, this.logger) : super(StatusInitial());

  @override
  StatusState get initialState => StatusInitial();

  @override
  Stream<StatusState> mapEventToState(StatusEvent event) async* {
    if (event is StatusStarted) {
      sBluetooth?.cancel();
      sBluetooth = bluetooth.status().listen((status) {
        p.bluetooth = status;
        add(StatusTicked(p)); //should this be a copy?
      });

      sUsb?.cancel();
      sUsb = usb.status().listen((status) {
        p.usb = status;
        add(StatusTicked(p)); //should this be a copy?
      });

      sCloud?.cancel();
      sCloud = logger.status().listen((status) {
        p.logger = status;
        add(StatusTicked(p)); //should this be a copy?
      });
    }
    if (event is StatusTicked) {
      yield StatusTickSuccess(event.packet);
    }
  }

  @override
  Future<void> close() {
    sBluetooth?.cancel();
    sUsb?.cancel();
    sCloud?.cancel();
    return super.close();
  }
}
