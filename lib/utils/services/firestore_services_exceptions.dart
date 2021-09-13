class NonExistingDocument implements Exception {
  @override
  String toString() {
    return "Document does not exist";
  }
}
