import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_mission_variables.dart';

part 'variables_state.dart';
part 'variables_event.dart';

class VariablesBloc extends Bloc<VariablesEvent, VariablesState> {
  MissionVariablesList variablesList;
  VariablesBloc(this.variablesList) : super(VariablesInitial(variablesList));

  @override
  Stream<VariablesState> mapEventToState(VariablesEvent event) async* {
    if (event is AddStandardVariableEvent) {
      try {
        this
            .variablesList
            .addStandardVariable(event.variableName, event.variableType);
        yield VariablesChanged(this.variablesList);
      } on VariableAlreadyExistsException {
        yield VariableInteractionError(
            this.variablesList, "Variável já existe");
      } on VariableTypeUnknownException {
        yield VariableInteractionError(this.variablesList,
            "O tipo da variável é desconhecido, tente algo como string, int ou float");
      } on EmptyVariablesException {
        yield VariableInteractionError(this.variablesList,
            "É necessário fornecer um nome e um tipo para a variável");
      }
    } else if (event is DeleteVariable) {
      this.variablesList.deleteVariable(event.variableIndex);
      yield VariablesChanged(this.variablesList);
    }
  }
}
