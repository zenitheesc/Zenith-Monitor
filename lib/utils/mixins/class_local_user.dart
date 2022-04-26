import 'package:zenith_monitor/utils/helpers/string_to_pattern.dart';

/// Until now, this class is being used by:
///   -user_profile.dart
/// If you change something, make sure that these parts are still working.

class LocalUser {
  late String _firstName;
  late String _lastName;
  String? _imageLink;
  String? _imagePath;
  String? _accessLevel;
  late String _email;

  LocalUser(String firstName, String lastName, String email,
      {String? imageLink, String? imagePath}) {
    setFirstName(firstName);
    setLastName(lastName);
    setImageLink(imageLink);
    setImagePath(imagePath);
    setEmail(email);
  }

  LocalUser.fromJson(Map<String, dynamic> json)
      : _firstName = json['First Name'],
        _lastName = json['Last Name'],
        _imageLink = json['Image Link'],
        _imagePath = json['Image Path'],
        _email = json['Email'];

  Map<String, dynamic> toJson() => {
        'First Name': _firstName,
        'Last Name': _lastName,
        'Image Link': _imageLink,
        'Image Path': _imagePath,
        'Email': _email,
      };

  void setAccessLevel(String accessLevel) {
    _accessLevel = stringToPattern(accessLevel);
  }

  void setFirstName(String firstName) {
    _firstName = stringToPattern(firstName);
  }

  void setLastName(String lastName) {
    _lastName = stringToPattern(lastName);
  }

  void setImageLink(String? imageLink) {
    _imageLink = imageLink;
  }

  void setImagePath(String? imagePath) {
    _imagePath = imagePath;
  }

  void setEmail(String email) {
    _email = (email.toLowerCase()).trim();
  }

  String getFirstName() {
    return _firstName;
  }

  String getLastName() {
    return _lastName;
  }

  String getCompleteName() {
    return _firstName + " " + _lastName;
  }

  String? getImageLink() {
    return _imageLink;
  }

  String? getImagePath() {
    return _imagePath;
  }

  String getAccessLevel() {
    if (_accessLevel == null) return "";
    return _accessLevel!;
  }

  String getEmail() {
    return _email;
  }

  void copyUserFrom(LocalUser origin) {
    setFirstName(origin.getFirstName());
    setLastName(origin.getLastName());
    setEmail(origin.getEmail());
    setImageLink(origin.getImageLink());
    setImagePath(origin.getImagePath());
    setAccessLevel(origin.getAccessLevel());
  }
}
