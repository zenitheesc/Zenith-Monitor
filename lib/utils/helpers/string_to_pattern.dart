/// The stringToPattern function takes a string, removes all special characters and
/// numbers, and change the first letter of each word to uppercase. This can be used mainly
/// to format names.

String stringToPattern(String str) {
  str = str.replaceAll(new RegExp(r'[^a-zA-Z\ ]'), '');

  var list = <String>[];

  /// The words are determinated by the space character.
  list = str.split(" ");
  list.removeWhere((element) => element == "");

  for (int i = 0; i < list.length; i++) {
    list[i] = list[i][0].toUpperCase() + list[i].substring(1).toLowerCase();
  }

  return list.join(" ");
}
