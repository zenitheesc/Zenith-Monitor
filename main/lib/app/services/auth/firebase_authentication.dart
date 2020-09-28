import 'package:firebase_auth/firebase_auth.dart';
import 'package:zenith_monitor/app/models/user.dart';

// import 'package:interface_zenith/Services/database.dart';
// import 'package:interface_zenith/Models/datatypes.dart';

class AuthManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ZUser preLoggedUser = ZUser("--", "--", null, "00");

  ZUser _userFromFirebaseUser(User user) {
    print("Converting ${user?.displayName}");
    return user != null
        ? ZUser(user.displayName, user.email, user.photoURL, user.uid)
        : null;
  }

  Stream<ZUser> get user {
    return _auth
        .authStateChanges()
        .asyncMap((User user) => _userFromFirebaseUser(user));
  }

  bool isLogged() {
    var u = _auth.currentUser;
    if (u != null) {
      preLoggedUser = _userFromFirebaseUser(u);
    }
    print("User was already logged: ${u?.email}");
    return u != null;
  }

  // sign in
  Future signIn(SignInPacket data) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: data.email,
        password: data.password,
      ))
          .user;
      print("Logged in with User: ${user?.email}");
      return true;
    } catch (e) {
      return false;
    }
  }

  //register
  // Future register(
  //     String name, String imageURL, String email, String password) async {
  //   try {
  //     AuthResult result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     FirebaseUser user = result.user;

  //     await DatabaseService(uid: user.uid)
  //         .updateUserData(name, 'null', imageURL);

  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //sign out, n sei onde vai usar
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return 1;
    }
  }
}
