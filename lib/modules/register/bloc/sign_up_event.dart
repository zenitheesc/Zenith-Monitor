part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class UserRegisterEvent extends SignUpEvent {
  LocalUser newUser;
  String password;

  UserRegisterEvent({required this.newUser, required this.password});
}
