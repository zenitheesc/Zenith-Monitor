import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zenith_monitor/app/bloc/pipelines/data/data_bloc.dart';
import 'package:zenith_monitor/app/services/uploader/firebase_uploader.dart';
import 'package:zenith_monitor/app/services/mock/local_database.dart';
import 'package:zenith_monitor/app/models/data_packet.dart';
import 'package:zenith_monitor/app/services/usb/usb.dart';

part 'logger_event.dart';
part 'logger_state.dart';

class LoggerBloc extends Bloc<LoggerEvent, LoggerState> {
  final DataBloc dataBloc;
  final FirebaseUploader dataUploader;
  final LocalDatabase localDatabase;
  final UsbManager usbManager;
  StreamSubscription _usbConnection;

  StreamSubscription _src;
  LoggerBloc(
      this.dataBloc, this.dataUploader, this.localDatabase, this.usbManager)
      : super(LoggerInitial());

  @override
  Stream<LoggerState> mapEventToState(LoggerEvent event) async* {
    if (event is LoggerStart) {
      _usbConnection?.cancel();
      _usbConnection = usbManager.attached().listen((event) {
        if (event) {
          add(LoggerBegin());
        }
      });
    } else if (event is LoggerBegin) {
      _src?.cancel();
      print('logger iniated');
      _src = dataBloc.listen((dataState) {
        if (dataState is DataUpdated) {
          add(LoggerNewPacket(dataState.packet));
        }
      });
    } else if (event is LoggerNewPacket) {
      yield LoggerSaving();
      await dataUploader.save(event.packet);
      await localDatabase.save(event.packet);
      // TODO: Handle Errors
      yield LoggerSaved(event.packet.id);
    }
  }

  void dispose() {
    _src?.cancel();
  }
}
