class StandardAuthError implements Exception {
  String errorMessage;

  StandardAuthError({required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}

class WeakPassword extends StandardAuthError {
  WeakPassword() : super(errorMessage: "The password provided is too weak");
}

class EmailAlreadyInUse extends StandardAuthError {
  EmailAlreadyInUse()
      : super(errorMessage: "A account already exists for that email");
}

class WrongPassword extends StandardAuthError {
  WrongPassword()
      : super(
            errorMessage:
                "The password is invalid or the user does not have a password");
}

class UserNotFound extends StandardAuthError {
  UserNotFound()
      : super(
            errorMessage:
                "There is no user record corresponding to this identifier. The user may have been deleted");
}

class EmailBadlyFormatted extends StandardAuthError {
  EmailBadlyFormatted()
      : super(errorMessage: "The email address is badly formatted");
}

class AnotherCredentialUsed extends StandardAuthError {
  AnotherCredentialUsed()
      : super(errorMessage: "Account exists with different credential");
}
