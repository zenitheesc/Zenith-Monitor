import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/core/pipelines/data_pipeline/data_bloc.dart';

part 'terminal_state.dart';
part 'terminal_event.dart';

class TerminalBloc extends Bloc<TerminalEvent, TerminalState> {
  DataBloc dataBloc;
  late StreamSubscription dataSubscription;
  List<String> noParsedStringList = [];

  TerminalBloc({required this.dataBloc}) : super(TerminalInitialState()) {
    Stream<int> sla = funcLoca();
    sla.listen((event) {
      print(event.toString());
      add(NewPackageEvent(usbResponse: event.toString()));
    });
    dataSubscription = dataBloc.stream.listen((state) {
      if (state is NewPackageStateData) {
        add(NewPackageEvent(usbResponse: state.noParsedString));
      }
    });
  }

  Stream<int> funcLoca() async* {
    for (int i = 0; i < 50; i++) {
      await Future.delayed(Duration(seconds: 1));
      add(NewPackageEvent(usbResponse: i.toString()));
    }
  }
  /* {
	   on<NewPackageEvent>((event, emit) {
	   emit(NewPackageState(usbResponse: event.usbResponse));
	   });
	   }*/

  /// The following comment is how the same code would be implemented in
  /// previous bloc versions

  @override
  Stream<TerminalState> mapEventToState(TerminalEvent event) async* {
    if (event is NewPackageEvent) {
      print(event.usbResponse);
      noParsedStringList.add(event.usbResponse);
      yield NewPackageState(
          usbResponse: event.usbResponse,
          noParsedStringList: noParsedStringList);
    }
  }

  @override
  Future<void> close() {
    dataSubscription.cancel();
    return super.close();
  }
}
