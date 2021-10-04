import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication_exceptions.dart';
import 'package:zenith_monitor/utils/services/user_firestore/user_document.dart';
import 'package:zenith_monitor/utils/services/user_firestore/user_document_exceptions.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState());

  Authentication auth = Authentication();
  UserDocument firestore = UserDocument();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is UserLoginEvent) {
      try {
        yield LodingState();
        await auth.signIn(event.user, event.password);
        await firestore.getUserDocument();
        print("tudo certo");
        yield LoginError(errorMessage: "tudo certo");
      } on WrongPassword {
        yield LoginError(errorMessage: "Senha errada");
      } on UserNotFound {
        yield LoginError(errorMessage: "Usuário não encontrado");
      } on EmailBadlyFormatted {
        yield LoginError(
            errorMessage: "O email não está na formatação correta");
      } on NullUser {
        yield LoginError(errorMessage: "User null");
      } on EmailNotVerified {
        yield LoginError(
            errorMessage: "O email do usuário ainda não foi autenticado");
      } on UserFileNotFound {
        yield LoginError(
            errorMessage:
                "Os dados do usuário não foram encontrados. Por favor, forneça-os novamente");
      } catch (e) {
        print(e);
        yield LoginError(errorMessage: e.toString());
      }
    }
  }
}
