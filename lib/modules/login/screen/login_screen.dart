import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/login/bloc/login_bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';
import 'package:zenith_monitor/widgets/user_profile.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => LoginBloc())],
      child: Botao(),
    );
  }
}

///Only for debug
class Botao extends StatelessWidget {
  Botao({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalUser newUser1 =
        LocalUser("Vitor", "Carlos", null, "vitor.carreramiguel@gmail.com");

    return Scaffold(
      backgroundColor: raisingBlack,
      appBar: const StandardAppBar(title: "Login"),
      body: Column(
        children: [
          BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            if (state is LoginError) {
              return Text(state.errorMessage);
            } else if (state is LodingState) {
              return const CircularProgressIndicator();
            } else if (state is LoginSuccess) {
              return UserProfile(user: state.user);
            }
            return const Text("cachorro");
          }),
          SizedBox(
            height: 30,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.green;
                      }

                      return mantisGreen;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ))),
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(
                    /*EmailLoginEvent(
                    user: newUser1,
                    password: "123456") */
                    GoogleLoginEvent());
              },
              child: const Text(
                "Iniciar Missão",
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  color: white,
                  fontFamily: 'DMSans',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
