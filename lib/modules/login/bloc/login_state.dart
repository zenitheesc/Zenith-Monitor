part of 'login_bloc.dart';

abstract class LoginState {
	LocalUser? user;
}

class LoginInitialState extends LoginState {}

class LoginError extends LoginState {
  String errorMessage;

  LoginError({required this.errorMessage});
}

class LodingState extends LoginState {}

class LoginSuccess extends LoginState {

  LoginSuccess(LocalUser newUser){
  	user = newUser;
  }
}
