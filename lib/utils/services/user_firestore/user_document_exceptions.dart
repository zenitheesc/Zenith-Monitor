class StandardUserDocError implements Exception {
  String errorMessage;

  StandardUserDocError({required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}

class NullUser extends StandardUserDocError {
  NullUser() : super(errorMessage: "The current user is null");
}

class EmailNotVerified extends StandardUserDocError {
  EmailNotVerified()
      : super(errorMessage: "The user has not yet authenticated his email");
}

class UserFileNotFound extends StandardUserDocError {
  UserFileNotFound()
      : super(errorMessage: "User information not found in local storage");
}

class NullUserCredential extends StandardUserDocError {
  NullUserCredential()
      : super(errorMessage: "The provided UserCredential was null");
}

class FirebaseProblem extends StandardUserDocError {
  bool isFirebaseException;
  String errorMsg;

  FirebaseProblem({required this.isFirebaseException, required this.errorMsg})
      : super(
            errorMessage:
                "An error occurred during firebase interaction: " + errorMsg);

  String errorType() {
    return isFirebaseException
        ? "The error was a FirebaseException and it's message is: " + errorMsg
        : "Wasn't a FirebaseException, the error is: " + errorMsg;
  }
}
