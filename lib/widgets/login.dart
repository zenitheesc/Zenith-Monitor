import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/login/bloc/login_bloc.dart';
import 'package:rive/rive.dart' as rive;
import 'package:zenith_monitor/utils/ui/animations/zenith_progress_indicator.dart';
import 'package:zenith_monitor/widgets/status_message.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget();

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late rive.RiveAnimationController _githubLoginController;
  late rive.RiveAnimationController _facebookLoginController;
  late rive.RiveAnimationController _googleLoginController;

  void _toggleAnimation(rive.RiveAnimationController controller) {
    if (controller.isActive == false) {
      controller.isActive = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _githubLoginController = rive.OneShotAnimation(
      'changeColors',
      autoplay: false,
    );

    _facebookLoginController = rive.OneShotAnimation(
      'changeColors',
      autoplay: false,
    );
    _googleLoginController = rive.OneShotAnimation(
      'changeColors',
      autoplay: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.popAndPushNamed(context, '/map');
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const ZenithProgressIndicator(
                size: 100,
                fileName: "z_icon_white.png",
              );
            }
            if (state is LoginError) {
              return mainCenter(state.errorMessage);
            }
            return mainCenter(null);
          },
        ),
        backgroundColor: raisingBlackDarker,
      ),
    );
  }

  Widget mainCenter(String? errorMsg) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Container(
          decoration: const BoxDecoration(
              color: eerieBlack,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0))),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height *
              ((MediaQuery.of(context).orientation == Orientation.portrait)
                  ? 0.80
                  : 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                width: 340,
                height: 80,
                child: const rive.RiveAnimation.asset(
                    "assets/animations/zenithlogo.riv"),
              ),
              emailPasswordForgotPasswordColumn(),
              StatusMessage(message: errorMsg, color: lightCoral),
              singUpLoginRow(),
              otherMethodsOfLoginRow()
            ],
          ),
        ),
      ),
    );
  }

  Row otherMethodsOfLoginRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      otherMethodsOfLoginButton("github", _githubLoginController,
          null), // github auth service doesn't exist yet, later github auth event must be passed as a parameter
      otherMethodsOfLoginButton(
          "facebook", _facebookLoginController, FacebookLoginEvent()),
      otherMethodsOfLoginButton(
          "google", _googleLoginController, GoogleLoginEvent())
    ]);
  }

  Row singUpLoginRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [singInLoginButton("Sign Up"), singInLoginButton("Login")],
    );
  }

  Column emailPasswordForgotPasswordColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        textField("Email", emailController, false),
        const Divider(),
        textField("Senha", passwordController, true),
        forgotPasswordButton(),
      ],
    );
  }

  ElevatedButton otherMethodsOfLoginButton(String animationPathForType,
      rive.RiveAnimationController _controller, AuthenticationEvent? event) {
    String animationPath =
        "assets/animations/" + animationPathForType + "_icon.riv";

    return ElevatedButton(
      onPressed: () => {
        if (event != null)
          {
            _toggleAnimation(_controller),
            BlocProvider.of<LoginBloc>(context).add(event),
          }
      },
      child: Container(
          width: 40,
          height: 40,
          child: rive.RiveAnimation.asset(
            animationPath,
            controllers: [_controller],
          )),
      style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
          backgroundColor: MaterialStateProperty.all(white.withOpacity(0.001))),
    );
  }

  Container singInLoginButton(String buttonText) {
    return Container(
      decoration: BoxDecoration(
          color: lightBrown, borderRadius: BorderRadius.circular(30)),
      width: MediaQuery.of(context).size.width * 0.35,
      child: TextButton(
          onPressed: () {
            if (buttonText == "Login") {
              BlocProvider.of<LoginBloc>(context).add(EmailLoginEvent(
                  email: emailController.text.trim(),
                  password: passwordController.text));
              passwordController.clear();
            } else {
              Navigator.pushNamed(context, '/signup');
            }
          },
          child: Text(buttonText,
              style: const TextStyle(
                  color: white, fontFamily: 'DMSans', fontSize: 18))),
    );
  }

  Align forgotPasswordButton() {
    return Align(
      alignment: const Alignment(0.7, 0),
      child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/forgotPwd');
          },
          child: const Text(
            "Esqueci a Senha",
            textAlign: TextAlign.right,
            style: TextStyle(color: white),
          )),
    );
  }

  Container textField(
      String hintText, TextEditingController controller, bool hideText) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color(0xff404245),
              Color(0xff212325),
            ]),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextField(
        controller: controller,
        cursorColor: white,
        obscureText: hideText,
        style: const TextStyle(
            color: white,
            fontWeight: FontWeight.normal,
            fontFamily: 'DMSans',
            fontSize: 20.0),
        decoration: InputDecoration(
            isDense: true,
            hintStyle: const TextStyle(color: white),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: raisingBlack),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: raisingBlack),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: hintText),
      ),
    );
  }
}
