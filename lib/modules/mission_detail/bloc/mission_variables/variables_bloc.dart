import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_mission_variables.dart';

part 'variables_state.dart';
part 'variables_event.dart';

class VariablesBloc extends Bloc<VariablesEvent, VariablesState> {
  MissionVariablesList variablesList;
  VariablesBloc(this.variablesList)
      : super(VariablesInitial(variablesList: variablesList));

  @override
  Stream<VariablesState> mapEventToState(VariablesEvent event) async* {
    if (event is AddStandardVariableEvent) {
      this
          .variablesList
          .addStandardVariable(event.variableName, event.variableType);
      yield VariablesAdded(variablesList: this.variablesList);
    }
    //throw UnimplementedError();
  }
}
