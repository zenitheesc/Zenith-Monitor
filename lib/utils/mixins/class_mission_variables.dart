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

  void addStandardVariable(String name, String type) {
    if (name.isEmpty || type.isEmpty) throw new EmptyVariablesException();

    type = stringToPattern(type);

    if (this.contains(name)) throw new VariableAlreadyExistsException();

    if (integerNames.contains(type)) {
      this._list.add(MissionVariable<int>(name, "Integer"));
    } else if (floatNames.contains(type)) {
      this._list.add(MissionVariable<Float>(name, "Float"));
    } else if (stringNames.contains(type)) {
      this._list.add(MissionVariable<String>(name, "String"));
    } else {
      throw new VariableTypeUnknownException();
    }
  }

  void addAbstractVariable(MissionVariable m) {
    if (this.contains(m.getVariableName()))
      throw new VariableAlreadyExistsException();

    this._list.add(m);
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

  void deleteVariable(int index) {
    if (index < 0 || index >= this._list.length) return;

    this._list.removeAt(index);
  }
}

class VariableAlreadyExistsException implements Exception {
  @override
  String toString() {
    return "Variable already exists";
  }
}

class VariableTypeUnknownException implements Exception {
  @override
  String toString() {
    return "The variable type does not match any of the record";
  }
}

class EmptyVariablesException implements Exception {
  @override
  String toString() {
    return "Variable's name or type is empty";
  }
}
