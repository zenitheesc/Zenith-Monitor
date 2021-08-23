import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class Authentication {
  void signIn(String email, String password) async {
    print("Vai tentar agora");
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
