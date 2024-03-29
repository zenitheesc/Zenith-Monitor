import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/configuration/bloc/mission_controller/mission_variables_bloc.dart';
import 'package:zenith_monitor/utils/helpers/show_dialog_function.dart';

class MissionCreation extends StatefulWidget {
  const MissionCreation({Key? key}) : super(key: key);

  @override
  _MissionCreationState createState() => _MissionCreationState();
}

class _MissionCreationState extends State<MissionCreation> {
  TextEditingController variableNameController = TextEditingController();
  TextEditingController variableTypeController = TextEditingController();
  TextEditingController missionNameController = TextEditingController();

  MissionVariablesBloc? _missionVariablesBloc;

  TextField textField(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(
          color: white, fontWeight: FontWeight.normal, fontFamily: 'DMSans'),
      cursorColor: white,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 8.5, 12, 8.5),
          isDense: true,
          hintStyle: const TextStyle(color: gray),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: gray),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: gray),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: hintText),
    );
  }

  Widget textInputs() {
    return Table(columnWidths: const {
      1: FractionColumnWidth(0.03),
      2: FractionColumnWidth(0.25),
      3: FractionColumnWidth(0.15)
    }, children: [
      TableRow(children: [
        textField('Inserir novo campo', variableNameController),
        const SizedBox(width: 10),
        textField('Tipo', variableTypeController),
        Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
              height: 30,
              width: 30,
              child: FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<MissionVariablesBloc>(context).add(
                      AddStandardVariableEvent(
                          variableName: variableNameController.text,
                          variableType: variableTypeController.text));
                  variableNameController.clear();
                  variableTypeController.clear();
                },
                child: const Icon(
                  Icons.add,
                  color: eerieBlack,
                ),
                backgroundColor: gray,
              )),
        )
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
              if (rowIndice != -1) {
                BlocProvider.of<MissionVariablesBloc>(context)
                    .add(DeleteVariable(variableIndex: rowIndice));
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
              if (rowIndice != -1) {
                BlocProvider.of<MissionVariablesBloc>(context)
                    .add(DeleteVariable(variableIndex: rowIndice));
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

  BlocBuilder variablesTable() {
    late String message;
    return BlocBuilder<MissionVariablesBloc, MissionVariablesState>(
        builder: (context, state) {
      message = (state is VariableInteractionError) ? state.errorMessage : "";
      List list = context.select(
          (MissionVariablesBloc bloc) => bloc.variablesList.getVariablesList());
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
              createTableRow("Nome", "Tipo", color: gray, isTop: true),
              for (int i = 1; i < list.length; i++)
                createTableRow(
                    list[i].getVariableName(), list[i].getVariableType(),
                    rowIndice: i,
                    isBottom: i == list.length - 1 ? true : false),
              if (list.length == 1) createTableRow("", "", isBottom: true)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Container(
              height: 32,
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: lightCoral),
              ),
            ),
          )
        ],
      );
    });
  }

  Widget startMissionButton() {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) return Colors.green;
                return mantisGreen;
              },
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ))),
        onPressed: () {
          BlocProvider.of<MissionVariablesBloc>(context).add(StartMissionEvent(
              missionName: missionNameController.text,
              ignoreLocationVar: false));
        },
        child: const Text(
          "Iniciar Missão",
          style: TextStyle(
            fontWeight: FontWeight.w200,
            color: white,
            fontFamily: 'DMSans',
          ),
        ),
      ),
    );
  }

  Column missionNameInput() {
    late String message;
    return Column(
      children: [
        textField("Nome da Missão", missionNameController),
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Container(
            height: 32,
            child: BlocBuilder<MissionVariablesBloc, MissionVariablesState>(
                builder: (context, state) {
              message = (state is MissionNameError) ? state.errorMessage : "";
              return Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: lightCoral),
              );
            }),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _missionVariablesBloc = BlocProvider.of<MissionVariablesBloc>(context);
    _missionVariablesBloc?.stream.listen(((event) {
      if (event is PackageWoLocationVar) {
        showDialogFunction(
            context,
            "Erro",
            "Para rastrear a sonda, é necessário ter uma variável chamada 'Latitude' e outra chamada 'Longitude'.",
            [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: (() {
                        _missionVariablesBloc?.add(StartMissionEvent(
                            missionName: event.missionName,
                            ignoreLocationVar: true));
                        missionNameController.clear();
                        Navigator.pop(context);
                      }),
                      child: const Text("Manter sem as variaveis",
                          style: TextStyle(color: white))),
                  TextButton(
                      onPressed: (() {
                        missionNameController.clear();
                        Navigator.pop(context);
                      }),
                      child: const Text("Ok, irei adicionar",
                          style: TextStyle(color: white)))
                ],
              )
            ]);
      }
    }));

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.83,
          child: Column(
            children: [
              textInputs(),
              const SizedBox(height: 20),
              variablesTable(),
              const SizedBox(height: 5),
              missionNameInput(),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.bottomRight,
                child: startMissionButton(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
