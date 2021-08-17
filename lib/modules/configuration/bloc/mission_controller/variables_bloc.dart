import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_mission_variables.dart';
import 'package:zenith_monitor/pipelines/mission_pipeline/mission_bloc.dart';

part 'variables_state.dart';
part 'variables_event.dart';

/// This bloc has to do with the creation of current misson variables.
/// So, it deals with user interation in mission_creation.dart widget
/// and update the MissionVariableList object in mission pipeline.

class VariablesBloc extends Bloc<VariablesEvent, VariablesState> {
  MissionVariablesList variablesList;
  MissionBloc missionBloc;
  VariablesBloc(this.variablesList, this.missionBloc)
      : super(VariablesInitial(variablesList));

  @override
  Stream<VariablesState> mapEventToState(VariablesEvent event) async* {
    if (event is AddStandardVariableEvent) {
      try {
        variablesList
            .addStandardVariable(event.variableName, event.variableType);
        yield VariablesChanged(variablesList);
      } on VariableAlreadyExistsException {
        yield VariableInteractionError(
            variablesList, "Variável já existe");
      } on VariableTypeUnknownException {
        yield VariableInteractionError(variablesList,
            "O tipo da variável é desconhecido, tente algo como string, int ou float");
      } on EmptyVariablesException {
        yield VariableInteractionError(variablesList,
            "É necessário fornecer um nome e um tipo para a variável");
      }
    } else if (event is DeleteVariable) {
      variablesList.deleteVariable(event.variableIndex);
      yield VariablesChanged(variablesList);
    } else if (event is StartMissionEvent) {
      missionBloc.add(SetVariablesListEvent(variablesList: variablesList));
    } else {
      print("Unknown event in Variables Bloc");
    }
  }
}
