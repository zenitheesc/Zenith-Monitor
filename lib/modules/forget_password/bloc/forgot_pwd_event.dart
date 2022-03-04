part of 'forgot_pwd_bloc.dart';

abstract class ForgotPwdEvent {}

class PwdResetEmail extends ForgotPwdEvent {
  String email;

  PwdResetEmail({required this.email});
}
