import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication_exceptions.dart';

part 'login_state.dart';
part 'login_event.dart';

class SignUpBloc extends Bloc<LoginEvent, LoginState> {
  SignUpBloc() : super(LoginInitialState());

  Authentication auth = Authentication();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {}
}
