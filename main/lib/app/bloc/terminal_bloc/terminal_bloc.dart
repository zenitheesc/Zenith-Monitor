import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zenith_monitor/app/bloc/data_bloc/data_bloc.dart';
import 'package:zenith_monitor/app/bloc/status_bloc/status_bloc.dart';
import 'package:zenith_monitor/app/models/status_packet.dart';

part 'terminal_event.dart';
part 'terminal_state.dart';

class TerminalBloc extends Bloc<TerminalEvent, TerminalState> {
  final DataBloc dataBloc;
  final StatusBloc statusBloc;
  StreamSubscription<DataState> _dataSub;
  StreamSubscription<StatusState> _statusSub;
  List<dynamic> data = [];
  TerminalBloc(this.dataBloc, this.statusBloc) : super(TerminalInitial());

  @override
  Stream<TerminalState> mapEventToState(TerminalEvent event) async* {
    if (event is TerminalStart) {
      // start listening to sources
      _dataSub?.cancel();
      _dataSub = dataBloc.listen((dataState) {
        if (dataState is DataUpdated) add(TerminalNewData(dataState.packet));
      });
      _statusSub?.cancel();
      _statusSub = statusBloc.listen((statusState) {
        if (statusState is StatusUpdate) {
          add(TerminalNewData(statusState.packet));
        }
      });
    } else if (event is TerminalNewData) {
      data.add(event.packet);
      yield TerminalUpdate(data);
    } else if (event is TerminalError) {
      yield TerminalFailure(event.message);
    } else if (event is TerminalClear) {
      data.clear();
      yield TerminalUpdate(data);
    }
  }

  void dispose() {
    _dataSub?.cancel();
    _statusSub?.cancel();
  }
}
