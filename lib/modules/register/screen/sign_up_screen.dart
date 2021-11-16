import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/register/bloc/sign_up_bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => SignUpBloc())],
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
        LocalUser("To11rresmo", "dos1 Santos", null, "torresmo@g34mail.com");

    return Scaffold(
      backgroundColor: raisingBlack,
      appBar: const StandardAppBar(title: "SignUp"),
      body: Column(
        children: [
          BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
            if (state is SignUpError) {
              return Text(state.errorMessage);
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
                BlocProvider.of<SignUpBloc>(context).add(
                    UserRegisterEvent(newUser: newUser1, password: "123456"));
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