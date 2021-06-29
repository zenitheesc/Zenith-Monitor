class User {
  late String name; //não pode ser null
  String? imageLink; //pode ser null
  late String accessLevel; //não pode ser null

  User(String name, String? imageLink, String accessLevel) {
    this.name = _stringToPattern(name);
    this.imageLink = imageLink;
    this.accessLevel = accessLevel;
  }

  User.empty();

  String _stringToPattern(String str) {
    var list = <String>[];
    list = str.split(" ");

    list[0] = list[0][0].toUpperCase() + list[0].substring(1).toLowerCase();
    for (int i = 1; i < list.length; i++) {
      list[i] =
          " " + list[i][0].toUpperCase() + list[i].substring(1).toLowerCase();
    }
    print(list.join());
    return list.join();
  }

  void setName(String name) {
    this.name = _stringToPattern(name);
  }
}
