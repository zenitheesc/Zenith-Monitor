part of 'forgot_pwd_bloc.dart';

abstract class ForgotPwdState {}

class ForgotPwdInitialState extends ForgotPwdState {}

class ForgotPwdSuccess extends ForgotPwdState {}

class LoadingState extends ForgotPwdState {}

class ForgotPwdError extends ForgotPwdState {
  String errorMessage;

  ForgotPwdError({required this.errorMessage});
}
