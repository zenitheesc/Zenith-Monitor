import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/signup/bloc/sign_up_bloc.dart';
import 'package:zenith_monitor/widgets/signup_main_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: SafeArea(
        child: Scaffold(
          body: SignUpMainBody(
              screenWidth: MediaQuery.of(context).size.width,
              screenHeight: MediaQuery.of(context).size.height,
              deviceOrientation: MediaQuery.of(context).orientation),
          backgroundColor: eerieBlack,
        ),
      ),
    );
  }
}
