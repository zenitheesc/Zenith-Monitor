import 'package:cloud_firestore/cloud_firestore.dart';

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
      _list.add(MissionVariable<double>(name, "Double"));
    } else if (stringNames.contains(type)) {
      _list.add(MissionVariable<String>(name, "String"));
    } else if (timestampNames.contains(type)) {
      _list.add(MissionVariable<Timestamp>(name, "Timestamp"));
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

  Future<void> addMissionName(String? missionName) async {
    if (missionName == null || missionName == "") {
      throw EmptyMissionNameException();
    }

    /// Implementacao da checagem no firebase se o nome da missao
    /// ja existe. Pega a colecao de missoes e verifica os nome dos
    /// documentos (id) com o nome da missao (missionName);
    /// Se o nome existe ele joga a excecao `MissionNameAlreadyExistException`
    Future<QuerySnapshot<Map<String, dynamic>>> _mainColReference =
        FirebaseFirestore.instance.collection('missoes').get();

    await _mainColReference.then((documents) async {
      for (DocumentSnapshot eachDocument in documents.docs) {
        if (eachDocument.id == missionName) {
          throw MissionNameAlreadyExistException();
        }
      }
    });

    _missionName = missionName;
  }

  String getMissionName() {
    return _missionName;
  }
}
