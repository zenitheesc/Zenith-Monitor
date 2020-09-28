part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginRegisterPage extends LoginState {}

class LoginRegisterFailedRequirements extends LoginState {}

class LoginRegisterSuccesful extends LoginState {}

class LoginRegisterFailed extends LoginState {}

class LoginSignOutFailed extends LoginState {}

class LoginSignOutSuccesful extends LoginState {}

class LoginResetPage extends LoginState {}

class LoginResetSuccesful extends LoginState {}

class LoginResetFailed extends LoginState {}

class LoginSignInFailed extends LoginState {}

class LoginSignInSuccesful extends LoginState {}

class LoginLoading extends LoginState {}
