import 'package:bloc/bloc.dart';

part 'sign_up_state.dart';
part 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial());
  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {}
}
