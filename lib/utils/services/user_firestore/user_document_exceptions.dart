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
