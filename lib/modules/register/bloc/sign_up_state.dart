part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpError extends SignUpState {
  String errorMessage;

  SignUpError({required this.errorMessage});
}
