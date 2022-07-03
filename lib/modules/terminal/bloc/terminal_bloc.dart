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
  List<String> cmdHistory = [];

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
            yield CleanTerminalList();
          } else if (event.command == ":cmdhist") {
            yield CmdHistory(cmdHistory: cmdHistory);
          }
        } else {
          if (dataBloc.usbIsConnected) {
            dataBloc.add(UsbCommand(command: event.command));
            cmdHistory.add(event.command);
            yield TerminalRow(
                message: event.command, color: Colors.orangeAccent);
          } else {
            yield TerminalRow(
                message: "Impossível enviar o comando, o usb está desconectado",
                color: lightCoral);
          }
        }
      }
    } else if (event is UsbConnectedEvent) {
      yield TerminalRow(message: "Usb conectado", color: mantisGreen);
      if (dataBloc.usbManager.packageModel == null) {
        yield TerminalRow(
            message:
                "As variáveis da missão ainda não foram definidas. Os pacotes não serão processados corretamente.",
            color: lightCoral);
      }
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
