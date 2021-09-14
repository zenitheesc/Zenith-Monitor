import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/services/firestore_services_exceptions.dart';

class FirestoreServices {
  void createAndUploadMission(
      MissionVariablesList _missionVariablesObject) async {
    if (_missionVariablesObject.getVariablesList().isEmpty) {
      throw EmptyMissionVariablesException();
    }

    CollectionReference _missoes =
        FirebaseFirestore.instance.collection('missoes');

    List missionVariablesList = _missionVariablesObject.getVariablesList();

    // Trying to parse variables list
    Map<String, dynamic> mappedMissionVariables = {};
    for (var i = 0; i < missionVariablesList.length; i++) {
      mappedMissionVariables[missionVariablesList[i].getVariableName()] = {
        "type": missionVariablesList[i].getVariableType().toString(),
        "value": "Null"
      };
    }

    _missoes
        .doc(_missionVariablesObject.getMissionName())
        .collection('logs')
        .add(mappedMissionVariables);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> downloadFirestoreMissionData(
      String missionName) async {
    final Future<QuerySnapshot<Map<String, dynamic>>> _subCollectionReference =
        FirebaseFirestore.instance
            .collection('missoes')
            .doc(missionName)
            .collection('logs')
            .get();

    return _subCollectionReference;
  }

  /// `Async` method, use with `await`.
  ///
  /// Gets the variables names and types from the firestore to be used in the
  /// `mission_variable` class;
  ///
  /// Returns -> `Map<String, List<String>>`
  Future<Map<String, List<String>>> firestoreVariablesNames(
      String missionName) async {
    final Map<String, List<String>> variables = {};

    try {
      Future<QuerySnapshot<Map<String, dynamic>>> _mainColReference =
          FirebaseFirestore.instance
              .collection('missoes')
              .doc(missionName)
              .collection('logs')
              .get();

      await _mainColReference.then((document) async {
        List<String> helper = [];
        document.docs[0].data().values.forEach((value) {
          helper.add(value.runtimeType.toString());
        });
        variables['variables'] = document.docs[0].data().keys.toList();
        variables['types'] = helper;
      });
    } on FirebaseException catch (e) {
      print(e.toString());
      throw NonExistingDocument();
    }
    print(variables['variables']);
    print(variables['types']);

    return variables;
  }
}
