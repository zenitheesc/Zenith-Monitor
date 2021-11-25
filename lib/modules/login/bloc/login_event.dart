part of 'login_bloc.dart';

abstract class LoginEvent {}

abstract class AuthenticationEvent extends LoginEvent {
  Authentication auth;

  AuthenticationEvent({required this.auth});

  Future<void> loginCall();
  Future<LocalUser> getUser();
}

class EmailLoginEvent extends AuthenticationEvent {
  LocalUser user;
  String password;

  EmailLoginEvent({required this.user, required this.password})
      : super(auth: EmailAndPasswordAuth());

  @override
  Future<void> loginCall() async {
    await EmailAndPasswordAuth().signIn(user, password);
  }

  @override
  Future<LocalUser> getUser() async {
    return await UserDocument().getUserFirestore(auth);
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
    return await UserDocument().getUserFirestore(auth);
  }
}

class FacebookLoginEvent extends AuthenticationEvent {
  FacebookLoginEvent() : super(auth: FacebookAuthentication());
  @override
  Future<void> loginCall() async {
    await FacebookAuthentication().signInWithFacebook();
  }

  @override
  Future<LocalUser> getUser() async {
    return await auth.getUserAuthentication();
  }
}
