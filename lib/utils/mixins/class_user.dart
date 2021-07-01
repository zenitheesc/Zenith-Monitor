import 'package:zenith_monitor/utils/helpers/string_to_pattern.dart';
import 'package:zenith_monitor/utils/helpers/link_validity.dart';

/// Until now, this class is being used by:
///   -user_profile.dart
/// If you change something, make sure that these parts are still working.

class User {
  late String _name;
  String? _imageLink;
  late String _accessLevel;

  User(String name, String? imageLink, String accessLevel) {
    this._name = stringToPattern(name);
    this._imageLink = imageLink;
    this._accessLevel = stringToPattern(accessLevel);
  }

  String getName() {
    return this._name;
  }

  Future<String?> getImageLink() async {
    return await linkValidity(this._imageLink);
  }

  String getAccessLevel() {
    return this._accessLevel;
  }
}
