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

class EmptyMissionNameException implements Exception {
  @override
  String toString() {
    return "Mission's name variable is empty";
  }
}

class MissionNameAlreadyExistException implements Exception {
  @override
  String toString() {
    return "Mission's name already exist";
  }
}

class EmptyPackageModel implements Exception {
  @override
  String toString() {
    return "The packageModel variable is null";
  }
}
