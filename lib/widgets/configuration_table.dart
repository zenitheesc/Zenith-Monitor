import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/configuration/bloc/mission_controller/mission_variables_bloc.dart';

class ConfigurationTable extends StatefulWidget {
  final Type updateByState;
  final String titleLeft;
  final String titleRight;
  final Type eventBygesture;
  const ConfigurationTable(
      {required this.updateByState,
      required this.titleLeft,
      required this.titleRight,
      required this.eventBygesture});

  @override
  _ConfigurationTableState createState() => _ConfigurationTableState();
}

class _ConfigurationTableState extends State<ConfigurationTable> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MissionVariablesBloc, MissionVariablesState>(
        buildWhen: (previous, current) {
      if (current.runtimeType == widget.updateByState) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      Map map = {};
      if (state is TableUpdate && state.map != null) {
        map = state.map!;
      }
      int i = 1;
      return Column(
        children: [
          Table(
            border: const TableBorder(
                verticalInside: BorderSide(
                    width: 1, color: gray, style: BorderStyle.solid)),
            columnWidths: const {
              0: FractionColumnWidth(2 / 3),
              1: FractionColumnWidth(1 / 3),
            },
            children: [
              createTableRow(widget.titleLeft, widget.titleRight,
                  color: gray, isTop: true),
              for (String key in map.keys)
                createTableRow(key, map[key],
                    rowIndice: i, isBottom: i++ == map.length ? true : false),
              if (map.isEmpty) createTableRow("", "", isBottom: true)
            ],
          ),
        ],
      );
    });
  }

  TableRow createTableRow(String name, String type,
      {Color color = raisingBlack,
      bool isTop = false,
      bool isBottom = false,
      int rowIndice = -1}) {
    MissionVariablesEvent? event;
    if (widget.eventBygesture == DeleteVariable) {
      event = DeleteVariable(rowIndice);
    } else if (widget.eventBygesture == ConnectToDevice) {
      event = ConnectToDevice(rowIndice);
    }

    return TableRow(
        decoration: BoxDecoration(
          borderRadius: isTop
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))
              : isBottom
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))
                  : null,
          color: color,
        ),
        children: [
          GestureDetector(
            onDoubleTap: () {
              if (rowIndice != -1 && event != null) {
                BlocProvider.of<MissionVariablesBloc>(context).add(event);
              }
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 7.5, 12, 7.5),
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: white,
                  fontFamily: 'DMSans',
                ),
              ),
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              if (rowIndice != -1 && event != null) {
                BlocProvider.of<MissionVariablesBloc>(context).add(event);
              }
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(7.5),
                child: Text(
                  type,
                  style: const TextStyle(
                    fontWeight: FontWeight.w200,
                    color: white,
                    fontFamily: 'DMSans',
                  ),
                ),
              ),
            ),
          ),
        ]);
  }
}
