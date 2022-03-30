part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class UserRegisterEvent extends SignUpEvent {
  LocalUser newUser;
  String password;
  String pwdConfirmation;

  UserRegisterEvent(
      {required this.newUser,
      required this.password,
      required this.pwdConfirmation});
}

class PickImageEvent extends SignUpEvent {
  ImageSource source;
  PickImageEvent({required this.source});
}
