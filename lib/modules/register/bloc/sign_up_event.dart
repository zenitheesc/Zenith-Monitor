part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class RegisterEvent extends SignUpEvent {
  LocalUser newUser;
  String password;

  RegisterEvent({required this.newUser, required this.password});
}
