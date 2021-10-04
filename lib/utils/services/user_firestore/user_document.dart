import 'package:firebase_auth/firebase_auth.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/mixins/class_user_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zenith_monitor/utils/services/user_firestore/user_document_exceptions.dart';

class UserDocument {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<LocalUser> getUserDocument() async {
    if (_auth.currentUser == null) throw NullUser();

    if (!(_auth.currentUser!.emailVerified)) throw EmailNotVerified();

    DocumentSnapshot userDoc =
        await _usersCollection.doc(_auth.currentUser!.uid).get();

    print(userDoc.exists);

    LocalUser user;
    if (!userDoc.exists) user = await _writeUserDocument();

    return user;
  }

  Future<LocalUser> _writeUserDocument() async {
    UserFile file = UserFile();
    LocalUser? newUser = await file.readUser();

    if (newUser == null) throw UserFileNotFound();

    try {
      await _usersCollection.doc(_auth.currentUser!.uid).set({
        'Name': newUser.getFirstName(),
        'Last Name': newUser.getLastName(),
        'Email': newUser.getEmail(),
        'Access Level': "Zenith Member",
      });
    } on FirebaseAuthException catch (e) {
      print("firebase exception:");
      print(e.code);
    } catch (e) {
      print(e);
    }
  }
}
