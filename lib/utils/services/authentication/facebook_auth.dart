import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/services/user_firestore/user_document_exceptions.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication_exceptions.dart';
import 'authentication.dart';

/// Facebook's authentication has the problem that the current User has
/// its verified email property set to false. That's why it was chosen
/// not to use the user provided by Facebook as a way to write Firebase
/// documents.

class FacebookAuthentication extends Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  FacebookAuthentication() {
    type = "Facebook";
  }
  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await _facebookAuth.login();

      if (result.status == LoginStatus.success) {
        final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        await _auth.signInWithCredential(facebookCredential);
      } else if (result.status == LoginStatus.cancelled) {
        print(result.message);
      } else if (result.status == LoginStatus.failed) {
        print(result.message);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "account-exists-with-different-credential") {
        throw AnotherCredentialUsed();
      }

      throw FirebaseProblem(isFirebaseException: true, errorMsg: e.toString());
    } catch (e) {
      print(e.toString());
      throw FirebaseProblem(isFirebaseException: false, errorMsg: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await _facebookAuth.logOut();
    await _auth.signOut();
  }

  /// This method is not even necessary here,
  /// it's used in Google and EmailAndPassword
  /// authentication only.
  @override
  Future<LocalUser?> userCreationConditions(DocumentSnapshot? userDoc) async {
    return null;
  }

  @override
  Future<LocalUser> getUserAuthentication() async {
    if (_auth.currentUser == null) throw NullUser();

    final Map<String, dynamic> userData = await _facebookAuth.getUserData();

    LocalUser user = LocalUser(userData["name"], "",
        userData["picture"]["data"]["url"], userData["email"]);
    user.setAccessLevel("Normal User");
    return user;
  }
}
