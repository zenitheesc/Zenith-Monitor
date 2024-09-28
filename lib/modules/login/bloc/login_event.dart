part of 'login_bloc.dart';

abstract class LoginEvent {}

abstract class AuthenticationEvent extends LoginEvent {
  final Authentication auth;

  AuthenticationEvent({required this.auth});

  Future<void> loginCall();
  Future<LocalUser> getUser();
}

class GoogleLoginEvent extends AuthenticationEvent {
  GoogleLoginEvent() : super(auth: GoogleAuth());

  @override
  Future<void> loginCall() async {
    await auth.signInWithGoogle();
  }

  @override
  Future<LocalUser> getUser() async {
    UserDocument userDocument = UserDocument(authMethod: auth);
    DocumentSnapshot? userDocSnap =
        await userDocument.getUserFirebaseDocument();
    return await userDocument.getUserFirestore(userDocSnap);
  }
}

class SignOutEvent extends LoginEvent {
  final BuildContext context;

  SignOutEvent({required this.context});
}
