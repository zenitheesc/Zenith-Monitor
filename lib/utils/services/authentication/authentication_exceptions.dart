class WeakPassword implements Exception {
  @override
  String toString() {
    return "The password provided is too weak";
  }
}

class EmailAlreadyInUse implements Exception {
  @override
  String toString() {
    return "The account already exists for that email";
  }
}

class WrongPassword implements Exception {
  @override
  String toString() {
    return "The password is invalid or the user does not have a password";
  }
}

class UserNotFound implements Exception {
  @override
  String toString() {
    return "There is no user record corresponding to this identifier. The user may have been deleted";
  }
}
