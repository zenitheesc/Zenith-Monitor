import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication.dart';
import 'package:zenith_monitor/utils/services/authentication/email_password_auth.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication_exceptions.dart';
import 'package:zenith_monitor/utils/services/authentication/google_auth.dart';
import 'package:zenith_monitor/utils/services/user_firestore/user_document.dart';
import 'package:zenith_monitor/utils/services/user_firestore/user_document_exceptions.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState());

  EmailAndPasswordAuth emailPasswordAuth = EmailAndPasswordAuth();
  GoogleAuth googleAuth = GoogleAuth();
  UserDocument firestore = UserDocument();
  late LocalUser _user;
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AuthenticationEvent) {
      yield LodingState();
      try {
        if (event is EmailLoginEvent) {
          await emailPasswordAuth.signIn(event.user, event.password);
        } else if (event is GoogleLoginEvent) {
          await googleAuth.signInwithGoogle();
        }
        _user = await firestore.getUser(event.auth.userCreationConditions);
        yield LoginSuccess(user: _user);
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
      } on FirebaseProblem catch (e) {
        print(e.errorType());
        yield LoginError(
            errorMessage:
                "Um problema ocorreu durante a utilização do banco de dados");
      } catch (e) {
        print(e.toString());
        yield LoginError(errorMessage: "Erro desconhecido");
      }
    }
  }
}
