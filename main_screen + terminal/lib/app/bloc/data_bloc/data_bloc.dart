import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zenith_monitor/app/components/data.dart';
import 'package:zenith_monitor/app/models/target_trajectory.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  // final DataReceiver dataReceiver;
  // final UsbManager usbManager;
  final DataManager data; // MOCK
  StreamSubscription _src;
  DataBloc(this.data) : super(DataInitial());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is DataStart) {
      // switch all data sources
      _src?.cancel();
      _src = data.receive().listen((packet) {
        add(DataNewPacket(packet));
      });
    }
    if (event is DataNewPacket) {
      yield DataUpdated(event.packet);
    }
  }

  @override
  void dispose() {
    _src?.cancel();
  }
}