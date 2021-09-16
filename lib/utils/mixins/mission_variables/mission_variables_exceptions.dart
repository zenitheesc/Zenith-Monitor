/// This file contains all the exceptions related to
/// the creation of new variables inside mission varibles
/// class.

class VariableAlreadyExistsException implements Exception {
  @override
  String toString() {
    return "Variable already exists";
  }
}

class VariableTypeUnknownException implements Exception {
  @override
  String toString() {
    return "The variable type does not match any of the record";
  }
}

class EmptyVariablesException implements Exception {
  @override
  String toString() {
    return "Variable's name or type is empty";
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
