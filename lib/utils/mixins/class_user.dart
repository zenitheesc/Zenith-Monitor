import 'package:http/http.dart' as http;

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

    list[0] = list[0][0].toUpperCase() + list[0].substring(1).toLowerCase();
    for (int i = 1; i < list.length; i++) {
      list[i] =
          " " + list[i][0].toUpperCase() + list[i].substring(1).toLowerCase();
    }

    return list.join();
  }

  Future<String?> _linkValidity(String? link) async {
    if (link == null) return null;

    final response = await http.get(Uri.parse(link));

    if (response.statusCode == 200) return link;

    return null;
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
}
