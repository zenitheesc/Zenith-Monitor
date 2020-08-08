import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'terminal_event.dart';
part 'terminal_state.dart';

class TerminalBloc extends Bloc<TerminalEvent, TerminalState> {
  List<dynamic> data = [];
  TerminalBloc() : super(TerminalInitial());

  @override
  Stream<TerminalState> mapEventToState(TerminalEvent event) async* {
    print(event);
    if (event is TerminalStart) {
      // start listening to sources
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
}
