part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginError extends LoginState {
  String errorMessage;

  LoginError({required this.errorMessage});
}
