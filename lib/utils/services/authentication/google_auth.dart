import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication.dart';
import 'package:zenith_monitor/utils/services/user_firestore/user_document_exceptions.dart';

class GoogleAuth extends Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  LocalUser _getUserFromGoogle() {
    if (_auth.currentUser == null) throw NullUser();

    User currentUser = _auth.currentUser!;

    String? name = currentUser.displayName;
    String? email = currentUser.email;

    name ??= "Usuário do Google";
    email ??= "Email não fornecido";

    return LocalUser(name, "", currentUser.photoURL, email);
  }

  @override
  Future<String?> userCreationConditions(
      DocumentSnapshot? userDoc, LocalUser user) async {
    if (userDoc == null || !(userDoc.exists)) {
      LocalUser newUser = _getUserFromGoogle();
      user.copyUserFrom(newUser);
      return "Google auth";
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
