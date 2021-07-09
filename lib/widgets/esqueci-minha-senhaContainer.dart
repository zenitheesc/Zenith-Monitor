import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class esqueciSenha extends StatelessWidget {
  esqueciSenha({Key? key});

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
            textStyle:
                TextStyle(color: textColor, fontSize: 18, fontFamily: 'DMSans'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderradius))),
            fixedSize: Size(width, height)),
      ),
    );
  }

  AppBar buildTitle() {
    return AppBar(
      toolbarHeight: 200,
      elevation: 0.0,
      backgroundColor: eerieBlack,
      title: Text('Esqueci minha \nsenha',
          style: TextStyle(color: white, fontSize: 36, fontFamily: 'DMSans'),
          textAlign: TextAlign.start),
    );
  }

  Align buildMainBody() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        height: 405.0,
        decoration: BoxDecoration(
            color: raisingBlack,
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
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: '  Email cadastrado',
                      hintStyle: TextStyle(
                          color: gray, fontSize: 16, fontFamily: 'DMSans')),
                ),
              ),
            ),
            SizedBox(height: 60),
            buildButton(56, 265, white, 12, 'Submeter', Colors.black),
            SizedBox(height: 30),
            buildButton(40, 263, lightCoral, 20, 'Voltar', white),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildTitle(),
        body: buildMainBody(),
        backgroundColor: eerieBlack);
  }
}
