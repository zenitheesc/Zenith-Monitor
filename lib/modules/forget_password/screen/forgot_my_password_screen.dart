import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/forget_password/bloc/forgot_pwd_bloc.dart';
import 'package:zenith_monitor/utils/ui/animations/zenith_progress_indicator.dart';
import 'package:zenith_monitor/widgets/forgot_my_password.dart';

class ForgotMyPassword extends StatelessWidget {
  const ForgotMyPassword();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPwdBloc(),
      child: SafeArea(
          child: Scaffold(
        body: BlocBuilder<ForgotPwdBloc, ForgotPwdState>(
          builder: (context, state) {
            String? statusMessage;
            Color? messageColor;
            if (state is LoadingState) {
              return const ZenithProgressIndicator(
                  size: 100, fileName: "z_icon_white.png");
            }
            if (state is ForgotPwdSuccess) {
              statusMessage =
                  "Um email para recuperação de senha foi enviado com sucesso";
              messageColor = mantisGreen;
            }

            if (state is ForgotPwdError) {
              statusMessage = state.errorMessage;
              messageColor = lightCoral;
            }
            return ForgotMyPasswordBody(
              screenWidth: MediaQuery.of(context).size.width,
              screenHeight: MediaQuery.of(context).size.height,
              deviceOrientation: MediaQuery.of(context).orientation,
              statusMessage: statusMessage,
              messageColor: messageColor,
            );
          },
        ),
        backgroundColor: eerieBlack,
      )),
    );
  }
}
