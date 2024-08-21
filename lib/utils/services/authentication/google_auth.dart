import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication.dart';
import 'package:zenith_monitor/utils/services/user_firestore/user_document_exceptions.dart';

class GoogleAuth extends Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleAuth() {
    type = "Google";
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<LocalUser> getUserAuthentication() async {
    if (_auth.currentUser == null) throw NullUser();

    User currentUser = _auth.currentUser!;

    String? name = currentUser.displayName;
    String? email = currentUser.email;

    name ??= "Usuário do Google";
    email ??= "Email não fornecido";

    return LocalUser(name, "", email, imageLink: currentUser.photoURL);
  }

  @override
  Future<LocalUser?> userCreationConditions(DocumentSnapshot? userDoc) async {
    if (userDoc == null || !(userDoc.exists)) {
      LocalUser newUser = await getUserAuthentication();

      return newUser;
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
