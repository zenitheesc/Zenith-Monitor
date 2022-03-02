import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/modules/register/bloc/sign_up_bloc.dart';
import 'package:zenith_monitor/modules/signup/screen/signup_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => SignUpBloc())],
      child: const SignUpWidget(),
    );
  }
}
