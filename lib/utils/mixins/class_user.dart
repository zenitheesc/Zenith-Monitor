import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:zenith_monitor/utils/helpers/calc_text_size.dart';

class User {
  late String _name; //não pode ser null
  String? _imageLink; //pode ser null
  late String _accessLevel; //não pode ser null

  User(String name, String? imageLink, String accessLevel) {
    this._name = _stringToPattern(name);
    this._imageLink = imageLink;
    this._accessLevel = _stringToPattern(accessLevel);
  }

  String _stringToPattern(String str) {
    str = str.replaceAll(new RegExp(r'[^a-zA-Z\ ]'), '');

    var list = <String>[];
    list = str.split(" ");

    for (int i = 0; i < list.length; i++) {
      list[i] = list[i][0].toUpperCase() + list[i].substring(1).toLowerCase();
    }

    return list.join(" ");
  }

  Future<String?> _linkValidity(String? link) async {
    if (link == null) return null;

    try {
      final response = await http.get(Uri.parse(link));
      if (response.statusCode == 200)
        return link;
      else
        return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String getName() {
    return this._name;
  }

  Future<String?> getImageLink() async {
    this._imageLink = await _linkValidity(this._imageLink);
    return this._imageLink;
  }

  String getAccessLevel() {
    return this._accessLevel;
  }

  String getNameForUI(double screenWidth, double fontSize) {
    String finalName = this._name;

    Size size = calcTextSize(finalName, TextStyle(fontSize: fontSize));

    var list = <String>[];
    list = finalName.split(" ");
    int i = list.length - 1;

    while (size.width > screenWidth * 0.8 && i > 2) {
      list[i] = list[i][0] + ".";
      finalName = list.join(" ");
      size = calcTextSize(finalName, TextStyle(fontSize: fontSize));
      i--;	
    }

    return finalName;
  }
}
