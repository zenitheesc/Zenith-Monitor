import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/mixins/class_user_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDocument {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  void _writeUserDocument(LocalUser newUser, User firebaseUser) async {
    //LocalUser? newUser = await userFile.readUser();

    try {
      _usersCollection.doc(firebaseUser.uid).set({
        'Name': newUser.getFirstName(),
        'Access Level': newUser.getAccessLevel(),
      });
    } on FirebaseAuthException catch (e) {
      print("firebase exception:");
      print(e.code);
    } catch (e) {
      print(e);
    }
  }
}
