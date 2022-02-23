//import 'dart:ffi';
import 'package:zenith_monitor/utils/helpers/string_to_pattern.dart';
import 'package:zenith_monitor/constants/variables_types.dart';
import 'class_mission_variable.dart';
import 'mission_variables_exceptions.dart';

class MissionVariablesList {
  late List<MissionVariable> _list;
  late String _missionName;

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
      //_list.add(MissionVariable<Float>(name, "Float"));
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

  void addMissionName(String? missionName) {
    /// Posteriormente podemos deixar esse método
    /// assincrono e fazer uma checagem no firebase
    /// para verificar se o nome dessa missão já existe.
    /// Acho melhor esperar o serviço dos documentos do
    /// firebase ser finalizado. Já há uma exception para
    /// esse erro, chamada MissionNameAlreadyExistException

    if (missionName == null || missionName == "") {
      throw EmptyMissionNameException();
    }

    _missionName = missionName;
  }

  String getMissionName() {
    return _missionName;
  }
}
