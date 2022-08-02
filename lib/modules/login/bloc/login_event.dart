part of 'login_bloc.dart';

abstract class LoginEvent {}

abstract class AuthenticationEvent extends LoginEvent {
  Authentication auth;

  AuthenticationEvent({required this.auth});

  Future<void> loginCall();
  Future<LocalUser> getUser();
}

class EmailLoginEvent extends AuthenticationEvent {
  String email;
  String password;

  EmailLoginEvent({required this.email, required this.password})
      : super(auth: EmailAndPasswordAuth());

  @override
  Future<void> loginCall() async {
    await EmailAndPasswordAuth().signIn(email, password);
  }

  @override
  Future<LocalUser> getUser() async {
    UserDocument userDocument = UserDocument(authMethod: auth);
    DocumentSnapshot? userDocSnap =
        await userDocument.getUserFirebaseDocument();
    if (userDocSnap == null) {
      await UserStorage().uploadImage();
    }

    return await userDocument.getUserFirestore(userDocSnap);
  }
}

class GoogleLoginEvent extends AuthenticationEvent {
  GoogleLoginEvent() : super(auth: GoogleAuth());

  @override
  Future<void> loginCall() async {
    await GoogleAuth().signInwithGoogle();
  }

  @override
  Future<LocalUser> getUser() async {
    UserDocument userDocument = UserDocument(authMethod: auth);
    DocumentSnapshot? userDocSnap =
        await userDocument.getUserFirebaseDocument();
    return await userDocument.getUserFirestore(userDocSnap);
  }
}

class FacebookLoginEvent extends AuthenticationEvent {
  FacebookLoginEvent() : super(auth: FacebookAuth());
  @override
  Future<void> loginCall() async {
    await FacebookAuth().signInWithFacebook();
  }

  @override
  Future<LocalUser> getUser() async {
    return await auth.getUserAuthentication();
  }
}

class SignOutEvent extends LoginEvent {
  BuildContext context;
  SignOutEvent({required this.context});
}
