import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/services/authentication/email_password_auth.dart';

part 'forgot_pwd_state.dart';
part 'forgot_pwd_event.dart';

class ForgotPwdBloc extends Bloc<ForgotPwdEvent, ForgotPwdState> {
  ForgotPwdBloc() : super(ForgotPwdInitialState());

  @override
  Stream<ForgotPwdState> mapEventToState(ForgotPwdEvent event) async* {
    if (event is PwdResetEmail) {
      EmailAndPasswordAuth _auth = EmailAndPasswordAuth();
      try {
        await _auth.resetPassword(event.email);
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
