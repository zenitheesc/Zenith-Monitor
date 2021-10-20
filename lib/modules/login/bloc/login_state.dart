part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginError extends LoginState {
  String errorMessage;

  LoginError({required this.errorMessage});
}

class LodingState extends LoginState {}

class LoginSuccess extends LoginState {
  LocalUser user;

  LoginSuccess({required this.user});
}
