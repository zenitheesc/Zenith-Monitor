part of 'login_bloc.dart';

abstract class LoginEvent {}

class AuthenticationEvent extends LoginEvent {
  Authentication auth;

  AuthenticationEvent({required this.auth});
}

class EmailLoginEvent extends AuthenticationEvent {
  LocalUser user;
  String password;

  EmailLoginEvent({required this.user, required this.password})
      : super(auth: EmailAndPasswordAuth());
}

class GoogleLoginEvent extends AuthenticationEvent {
  GoogleLoginEvent() : super(auth: GoogleAuth());
}
