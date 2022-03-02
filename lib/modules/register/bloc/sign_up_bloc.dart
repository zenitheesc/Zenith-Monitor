import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/services/authentication/email_password_auth.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication_exceptions.dart';

part 'sign_up_state.dart';
part 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial());

  EmailAndPasswordAuth auth = EmailAndPasswordAuth();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is UserRegisterEvent) {
      yield LoadingState();
      try {
        await auth.register(event.newUser, event.password);
      } on WeakPassword {
        yield SignUpError(errorMessage: "Senha fraca");
      } on EmailAlreadyInUse {
        yield SignUpError(errorMessage: "Email já utilizado");
      } catch (e) {
        print(e);
      }
    }
  }
}
