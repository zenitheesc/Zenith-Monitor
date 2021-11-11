import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';

class ForgotMyPassword extends StatelessWidget {
  const ForgotMyPassword({Key? key});

  Widget buildButton(double height, double width, Color buttoncolor,
      double borderradius, String text, Color textColor) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(text),
        style: ElevatedButton.styleFrom(
            primary: buttoncolor,
            onPrimary: textColor,
            textStyle: TextStyle(
              color: textColor,
              fontSize: 18,
              fontFamily: 'DMSans-Regular',
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderradius))),
            fixedSize: Size(width, height)),
      ),
    );
  }


  Align buildMainBody() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        height: 405.0,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  raisingBlack,
                  black,
                ]),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45.0),
                topRight: Radius.circular(45.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 70,
              width: 340,
              decoration: BoxDecoration(
                  color: black, borderRadius: BorderRadius.circular(15)),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: white,
                  style: TextStyle(
                      color: gray, fontSize: 16, fontFamily: 'DMSans-Regular'),
                  decoration: InputDecoration(
                    hintText: 'Email cadastrado',
                    hintStyle: TextStyle(
                        color: gray,
                        fontSize: 16,
                        fontFamily: 'DMSans-Regular'),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: black),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            buildButton(56, 265, white, 12, 'Submeter', black),
            const SizedBox(height: 30),
            buildButton(40, 263, lightCoral, 20, 'Voltar', white),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StandardAppBar(title: "Esqueci minha senha"),
        body: buildMainBody(),
        backgroundColor: eerieBlack);
  }
}
