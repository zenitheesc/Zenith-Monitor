part of 'login_bloc.dart';

abstract class LoginState {
  late final LocalUser? user;

  LoginState({this.user});
}

class LoginInitialState extends LoginState {}

class LoginError extends LoginState {
  final String errorMessage;

  LoginError({required this.errorMessage});
}

class LoadingState extends LoginState {}

class LoginSuccess extends LoginState {
  LoginSuccess(LocalUser newUser) : super(user: newUser);
}

class SignOutSuccess extends LoginState {}

class CheckSessionEvent extends LoginEvent {}
