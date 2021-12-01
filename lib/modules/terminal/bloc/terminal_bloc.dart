import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'terminal_state.dart';
part 'terminal_event.dart';

class TerminalBloc extends Bloc<TerminalEvent, TerminalState> {
  TerminalBloc() : super(TerminalInitialState());
  /* {
							 on<NewPackageEvent>((event, emit) {
							 emit(NewPackageState(usbResponse: event.usbResponse));
							 });
							 }*/

  /// The following comment is how the same code would be implemented in
  /// previous bloc versions

  /* @override
			    Stream<TerminalState> mapEventToState(TerminalEvent event) async* {
			    if (event is NewPackageEvent) {
			    print(event.usbResponse);
			    yield NewPackageState(usbResponse: event.usbResponse);
			    }
			    }*/
}
