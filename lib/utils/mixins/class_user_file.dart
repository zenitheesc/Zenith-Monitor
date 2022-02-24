import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';

class UserFile {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);
    return File('$path/local_user.json');
  }

  Future<File> writeUser(LocalUser newUser) async {
    final file = await _localFile;

    String json = jsonEncode(newUser);
    print(json);
    return file.writeAsString(json);
  }

  Future<LocalUser?> readUser() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      Map<String, dynamic> userMap = jsonDecode(contents);
      LocalUser newUser = LocalUser.fromJson(userMap);

      return newUser;
    } catch (e) {
      // If encountering an error, return null
      print(e);
      return null;
    }
  }
}
