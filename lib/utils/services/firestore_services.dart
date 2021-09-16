import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/services/firestore_services_exceptions.dart';

class FirestoreServices {
  /// Creates a mission document on firestore. Receives a
  /// missionVariablesObject and proceeds to parse it's information
  /// creating a Map of type `Map<String, dynamic>`. The path of the new
  /// mission is: `missoes/$(missionName)/logs/MissionStartDoc`.
  /// 
  /// The Document `MissionStartDoc` is created with the purpose of being a way
  /// to get, in the future, all of the document's names and types, to be used into
  /// a `mission_variables` class. 
  ///
  /// e.g. {testVariable: {"type": variableType, "value": variableValue}}
  void createAndUploadMission(
      MissionVariablesList _missionVariablesObject) async {
    if (_missionVariablesObject.getVariablesList().isEmpty) {
      throw EmptyMissionVariablesException();
    }

    CollectionReference _missoes =
        FirebaseFirestore.instance.collection('missoes');

    List missionVariablesList = _missionVariablesObject.getVariablesList();

    Map<String, dynamic> mappedMissionVariables =
        _parseMissionVariables(missionVariablesList);

    _missoes
        .doc(_missionVariablesObject.getMissionName())
        .collection('logs')
        .doc('MissionStartDoc')
        .set(mappedMissionVariables);
  }

  /// Parse the mission variables into a Map of type
  /// `Map<String, dynamic>` that is required at the
  /// creation of a new mission in firestore
  ///
  /// Returns -> `Map<String, dynamic>`
  Map<String, dynamic> _parseMissionVariables(List missionVariables) {
    Map<String, dynamic> mappedMissionVariables = {};

    dynamic valueToBeApplyed;

    for (var i = 0; i < missionVariables.length; i++) {
      switch (missionVariables[i].getVariableType()) {
        case "Integer":
          valueToBeApplyed = 1;
          break;
        case "Float":
          valueToBeApplyed = 1.001;
          break;
        case "String":
          valueToBeApplyed = "1.0";
          break;
        default:
      }

      mappedMissionVariables[missionVariables[i].getVariableName()] = {
        "type": missionVariables[i].getVariableType().toString(),
        "value": valueToBeApplyed
      };
    }

    return mappedMissionVariables;
  }

  /// `Async` method, use with `await`.
  ///
  /// Downloads a QuerySnapshot of documents from a certain mission
  ///
  /// Returns -> `QuerySnapshot<Map<String, dynamic>>`
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
  /// Gets the variables `names` and `types` from the document stored
  /// in firestore with the name `MissionStartDoc` that is created when a
  /// new mission has been created. It's used in the `mission_variable` class;
  ///
  /// Returns -> `Map<String, List<String>>`
  Future<Map<String, List<String>>> firestoreVariablesNames(
      String missionName) async {
    final Map<String, List<String>> variables = {};

    try {
      DocumentSnapshot<Map<String, dynamic>> _mainDocReference =
          await FirebaseFirestore.instance
              .collection('missoes')
              .doc(missionName)
              .collection('logs')
              .doc('MissionStartDoc')
              .get();

      if (_mainDocReference.exists) {
        List<String> helper = [];

        // Gets every type from the values inside a `MissionStartDoc` document
        // and appends it to an auxilary array.
        for (var value in _mainDocReference.data()!.values) {
          helper.add(value.runtimeType.toString());
        }

        // Gets the variables names from a `MissionStartDoc`
        variables['variables'] = _mainDocReference.data()!.keys.toList(); 
        variables['types'] = helper;
      }
    } on FirebaseException catch (e) {
      print(e.toString());
      throw NonExistingDocument();
    }
    return variables;
  }
}
