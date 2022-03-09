import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/forget_password/bloc/forgot_pwd_bloc.dart';
import 'package:zenith_monitor/widgets/status_message.dart';
import 'package:zenith_monitor/widgets/forgot_my_password_email_buttons_section.dart';
import 'package:zenith_monitor/widgets/forgot_my_password_title_section.dart';

class ForgotMyPasswordBody extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final Orientation deviceOrientation;
  final String? statusMessage;
  final Color? messageColor;

  const ForgotMyPasswordBody(
      {required this.screenWidth,
      required this.screenHeight,
      required this.deviceOrientation,
      required this.statusMessage,
      required this.messageColor});

  @override
  _FMyPWDBodyState createState() => _FMyPWDBodyState();
}

class _FMyPWDBodyState extends State<ForgotMyPasswordBody> {
  late TextEditingController emailController;
  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      TitleSection(
          screenWidth: widget.screenWidth,
          screenHeight: widget.screenHeight,
          deviceOrientation: widget.deviceOrientation),
      Container(
          height: 0.50 * widget.screenHeight,
          margin: EdgeInsets.only(top: 0.27 * widget.screenHeight),
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    raisingBlack,
                    black,
                  ]),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_boderRadius()),
                  topRight: Radius.circular(_boderRadius()))),
          child: EmailButtonsSection(
            screenWidth: widget.screenWidth,
            screenHeight: widget.screenHeight,
            deviceOrientation: widget.deviceOrientation,
            emailController: emailController,
            funcSubmit: () => BlocProvider.of<ForgotPwdBloc>(context)
                .add(PwdResetEmail(email: emailController.text)),
            statusMessage: StatusMessage(
              message: widget.statusMessage,
              color: widget.messageColor,
            ),
          ),
          alignment: Alignment.center)
    ]));
  }

  double _boderRadius() {
    return widget.screenWidth *
        ((widget.deviceOrientation == Orientation.portrait) ? 0.14 : 0.07);
  }
}
