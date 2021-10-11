import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/mixins/class_user_file.dart';
import 'package:zenith_monitor/utils/services/user_firestore/user_document_exceptions.dart';

class UserDocument {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<LocalUser> getUser() async {
    if (_auth.currentUser == null) throw NullUser();

    if (!(_auth.currentUser!.emailVerified)) throw EmailNotVerified();

    LocalUser? user;

    DocumentSnapshot? userDoc = await _getUserFirebaseDocument();
    if (userDoc == null || !(userDoc.exists)) {
      userDoc = await _writeUserDocument();
    }
    user = _firebaseDocToLocalUser(userDoc);
    return user;
  }

  Future<DocumentSnapshot> _writeUserDocument() async {
    UserFile file = UserFile();
    LocalUser? newUser = await file.readUser();

    if (newUser == null) throw UserFileNotFound();

    try {
      await _setUserFirebaseDocument(newUser, "Zenith Member");
    } on FirebaseException catch (e) {
      if (e.code == "permission-denied") {
        print("Trying with normal user");
        await _setUserFirebaseDocument(newUser, "Normal User");
      } else {
        print(e.code);
        throw FirebaseProblem(
            isFirebaseException: true, errorMsg: e.toString());
      }
    } catch (e) {
      print(e.toString());
      throw FirebaseProblem(isFirebaseException: false, errorMsg: e.toString());
    }

    DocumentSnapshot? userDoc = await _getUserFirebaseDocument();
    if (userDoc == null || !(userDoc.exists)) {
      throw FirebaseProblem(
          isFirebaseException: false,
          errorMsg:
              "Even after writing the user's document in the firebase, the snapshot had no data");
    }

    return userDoc;
  }

  Future<void> _setUserFirebaseDocument(
      LocalUser newUser, String accessLevel) async {
    await _usersCollection.doc(_auth.currentUser!.uid).set({
      'name': newUser.getFirstName(),
      'last_name': newUser.getLastName(),
      'email': newUser.getEmail(),
      'image_link': await newUser.getImageLink(),
      'access_level': accessLevel,
    });
  }

  LocalUser _firebaseDocToLocalUser(DocumentSnapshot userDoc) {
    Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
    LocalUser user = LocalUser(data["name"], data["last_name"],
        data["image_link"], data["access_level"]);
    return user;
  }

  Future<DocumentSnapshot?> _getUserFirebaseDocument() async {
    DocumentSnapshot userDoc;
    try {
      userDoc = await _usersCollection.doc(_auth.currentUser!.uid).get();
      return userDoc;
    } on FirebaseException catch (e) {
      print(e.code);
      throw FirebaseProblem(isFirebaseException: true, errorMsg: e.toString());
    } catch (e) {
      print(e.toString());
      throw FirebaseProblem(isFirebaseException: false, errorMsg: e.toString());
    }
  }
}
