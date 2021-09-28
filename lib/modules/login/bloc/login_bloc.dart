import 'package:bloc/bloc.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication.dart';
import 'package:zenith_monitor/utils/services/user_firestore/user_document.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState());

  Authentication auth = Authentication();
  UserDocument firestore = UserDocument();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {}
}
