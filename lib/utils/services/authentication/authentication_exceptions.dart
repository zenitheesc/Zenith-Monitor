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
