part of 'login_bloc.dart';

abstract class LoginEvent {}

class UserLoginEvent extends LoginEvent {
  LocalUser user;
  String password;

  UserLoginEvent({required this.user, required this.password});
}
