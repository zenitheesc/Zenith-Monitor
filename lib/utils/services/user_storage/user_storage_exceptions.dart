class StandardUserStorageError implements Exception {
  String errorMessage;

  StandardUserStorageError({required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}

class ImgFileNotFound extends StandardUserStorageError {
  ImgFileNotFound()
      : super(errorMessage: "Image file not found for the given path");
}

class ImagePickerNull extends StandardUserStorageError {
  ImagePickerNull()
      : super(errorMessage: "The image returned by ImagePicker class was null");
}
