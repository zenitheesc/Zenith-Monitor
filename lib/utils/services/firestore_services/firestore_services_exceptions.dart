class NonExistingDocument implements Exception {
  @override
  String toString() {
    return "Document does not exist";
  }
}

class EmptyMissionVariablesException implements Exception {
  @override
  String toString() {
    return "VariablesList is empty";
  }
}
