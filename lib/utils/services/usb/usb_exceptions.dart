class StandardUsbError implements Exception {
  String errorMessage;

  StandardUsbError({required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}

class PackageModelNotDefined extends StandardUsbError {
  PackageModelNotDefined()
      : super(errorMessage: "Package model has not yet been defined");
}
