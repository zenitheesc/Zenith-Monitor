import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/login/bloc/login_bloc.dart';
import 'package:rive/rive.dart' as rive;

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
      body: mainCenter(),
      backgroundColor: eerieBlack,
    ));
  }

  Center mainCenter() {
    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
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
      children: [singInLoginButton("Sing Up"), singInLoginButton("Login")],
    );
  }

  Column emailPasswordForgotPasswordColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        textField("Email", emailController),
        const Divider(),
        textField("Senha", passwordController),
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
          color: lightBrown, borderRadius: BorderRadius.circular(20)),
      width: MediaQuery.of(context).size.width * 0.35,
      child: TextButton(
          onPressed: () {
            if (buttonText == "Login") {
              print(emailController.text);
              BlocProvider.of<LoginBloc>(context).add(EmailLoginEvent(
                  email: emailController.text,
                  password: passwordController.text));
            } else {
              Navigator.pushNamed(context, '/signup');
            }
          },
          child: Text(buttonText, style: const TextStyle(color: white))),
    );
  }

  Align forgotPasswordButton() {
    return Align(
      alignment: const Alignment(0.7, 0),
      child: TextButton(
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const ForgotMyPassword()));
            // Maybe all the routes should be created at main, and then we don't need create a MaterialPageRoute every time
          },
          child: const Text(
            "Esqueci a Senha",
            textAlign: TextAlign.right,
            style: TextStyle(color: white),
          )),
    );
  }

  Container textField(String hintText, TextEditingController controller) {
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
        style: const TextStyle(
            color: white, fontWeight: FontWeight.normal, fontFamily: 'DMSans'),
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
