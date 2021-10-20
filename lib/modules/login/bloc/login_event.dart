part of 'login_bloc.dart';

abstract class LoginEvent {}

class EmailLoginEvent extends LoginEvent {
  LocalUser user;
  String password;

  EmailLoginEvent({required this.user, required this.password});
}

class GoogleLoginEvent extends LoginEvent {}
