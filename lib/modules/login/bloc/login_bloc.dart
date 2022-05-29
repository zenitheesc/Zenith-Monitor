import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication.dart';
import 'package:zenith_monitor/utils/services/authentication/email_password_auth.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication_exceptions.dart';
import 'package:zenith_monitor/utils/services/authentication/facebook_auth.dart';
import 'package:zenith_monitor/utils/services/authentication/google_auth.dart';
import 'package:zenith_monitor/utils/services/user_firestore/user_document.dart';
import 'package:zenith_monitor/utils/services/user_firestore/user_document_exceptions.dart';
import 'package:zenith_monitor/utils/services/user_storage/user_storage.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState());

  late LocalUser _user;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AuthenticationEvent) {
      yield LoadingState();
      try {
        await event.loginCall();
        _user = await event.getUser();
        yield LoginSuccess(_user);
      } on WrongPassword {
        yield LoginError(errorMessage: "Senha errada");
      } on UserNotFound {
        yield LoginError(errorMessage: "Usuário não encontrado");
      } on EmailBadlyFormatted {
        yield LoginError(
            errorMessage: "O email não está na formatação correta");
      } on NullUser {
        yield LoginError(
            errorMessage:
                "Algum problema ocorreu durante a autenticação do usuário");
      } on EmailNotVerified {
        yield LoginError(
            errorMessage: "O email do usuário ainda não foi autenticado");
      } on UserFileNotFound {
        yield LoginError(
            errorMessage:
                "Os dados do usuário não foram encontrados. Por favor, forneça-os novamente");
        //apresentar janela para fornecimento dos dados
      } on AnotherCredentialUsed {
        yield LoginError(
            errorMessage:
                "O email associado a este método de autenticação já foi utilizado em outro método. Por favor, utilize outro método.");
      } on FirebaseProblem catch (e) {
        print(e.errorType());
        yield LoginError(
            errorMessage:
                "Um problema ocorreu durante a utilização do banco de dados. Verifique se o email fornecido foi verificado.");
      } catch (e) {
        print(e.toString());
        yield LoginError(errorMessage: "Erro desconhecido");
      }
    }
  }
}
