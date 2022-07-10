import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variable.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services_exceptions.dart';

class FirestoreServices {
  final StreamController<int> _statusStream;
  final StreamController<MissionVariablesList> _dataStream;

  StreamSubscription<QuerySnapshot<Object?>>? _collectionSubscription;
  MissionVariablesList? packageModel;

  FirestoreServices()
      : _statusStream = StreamController<int>(),
        _dataStream = StreamController<MissionVariablesList>();

  Future<MissionVariablesList> getPackageModel(String missionName) async {
    MissionVariablesList model = MissionVariablesList();

    Map<String, List<String>> _variables =
        await _firestoreVariablesNames(missionName);
    // Creates the variables
    for (var i = 0; i < _variables['variables']!.length; i++) {
      if (_variables['types']![i] != "Timestamp") {
        model.addStandardVariable(
            _variables['variables']![i], _variables['types']![i]);
      }
    }

    return model;
  }

  /// ---------------------------------- This part may migrate to the Mission Pipeline ----------------------------------
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
    print("Tracking mission: " + missionName);
    packageModel = await getPackageModel(missionName);
    _statusStream.add(1);
    CollectionReference _subCollectionReference = FirebaseFirestore.instance
        .collection("missoes")
        .doc(missionName)
        .collection('logs');

    _statusStream.add(1);

    /// If the tracked mission changes, the last
    /// snapshot stream must be closed.
    await _collectionSubscription?.cancel();

    /// Listen to the chages on the mission's logs
    _collectionSubscription = _subCollectionReference
        .snapshots(includeMetadataChanges: false)
        .listen((event) async {
      if (!event.metadata.isFromCache) {
        for (var change in event.docChanges) {
          //Parses the change into a missionVariablesList object
          if (change.type == DocumentChangeType.added) {
            MissionVariablesList packet =
                _documentParser(change.doc, missionName);
            _dataStream
                .add(packet); // Adds the change (aka packet) to the data stream
          }
        }
      }
    });
    _statusStream.add(10);
  }

  /// Parses a document from firestore into a `MissionVariablesList` object
  ///
  /// Gets the variables names from firestore using the `_firestoreVariablesNames`
  MissionVariablesList _documentParser(
      DocumentSnapshot document, String missionName) {
    if (packageModel == null) {
      throw EmptyPackageModel();
    }

    MissionVariablesList missionVariables = MissionVariablesList();
    List<MissionVariable> variablesList = packageModel!.getVariablesList();

    // Adds the values into the variables
    for (var i = 0; i < variablesList.length; i++) {
      String variableName = variablesList[i].getVariableName();
      if (document.get(variableName)["value"] != null) {
        variablesList[i].addValue(document.get(variableName)["value"]);
      }
    }

    missionVariables.setVariablesList(variablesList);
    return missionVariables;
  }

  /// ---------------------------------- The part `above` may migrate to the Mission Pipeline ----------------------------------
  /// --------------------------------------------------------------------------------------------------------------------------

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
      MissionVariablesList _missionVariablesObject, String missionName) async {
    if (_missionVariablesObject.getVariablesList().isEmpty) {
      throw EmptyMissionVariablesException();
    }

    packageModel = _missionVariablesObject;
    CollectionReference _missoes =
        FirebaseFirestore.instance.collection('missoes');

    List missionVariablesList = _missionVariablesObject.getVariablesList();

    Map<String, dynamic> variablesTypesMap = {};

    // Default values for creation
    for (var i = 0; i < missionVariablesList.length; i++) {
      /// Add each variable type and a default value
      switch (missionVariablesList[i].getVariableType()) {
        case "Integer":
          missionVariablesList[i].addValue(1);
          break;
        case "Double":
          missionVariablesList[i].addValue(1.001);
          break;
        case "String":
          missionVariablesList[i].addValue("1.0");
          break;
        default:
      }

      variablesTypesMap[missionVariablesList[i].getVariableName()] = {
        "type": missionVariablesList[i].getVariableType(),
        "index": i,
      };
    }

    // Adds the 'logs' collection with an example document inside
    Map<String, dynamic> firstDocMap =
        _parseMissionVariables(missionVariablesList);

    _missoes.doc(missionName).collection('logs').doc("-1").set(firstDocMap);

    variablesTypesMap["creation date"] = {
      "date": firstDocMap["timestamp"]["value"],
    };

    // Adds the variables names and types
    _missoes.doc(missionName).set(variablesTypesMap);
  }

  void uploadPackage(MissionVariablesList package, String missionName) {
    CollectionReference _missoes =
        FirebaseFirestore.instance.collection('missoes');

    Map<String, dynamic> firebasePackage =
        _parseMissionVariables(package.getVariablesList());

    _missoes
        .doc(missionName)
        .collection('logs')
        .doc(DateTime.now().microsecondsSinceEpoch.toString())
        .set(firebasePackage);
  }

  /// Parse the mission variables into a Map of type
  /// `Map<String, dynamic>` that is required at the
  /// creation of a new mission in firestore
  ///
  /// Returns -> `Map<String, dynamic>`
  Map<String, dynamic> _parseMissionVariables(List missionVariables) {
    Map<String, dynamic> variablesTypesMap = {};

    // Default values for creation
    for (var i = 0; i < missionVariables.length; i++) {
      variablesTypesMap[missionVariables[i].getVariableName()] = {
        "value": missionVariables[i].getVariableValue(),
      };
    }

    // Adding the timestamp variable to the variable types
    variablesTypesMap['timestamp'] = {
      "value": FieldValue.serverTimestamp(),
    };

    return variablesTypesMap;
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
        List<String> disorderedKeys = _mainDocReference.data()!.keys.toList();
        int nVariables = disorderedKeys.length - 1;

        List<String> types = List<String>.filled(nVariables, "");
        List<String> names = List<String>.filled(nVariables, "");

        // Gets every type from the values inside a `MissionStartDoc` document
        // and appends it to an auxilary array.
        int i = 0;
        for (var value in _mainDocReference.data()!.values) {
          if (disorderedKeys[i] != "creation date") {
            types[value['index']] = value['type'];
            names[value['index']] = disorderedKeys[i];
          }
          i++;
        }

        // Gets the variables names from a `MissionStartDoc`
        variables['variables'] = names;
        variables['types'] = types;
      }
    } on FirebaseException catch (e) {
      print(e.toString());
      throw NonExistingDocument();
    }
    return variables;
  }

  /// Get all the mission names and returns
  /// a Set<String> containing the mission names
  Future<Set<String>> getMissionNames() async {
    Set<String> _missionNames = <String>{};

    QuerySnapshot<Map<String, dynamic>> _mainCol =
        await FirebaseFirestore.instance.collection('missoes').get();

    for (var document in _mainCol.docs) {
      _missionNames.add(document.id);
    }

    return _missionNames;
  }

  Future<void> checkMissionName(String? missionName) async {
    if (missionName == null || missionName == "") {
      throw EmptyMissionNameException();
    }
    Set<String> missionNames = await getMissionNames();

    for (String name in missionNames) {
      if (missionName == name) {
        throw MissionNameAlreadyExistException();
      }
    }
  }
}
