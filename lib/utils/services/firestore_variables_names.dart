import 'package:cloud_firestore/cloud_firestore.dart';

/// Gets the variables names and types from the firestore to be used in the
/// `mission_variable` class
///
/// Returns a Map object of types `String` and `List<String>`
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

  return variables;
}

class NonExistingDocument implements Exception {
  @override
  String toString() {
    return "Document does not exist";
  }
}
