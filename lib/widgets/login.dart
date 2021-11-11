import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/forgot_my_password.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget();

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(child: mainCenter()),
      backgroundColor: eerieBlack,
    ));
  }

  Center mainCenter() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/images/Full_Logo_White.png'),
          emailPasswordForgotPasswordColumn(),
          singUpLoginRow(),
          otherMethodsOfLoginRow()
        ],
      ),
    );
  }

  Row otherMethodsOfLoginRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      otherMethodsOfLoginButton("github"),
      otherMethodsOfLoginButton("facebook"),
      otherMethodsOfLoginButton("google")
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

  ElevatedButton otherMethodsOfLoginButton(String imgPathForType) {
    String imgPath = "assets/images/" + imgPathForType + "LoginImg.png";
    return ElevatedButton(
      onPressed: () {},
      child: Image.asset(imgPath),
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
          onPressed: () {},
          child: Text(buttonText, style: const TextStyle(color: white))),
    );
  }

  Align forgotPasswordButton() {
    return Align(
      alignment: const Alignment(0.7, 0),
      child: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotMyPassword()));
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
