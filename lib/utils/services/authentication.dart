import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/mixins/class_user_file.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserFile userFile = UserFile();
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  void register(LocalUser newUser, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: newUser.getEmail(), password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (e.code == "invalid-email-verified") {}
    } catch (e) {
      print(e);
    } finally {
      User? firebaseUser = _auth.currentUser;

      if (firebaseUser != null) {
        if (!firebaseUser.emailVerified) {
          await firebaseUser.sendEmailVerification();
        }

        firebaseUser.updateDisplayName(newUser.getCompleteName());
        firebaseUser.updateEmail(newUser.getEmail());
        firebaseUser.updatePhotoURL(await newUser.getImageLink());

        //_writeUserDocument(newUser, firebaseUser);
        userFile.writeUser(newUser);
      }
    }
  }

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

  void signIn(LocalUser user, String password) async {
    if (_auth.currentUser == null) {
      try {
        _auth.signInWithEmailAndPassword(
            email: user.getEmail(), password: password);
      } catch (e) {
        print(e);
      } finally {
        if (_auth.currentUser == null) {
          print("user é null");
        } else {
          print("user não é null");
          print((_auth.currentUser!).emailVerified);
        }
      }
    } else {
      print("Usuario já autenticado");
    }
  }

  void signOut() async {
    await _auth.signOut();
  }
}
