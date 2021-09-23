import 'package:zenith_monitor/utils/helpers/string_to_pattern.dart';
import 'package:zenith_monitor/utils/helpers/link_validity.dart';

/// Until now, this class is being used by:
///   -user_profile.dart
/// If you change something, make sure that these parts are still working.

class LocalUser {
  late String _firstName;
  late String _lastName;
  String? _imageLink;
  String? _accessLevel;
  late String _email;
  DateTime? _creationDate;

  LocalUser(
      String firstName, String lastName, String? imageLink, String email) {
    _firstName = stringToPattern(firstName);
    _lastName = stringToPattern(lastName);
    _imageLink = imageLink;
    _email = email.toLowerCase();
  }

  LocalUser.fromJson(Map<String, dynamic> json)
      : _firstName = json['First Name'],
        _lastName = json['Last Name'],
        _imageLink = json['Image Link'],
        _email = json['Email'],
        _creationDate = json['Creation Date'];


  Map<String, dynamic> toJson() => {
        'First Name': _firstName,
        'Last Name': _lastName,
        'Image Link': _imageLink,
        'Email': _email,
        'Creation Date': DateTime.now().toString(),
      };

  void setAccessLevel(String accessLevel) {
    _accessLevel = stringToPattern(accessLevel);
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

  Future<String?> getImageLink() async {
    return await linkValidity(_imageLink);
  }

  String getAccessLevel() {
    if (_accessLevel == null) return "";
    return _accessLevel!;
  }

  String getEmail() {
    return _email;
  }

  DateTime? getCreationDate(){
    return _creationDate;
  }
}