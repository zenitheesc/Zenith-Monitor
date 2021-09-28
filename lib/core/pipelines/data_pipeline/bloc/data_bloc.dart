import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final FirestoreServices firestoreServices = FirestoreServices();
  late StreamSubscription dataSource;
  final String missionName;

  DataBloc(this.missionName) : super(DataInitial());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is DataStart) {
      dataSource.cancel();
      await firestoreServices.init(missionName);

      dataSource = firestoreServices.recive().listen((packet) {
        add(DataNewPacket(packet));
      });
    }

    if (event is DataNewPacket) {
      yield DataUpdated(event.packet);
    }
  }

  void dispose() {
    dataSource.cancel();
  }
}
