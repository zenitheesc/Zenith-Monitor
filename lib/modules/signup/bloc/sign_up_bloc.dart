import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/services/authentication/email_password_auth.dart';
import 'package:zenith_monitor/utils/services/authentication/authentication_exceptions.dart';
import 'package:zenith_monitor/utils/services/user_storage/user_storage.dart';

part 'sign_up_state.dart';
part 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial());

  EmailAndPasswordAuth auth = EmailAndPasswordAuth();
  UserStorage storage = UserStorage();
  File? profileImage;

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is UserRegisterEvent) {
      yield LoadingState();
      try {
        if (profileImage != null) {
          event.newUser.setImagePath(profileImage!.path.toString());
        }

        if (event.password != event.pwdConfirmation) {
          yield SignUpError(errorMessage: "As senhas não batem");
        } else {
          await auth.register(event.newUser, event.password);
          yield SuccessfulSignup();
        }
      } on WeakPassword {
        yield SignUpError(
            errorMessage: "Senha fraca, utilize pelo menos 6 caracteres");
      } on EmailAlreadyInUse {
        yield SignUpError(errorMessage: "Email já utilizado");
      } on EmailBadlyFormatted {
        yield SignUpError(
            errorMessage: "O email não está na formatação correta");
      } catch (e) {
        print(e);
      }
    } else if (event is PickImageEvent) {
      try {
        profileImage = await storage.pickImage(event.source);
        profileImage = await storage.cropImage(profileImage!);
        yield ProfileImagePicked();
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
