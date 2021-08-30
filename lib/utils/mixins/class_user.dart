import 'package:zenith_monitor/utils/helpers/string_to_pattern.dart';
import 'package:zenith_monitor/utils/helpers/link_validity.dart';

/// Until now, this class is being used by:
///   -user_profile.dart
/// If you change something, make sure that these parts are still working.

class LocalUser {
  late String _name;
  String? _imageLink;
  late String _accessLevel;
  late String _email;

  LocalUser(String name, String? imageLink, String accessLevel, String email) {
    _name = stringToPattern(name);
    _imageLink = imageLink;
    _accessLevel = stringToPattern(accessLevel);
    _email = email.toLowerCase();
  }

  String getName() {
    return _name;
  }

  Future<String?> getImageLink() async {
    return await linkValidity(_imageLink);
  }

  String getAccessLevel() {
    return _accessLevel;
  }

  String getEmail() {
    return _email;
  }
}
