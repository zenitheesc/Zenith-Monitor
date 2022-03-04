import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/forget_password/bloc/forgot_pwd_bloc.dart';
import 'package:zenith_monitor/widgets/forgot_my_password.dart';

class ForgotMyPassword extends StatelessWidget {
  const ForgotMyPassword();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPwdBloc(),
      child: SafeArea(
          child: Scaffold(
        body: ForgotMyPasswordBody(
            screenWidth: MediaQuery.of(context).size.width,
            screenHeight: MediaQuery.of(context).size.height,
            deviceOrientation: MediaQuery.of(context).orientation),
        backgroundColor: eerieBlack,
      )),
    );
  }
}
