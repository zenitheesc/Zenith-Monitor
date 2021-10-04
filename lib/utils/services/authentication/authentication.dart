import 'package:firebase_auth/firebase_auth.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/mixins/class_user_file.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication_exceptions.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserFile userFile = UserFile();

  Future<void> register(LocalUser newUser, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: newUser.getEmail(), password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPassword();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUse();
      } else if (e.code == "invalid-email-verified") {
        print("Erro invalid-email-verified");
      } else {
        print(e.code);
      }
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

        userFile.writeUser(newUser);
      }
    }
  }

  Future<void> signIn(LocalUser user, String password) async {
    if (_auth.currentUser == null) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: user.getEmail(), password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == "wrong-password") {
          throw WrongPassword();
        } else if (e.code == "user-not-found") {
          throw UserNotFound();
        } else if (e.code == "invalid-email") {
          throw EmailBadlyFormatted();
        }
        print(e.code);
      } catch (e) {
        print(e);
        throw StandardAuthError(errorMessage: e.toString());
      }
    }
  }

  void signOut() async {
    await _auth.signOut();
  }
}
