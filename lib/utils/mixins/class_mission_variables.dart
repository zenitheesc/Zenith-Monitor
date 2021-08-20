import 'dart:ffi';
import 'package:zenith_monitor/utils/helpers/string_to_pattern.dart';
import 'package:zenith_monitor/constants/variables_types.dart';

class MissionVariable<T> {
  late String _variableName;
  late String _variableType;
  T? _variableValue;

  MissionVariable(String variableName, String variableType) {
    _variableName = variableName;
    _variableType = stringToPattern(variableType);
    _variableValue = null;
  }

  String getVariableName() {
    return _variableName;
  }

  String getVariableType() {
    return _variableType;
  }

  T? getVariableValue() {
    return _variableValue;
  }

  void addValue(T value) {
    _variableValue = value;
  }
}

class MissionVariablesList {
  late List<MissionVariable> _list;

  MissionVariablesList() {
    _list = [];
  }

  void addStandardVariable(String name, String type) {
    if (name.isEmpty || type.isEmpty) throw EmptyVariablesException();

    type = stringToPattern(type);

    if (contains(name)) throw VariableAlreadyExistsException();

    if (integerNames.contains(type)) {
      _list.add(MissionVariable<int>(name, "Integer"));
    } else if (floatNames.contains(type)) {
      _list.add(MissionVariable<Float>(name, "Float"));
    } else if (stringNames.contains(type)) {
      _list.add(MissionVariable<String>(name, "String"));
    } else {
      throw VariableTypeUnknownException();
    }
  }

  void addAbstractVariable(MissionVariable m) {
    if (contains(m.getVariableName())) {
      throw VariableAlreadyExistsException();
    }

    _list.add(m);
  }

  bool contains(String name) {
    for (var i = 0; i < _list.length; i++) {
      if (_list[i].getVariableName() == name) return true;
    }
    return false;
  }

  List getVariablesList() {
    return _list;
  }

  void deleteVariable(int index) {
    if (index < 0 || index >= _list.length) return;

    _list.removeAt(index);
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
