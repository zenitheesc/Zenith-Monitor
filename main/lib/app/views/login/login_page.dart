import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/app/bloc/controllers/login/login_bloc.dart';
import 'package:zenith_monitor/app/views/login/animations/Loader.dart';
import 'package:zenith_monitor/app/views/login/widgets/login_form/login.dart';
import 'package:zenith_monitor/app/views/login/widgets/reset_passw_form/update_password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<LoginBloc>(context).add(LoginStart());
    print("start");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSignInSuccesful) {
              Navigator.popAndPushNamed(context, '/map');
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return Loader();
            } else if (state is LoginInitial) {
              return Login();
              // } else if (state is LoginRegisterPage) {
              //   debugPrint("change to register page");
              //   return Register();
            } else if (state is LoginResetPage) {
              return UpdatePassword();
            } else {
              return Login();
            }
          },
        ));
    //   return ;
  }
}
