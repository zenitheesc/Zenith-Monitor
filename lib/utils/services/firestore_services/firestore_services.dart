import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services_exceptions.dart';

class FirestoreServices {
  final _statusStream = StreamController<int>();
  late CollectionReference _subCollectionReference;
  final _dataStream = StreamController<MissionVariablesList>();

  /// A stream to listen to changes in a mission data
  Stream<MissionVariablesList> recive() {
    return _dataStream.stream;
  }

  /// Initialize the Firestore Services with a specific
  /// mission name.
  ///
  /// Initialize a stream to be able to listen for changes in documents
  /// or new documents. To get the stream use the `recive()` method.
  Future<void> init(String missionName) async {
    _statusStream.add(1);
    _subCollectionReference = FirebaseFirestore.instance
        .collection("missoes")
        .doc(missionName)
        .collection('logs');

    _statusStream.add(1);

    /// Listen to the chages on the mission's logs
    _subCollectionReference
        .snapshots(includeMetadataChanges: false)
        .listen((event) async {
      for (var change in event.docChanges) {
        //Parses the change into a missionVariablesList object
        MissionVariablesList packet =
            await _documentParser(change.doc, missionName);
        _dataStream
            .add(packet); // Adds the change (aka packet) to the data stream
      }
    });
    _statusStream.add(10);
  }

  /// Parses a document from firestore into a `MissionVariablesList` object
  ///
  /// Gets the variables names from firestore using the `_firestoreVariablesNames`
  Future<MissionVariablesList> _documentParser(
      DocumentSnapshot document, String missionName) async {
    MissionVariablesList missionVariables = MissionVariablesList();

    // Get variables names and types
    Map<String, List<String>> _variables =
        await _firestoreVariablesNames(missionName);

    // print(_variables);

    // Creates the variables
    for (var i = 0; i < _variables['variables']!.length; i++) {
      // print(_variables['variables']![i]);
      // print(_variables['types']![i]);
      missionVariables.addStandardVariable(
          _variables['variables']![i], _variables['types']![i]);
    }

    // Get individual variables to be able to assign the document
    // values to them
    List missionVariablesList = missionVariables.getVariablesList();

    // Adds the values into the variables
    for (var i = 0; i < missionVariablesList.length; i++) {
      missionVariablesList[i].addValue(
          document.get(missionVariablesList[i].getVariableName())['value']);
    }

    return missionVariables;
  }

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

    // Adds the variables names and types
    _missoes
        .doc(_missionVariablesObject.getMissionName())
        .set(mappedMissionVariables);

    // Adds the 'logs' collection with an empty document inside
    _missoes
        .doc(_missionVariablesObject.getMissionName())
        .collection('logs')
        .add(mappedMissionVariables);
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
        case "Double":
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
  /// Gets the variables `names` and `types` from the document stored
  /// in firestore with the name `MissionStartDoc` that is created when a
  /// new mission has been created. It's used in the `mission_variable` class;
  ///
  /// Returns -> `Map<String, List<String>>`
  Future<Map<String, List<String>>> _firestoreVariablesNames(
      String missionName) async {
    final Map<String, List<String>> variables = {};

    try {
      DocumentSnapshot<Map<String, dynamic>> _mainDocReference =
          await FirebaseFirestore.instance
              .collection('missoes')
              .doc(missionName)
              .get();

      if (_mainDocReference.exists) {
        List<String> helper = [];

        // Gets every type from the values inside a `MissionStartDoc` document
        // and appends it to an auxilary array.
        for (var value in _mainDocReference.data()!.values) {
          helper.add(value['type']);
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

  Future<List<String>> getMissionNames() async {
    List<String> _missionNames = [];

    QuerySnapshot<Map<String, dynamic>> _mainCol =
        await FirebaseFirestore.instance.collection('missoes').get();

    for (var document in _mainCol.docs) {
      _missionNames.add(document.id);
    }

    return _missionNames;
  }
}
