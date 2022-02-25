import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/mixins/class_user_file.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication_exceptions.dart';
import 'package:zenith_monitor/utils/services/user_firestore/user_document_exceptions.dart';

class EmailAndPasswordAuth extends Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserFile userFile = UserFile();

  EmailAndPasswordAuth() {
    type = "Email and Password";
  }

  Future<void> register(LocalUser newUser, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: newUser.getEmail(), password: password);
      User? firebaseUser = _auth.currentUser;

      if (firebaseUser != null) {
        if (!firebaseUser.emailVerified) {
          await firebaseUser.sendEmailVerification();
        }

        firebaseUser.updateDisplayName(newUser.getCompleteName());
        firebaseUser.updateEmail(newUser.getEmail());
        firebaseUser.updatePhotoURL(newUser.getImageLink());
        userFile.writeUser(newUser);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPassword();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUse();
      } else if (e.code == "invalid-email-verified") {
        print("Erro invalid-email-verified");
      }
      throw FirebaseProblem(isFirebaseException: true, errorMsg: e.toString());
    } catch (e) {
      throw FirebaseProblem(isFirebaseException: false, errorMsg: e.toString());
    }
  }

  Future<void> signIn(String email, String password) async {
    if (_auth.currentUser == null) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == "wrong-password") {
          throw WrongPassword();
        } else if (e.code == "user-not-found") {
          throw UserNotFound();
        } else if (e.code == "invalid-email") {
          throw EmailBadlyFormatted();
        }
        throw FirebaseProblem(
            isFirebaseException: true, errorMsg: e.toString());
      } catch (e) {
        throw FirebaseProblem(
            isFirebaseException: false, errorMsg: e.toString());
      }
    }
  }

  @override
  Future<LocalUser?> userCreationConditions(DocumentSnapshot? userDoc) async {
    if (userDoc == null ||
        !(userDoc.exists) ||
        userDoc.get('created_with') != "Email and Password") {
      LocalUser newUser = await getUserAuthentication();

      return newUser;
    }

    return null;
  }

  @override
  Future<LocalUser> getUserAuthentication() async {
    UserFile file = UserFile();
    LocalUser? newUser = await file.readUser();
    if (newUser == null) throw UserFileNotFound();
    return newUser;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
