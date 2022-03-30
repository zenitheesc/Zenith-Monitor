import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/signup/bloc/sign_up_bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/utils/ui/animations/zenith_progress_indicator.dart';
import 'package:zenith_monitor/widgets/signup_buttons_section.dart';
import 'package:zenith_monitor/widgets/signup_name_password_section.dart';
import 'package:zenith_monitor/widgets/signup_profile_image_section.dart';
import 'package:zenith_monitor/widgets/status_message.dart';

class SignUpMainBody extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final Orientation deviceOrientation;

  const SignUpMainBody(
      {required this.screenWidth,
      required this.screenHeight,
      required this.deviceOrientation});

  @override
  _SUPMainBodyState createState() => _SUPMainBodyState();
}

class _SUPMainBodyState extends State<SignUpMainBody> {
  late TextEditingController nameController;
  late TextEditingController surnameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController pwdConfirmController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    surnameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    pwdConfirmController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    surnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    pwdConfirmController.dispose();
  }

  Widget statusMessage(SignUpState state) {
    if (state is SuccessfulSignup) {
      return const StatusMessage(
        message:
            "Sign up realizado com sucesso! Basta confirmar o email e realizar o login",
        color: mantisGreen,
      );
    } else if (state is SignUpError) {
      return StatusMessage(message: state.errorMessage, color: lightCoral);
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const ZenithProgressIndicator(
            size: 100,
            fileName: "z_icon_white.png",
          );
        }
        if (state is SuccessfulSignup) {
          nameController.clear();
          surnameController.clear();
          emailController.clear();
          passwordController.clear();
          pwdConfirmController.clear();
        }
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileImageSection(
                    screenWidth: widget.screenWidth,
                    screenHeight: widget.screenHeight),
                NamePasswordSection(
                  screenWidth: widget.screenWidth,
                  screenHeight: widget.screenHeight,
                  deviceOrientation: widget.deviceOrientation,
                  nameController: nameController,
                  surnameController: surnameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  pwdConfirmController: pwdConfirmController,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child:
                        Container(height: 40.0, child: statusMessage(state))),
                ButtonsSection(
                  screenWidth: widget.screenWidth,
                  screenHeight: widget.screenHeight,
                  deviceOrientation: widget.deviceOrientation,
                  funcConfirm: () => BlocProvider.of<SignUpBloc>(context).add(
                      UserRegisterEvent(
                          newUser: LocalUser(nameController.text,
                              surnameController.text, emailController.text),
                          password: passwordController.text,
                          pwdConfirmation: pwdConfirmController.text)),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
