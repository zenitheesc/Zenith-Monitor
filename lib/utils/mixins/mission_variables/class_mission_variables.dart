import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zenith_monitor/utils/helpers/string_to_pattern.dart';
import 'package:zenith_monitor/constants/variables_types.dart';
import 'class_mission_variable.dart';
import 'mission_variables_exceptions.dart';

class MissionVariablesList {
  //In the future, a Set should be used over a List type
  late List<MissionVariable> _list;

  MissionVariablesList() {
    _list = [];
    // Adding standard and required variables
    _list.add(MissionVariable<Timestamp>("timestamp", "Timestamp"));
  }

  void addStandardVariable(String name, String type) {
    if (name.isEmpty || type.isEmpty) throw EmptyVariablesException();

    name = name.trim();
    type = stringToPattern(type);

    if (contains(name)) throw VariableAlreadyExistsException();

    if (integerNames.contains(type)) {
      _list.add(MissionVariable<int>(name, "Integer"));
    } else if (floatNames.contains(type)) {
      _list.add(MissionVariable<double>(name, "Double"));
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

  List<MissionVariable> getVariablesList() {
    return _list;
  }

  void setVariablesList(List<MissionVariable> newList) {
    _list = List.from(newList);
  }

  void deleteVariable(int index) {
    if (index < 0 || index >= _list.length) return;

    _list.removeAt(index);
  }

  MissionVariable? getVariable(String variableName) {
    for (var i = 0; i < _list.length; i++) {
      if (_list[i].getVariableName() == variableName) return _list[i];
    }
    return null;
  }
}
