import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zenith_monitor/modules/login/screen/login_screen.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication.dart';
import 'package:zenith_monitor/utils/services/authentication/google_auth.dart';
import 'package:zenith_monitor/utils/services/user_firestore/user_document.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late final Authentication _auth;

  LoginBloc({required Authentication auth})
      : _auth = auth,
        super(LoginInitialState()) {
    on<GoogleLoginEvent>(_onGoogleLogin);
    on<SignOutEvent>(_onSignOut);
  }

  Future<void> _onGoogleLogin(
      GoogleLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoadingState());
    try {
      await event.loginCall();
      LocalUser user = await event.getUser();
      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginError(errorMessage: "Erro ao tentar fazer login: $e"));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<LoginState> emit) async {
    await _auth.signOut();
    emit(SignOutSuccess());
    // Navigator.pushAndRemoveUntil(
    //   // ignore: use_build_context_synchronously
    //   event.context,
    //   MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()),
    //   ModalRoute.withName('/login'),
    // );
  }
}
