import 'package:flutter/painting.dart';

import 'package:zenith_monitor/utils/helpers/calc_text_size.dart';
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

  /// The getNameForUI method takes the font size that will be used
  /// in a widget and the window width. Based on this, the method will
  /// shorten the username until the space occupied is less than 80% of
  /// the screen width. The abbreviation will be from the last surname
  /// to the third name. Then the short name will be returned.

  String getNameForUI(double screenWidth, double fontSize) {
    String finalName = this._name;

    Size size = calcTextSize(finalName, TextStyle(fontSize: fontSize));

    var list = <String>[];
    list = finalName.split(" ");
    int i = list.length - 1;

    while (size.width > screenWidth * 0.8) {
      if (i > 0) {
        list[i] = list[i][0] + ".";
        i--;
      } else if (list.length > 2) {
        /// If the method hits the second name, the last names will be removed. Feel free to implement a better approach
        list.removeLast();
      } else {
        break;
      }

      finalName = list.join(" ");
      size = calcTextSize(finalName, TextStyle(fontSize: fontSize));
    }

    return finalName;
  }
}
