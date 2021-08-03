//import 'dart:html';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/modules/mission_detail/bloc/mission_variables/variables_bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_mission_variables.dart';

class MissionCreation extends StatefulWidget {
  const MissionCreation({Key? key}) : super(key: key);

  @override
  _MissionCreationState createState() => _MissionCreationState();
}

class _MissionCreationState extends State<MissionCreation> {
  TextEditingController variableNameController = new TextEditingController();
  TextEditingController variableTypeController = new TextEditingController();

  TextField textField(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextStyle(
          color: white, fontWeight: FontWeight.normal, fontFamily: 'DMSans'),
      cursorColor: white,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 8.5, 12, 8.5),
          isDense: true,
          hintStyle: TextStyle(color: gray),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: gray),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: gray),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: hintText),
    );
  }

  Widget textInputs() {
    return Table(
        //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          1: FractionColumnWidth(0.03),
          2: FractionColumnWidth(0.25),
          3: FractionColumnWidth(0.15)
        }, children: [
      TableRow(children: [
        textField('Inserir novo campo', variableNameController),
        SizedBox(width: 10),
        textField('Tipo', variableTypeController),
        SizedBox(
            height: 30,
            width: 30,
            child: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<VariablesBloc>(context).add(
                    AddStandardVariableEvent(
                        variableName: this.variableNameController.text,
                        variableType: this.variableTypeController.text));
                variableNameController.clear();
                variableTypeController.clear();
              },
              child: const Icon(
                Icons.add,
                color: eerieBlack,
              ),
              backgroundColor: gray,
            ))
      ]),
    ]);
  }

  TableRow createTableRow(String name, String type,
      {Color color = raisingBlack,
      bool isTop = false,
      bool isBottom = false,
      int rowIndice = -1}) {
    return TableRow(
        decoration: BoxDecoration(
          borderRadius: isTop
              ? BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))
              : isBottom
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))
                  : null,
          color: color,
        ),
        children: [
          GestureDetector(
            onDoubleTap: () {
              if (rowIndice != -1)
                BlocProvider.of<VariablesBloc>(context)
                    .add(DeleteVariable(variableIndex: rowIndice));
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 7.5, 12, 7.5),
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: white,
                  fontFamily: 'DMSans',
                ),
              ),
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              if (rowIndice != -1)
                BlocProvider.of<VariablesBloc>(context)
                    .add(DeleteVariable(variableIndex: rowIndice));
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(7.5),
                child: Text(
                  type,
                  style: TextStyle(
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

  BlocBuilder variablesTable() {
    return BlocBuilder<VariablesBloc, VariablesState>(
        builder: (context, state) {
      List list = state.variablesList.getVariablesList();
      return Column(
        children: [
          Table(
            border: TableBorder(
                verticalInside:
                    BorderSide(width: 1, color: gray, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            columnWidths: {
              0: FractionColumnWidth(2 / 3),
              1: FractionColumnWidth(1 / 3),
            },
            children: [
              createTableRow("Nome", "Tipo", color: gray, isTop: true),
              for (var variable in list)
                createTableRow(
                    variable.getVariableName(), variable.getVariableType(),
                    rowIndice: list.indexOf(variable),
                    isBottom: variable == list.last ? true : false),
              if (list.isEmpty) createTableRow("", "", isBottom: true)
            ],
          ),
          if (state is VariableInteractionError)
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                state.errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(color: lightCoral),
              ),
            )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.90,
            child: Text(
              'Criação de Missão',
              style: const TextStyle(color: gray, fontSize: 12.0),
            )),
        Container(
          width: MediaQuery.of(context).size.width * 0.83,
          child: Column(
            children: [
              SizedBox(height: 20),
              textInputs(),
              SizedBox(height: 20),
              variablesTable(),
            ],
          ),
        ),
      ],
    );
  }
}
