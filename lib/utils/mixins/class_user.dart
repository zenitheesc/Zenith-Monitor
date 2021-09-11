import 'package:zenith_monitor/utils/helpers/string_to_pattern.dart';
import 'package:zenith_monitor/utils/helpers/link_validity.dart';

/// Until now, this class is being used by:
///   -user_profile.dart
/// If you change something, make sure that these parts are still working.

class LocalUser {
  late String _name;
  String? _imageLink;
  String? _accessLevel;
  late String _email;

  LocalUser(String name, String? imageLink, String email) {
    _name = stringToPattern(name);
    _imageLink = imageLink;
    _email = email.toLowerCase();
  }

  void setAccessLevel(String accessLevel) {
    _accessLevel = stringToPattern(accessLevel);
  }

  String getName() {
    return _name;
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
}
