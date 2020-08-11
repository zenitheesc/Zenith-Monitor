import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firstattemptatmaps/components/data.dart';
import 'package:firstattemptatmaps/models/target_trajectory.dart';
import 'package:meta/meta.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final DataManager data;
  StreamSubscription _src;
  DataBloc(this.data) : super(DataInitial());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    print(event);
    if (event is DataStart) {
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
