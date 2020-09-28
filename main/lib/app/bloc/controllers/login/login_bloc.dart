import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:zenith_monitor/app/models/user.dart';
import 'package:zenith_monitor/app/services/auth/firebase_authentication.dart';

part 'login_event.dart';
part 'login_state.dart';

enum LoginForm {
  signin,
  register,
  reset,
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthManager authManager;
  LoginBloc(this.authManager) : super(LoginInitial());
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginStart) {
      yield LoginLoading();
      // check if already logged in
      if (authManager.isLogged()) {
        yield LoginSignInSuccesful();
      } else {
        // Continue with normal Login Flow

        yield LoginInitial();
      }
    } else if (event is LoginSignIn) {
      yield LoginLoading();
      if (await authManager.signIn(event.data)) {
        yield LoginSignInSuccesful();
      } else {
        yield LoginSignInFailed();
      }
    } else if (event is LoginSignOut) {
      yield LoginLoading();
      if (await authManager.signOut()) {
        yield LoginSignOutSuccesful();
      } else {
        yield LoginSignOutFailed();
      }
      // } else if (event is LoginRegister) {
      //   yield LoginLoading();
      //   // is it even useful to make this distinction here?
      //   if (await authManager.registerUser(event.data)) {
      //     yield LoginRegisterSuccesful();
      //   } else {
      //     // yield LoginRegisterFailedRequirements();
      //     yield LoginRegisterFailed();
      //   }
    } else if (event is LoginResetPassword) {
      yield LoginLoading();
      if (await authManager.resetPassword(event.data)) {
        yield LoginResetSuccesful();
      } else {
        yield LoginResetFailed();
      }
    } else if (event is ChangeForm) {
      switch (event.page) {
        case LoginForm.signin:
          print("loginiintial");
          yield LoginInitial();
          break;
        case LoginForm.register:
          yield LoginRegisterPage();
          break;
        case LoginForm.reset:
          yield LoginResetPage();
          break;
      }
    }
  }
}
