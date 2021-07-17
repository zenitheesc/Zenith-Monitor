import 'package:zenith_monitor/utils/helpers/string_to_pattern.dart';

List<String> integerNames = ["Inteiro", "Int", "Integer"];
List<String> floatNames = ["Real", "Reais", "Float"];

class MissionVariable<T> {
  late String _variableName;
  late String _variableType;

  MissionVariable(String variableName, String variableType) {
    this._variableName = stringToPattern(variableName);
    this._variableType = stringToPattern(variableType);
  }

  String getVariableName() {
    return this._variableName;
  }

  String getVariableType() {
    return this._variableType;
  }
}

class MissionVariablesList {
  List<MissionVariable> _list = [];

  bool addVariable(MissionVariable m) {
    if (this.contains(m)) return false;

    if (integerNames.contains(m.getVariableType())) {
      this._list.add(MissionVariable<int>(m.getVariableName(), "Inteiro"));
      return true;
    } else if (floatNames.contains(m.getVariableType())) {
      this._list.add(MissionVariable<int>(m.getVariableName(), "Real"));
      return true;
    }

    return false;
  }

  bool contains(MissionVariable m) {
    for (var i = 0; i < this._list.length; i++) {
      if (this._list[i].getVariableName() == m.getVariableName()) return true;
    }
    return false;
  }
}
