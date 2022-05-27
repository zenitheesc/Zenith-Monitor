import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/core/pipelines/data_pipeline/data_bloc.dart';

part 'terminal_state.dart';
part 'terminal_event.dart';

class TerminalBloc extends Bloc<TerminalEvent, TerminalState> {
  DataBloc dataBloc;
  late StreamSubscription dataSubscription;
  List<String> noParsedStringList = [];
  List<Widget> terminalList = [];

  TerminalBloc({required this.dataBloc}) : super(TerminalInitialState()) {
    dataSubscription = dataBloc.stream.listen((state) {
      if (state is NewPackageRawData) {
        add(NewPackageEvent(usbResponse: state.noParsedString));
      } else if (state is UsbConnectedState) {
        add(UsbConnectedEvent());
      } else if (state is UsbDisconnectedState) {
        add(UsbDisconnectedEvent());
      }
    });
  }

  @override
  Stream<TerminalState> mapEventToState(TerminalEvent event) async* {
    if (event is NewPackageEvent) {
      noParsedStringList.add(event.usbResponse);
      yield TerminalRow(message: event.usbResponse, color: white);
    } else if (event is TerminalCommand) {
      if (event.command.isNotEmpty) {
        if (event.command[0] == ":") {
          if (event.command == ":clear") {
            noParsedStringList.clear();
            terminalList.clear();
          }
        } else {
          ///Command to device connected
          /// Deve enviar os dados ainda
          dataBloc.add(UsbCommand(command: event.command));
          yield TerminalRow(
              message: "Comando: " + event.command, color: Colors.orangeAccent);
        }
      }
    } else if (event is UsbConnectedEvent) {
      yield TerminalRow(message: "Usb conectado", color: mantisGreen);
    } else if (event is UsbDisconnectedEvent) {
      yield TerminalRow(message: "Usb desconectado", color: lightCoral);
    }
  }

  @override
  Future<void> close() {
    dataSubscription.cancel();
    return super.close();
  }
}
