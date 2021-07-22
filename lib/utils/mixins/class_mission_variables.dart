import 'dart:ffi';
import 'package:zenith_monitor/utils/helpers/string_to_pattern.dart';
import 'package:zenith_monitor/constants/variables_types.dart';

class MissionVariable<T> {
  late String _variableName;
  late String _variableType;
  late List<T> _variableList;

  MissionVariable(String variableName, String variableType) {
    this._variableName = variableName;
    this._variableType = stringToPattern(variableType);
    this._variableList = [];
  }

  String getVariableName() {
    return this._variableName;
  }

  String getVariableType() {
    return this._variableType;
  }

  void addValue(T value) {
    this._variableList.add(value);
  }
}

class MissionVariablesList {
  late List<MissionVariable> _list;

  MissionVariablesList() {
    this._list = [];
  }

  bool addStandardVariable(String name, String type) {
    type = stringToPattern(type);

    if (this.contains(name)) return false;

    if (integerNames.contains(type)) {
      this._list.add(MissionVariable<int>(name, "Inteiro"));
      return true;
    } else if (floatNames.contains(type)) {
      this._list.add(MissionVariable<Float>(name, "Float"));
      return true;
    } else if (stringNames.contains(type)) {
      this._list.add(MissionVariable<String>(name, "String"));
      return true;
    }

    return false;
  }

  bool addAbstractVariable(MissionVariable m) {
    if (this.contains(m.getVariableName())) return false;

    this._list.add(m);
    return true;
  }

  bool contains(String name) {
    for (var i = 0; i < this._list.length; i++) {
      if (this._list[i].getVariableName() == name) return true;
    }
    return false;
  }

  List getVariablesList() {
    return this._list;
  }
}
