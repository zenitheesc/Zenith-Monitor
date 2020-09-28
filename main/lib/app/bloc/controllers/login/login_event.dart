part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginResetPassword extends LoginEvent {
  final String data;

  LoginResetPassword(this.data);
}

class LoginStart extends LoginEvent {}

class LoginRegister extends LoginEvent {
  final RegisterPacket data;

  LoginRegister(this.data);
}

class LoginSignOut extends LoginEvent {}

class LoginSignIn extends LoginEvent {
  final SignInPacket data;

  LoginSignIn(this.data);
}

class ChangeForm extends LoginEvent {
  final LoginForm page;

  ChangeForm(this.page);
}
