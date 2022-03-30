import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication_exceptions.dart';
import 'package:zenith_monitor/utils/services/authentication/email_password_auth.dart';

part 'forgot_pwd_state.dart';
part 'forgot_pwd_event.dart';

class ForgotPwdBloc extends Bloc<ForgotPwdEvent, ForgotPwdState> {
  ForgotPwdBloc() : super(ForgotPwdInitialState());

  @override
  Stream<ForgotPwdState> mapEventToState(ForgotPwdEvent event) async* {
    if (event is PwdResetEmail) {
      yield LoadingState();
      EmailAndPasswordAuth _auth = EmailAndPasswordAuth();
      try {
        await _auth.resetPassword(event.email);
        yield ForgotPwdSuccess();
      } on UserNotFound {
        yield ForgotPwdError(errorMessage: "Usuário não encontrado");
      } on EmailBadlyFormatted {
        yield ForgotPwdError(
            errorMessage: "O email não está na formatação correta");
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
