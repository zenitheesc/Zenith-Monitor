import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

// import 'package:auto_size_text/auto_size_text.dart';
class LoginZenithMonitor extends StatelessWidget {
  LoginZenithMonitor({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: appBarLogin(),
        body: buildMainBody(context),
        backgroundColor: eerieBlack);
  }

  double screenSize(BuildContext context, String type, double size) {
    if (type == "height")
      return MediaQuery.of(context).size.height * size;
    else
      return MediaQuery.of(context).size.width * size;
  }

  Widget buildMainBody(BuildContext context) {
    return GridTile(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(),
              Positioned(
                  top: screenSize(context, "height", -0.437),
                  left: screenSize(context, "width", 0.0834),
                  child: imageCircle(context)),
              Positioned(
                top: MediaQuery.of(context).size.height * -0.195,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          loginContainersName(context, 'Nome'),
                          loginContainersName(context, 'Sobrenome ')
                        ],
                      ),
                      loginContainersGeneral(context, 'Email '),
                      loginContainersGeneral(context, 'Senha '),
                      loginContainersGeneral(context, 'Confirmar senha ')
                    ],
                  ),
                ),
              ),
              Positioned(
                top: screenSize(context, "height", 0.312),
                child: Container(
                  width: screenSize(context, "width", 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      smallContainer(context, 'Voltar', 0XFFE57373),
                      smallContainer(context, 'Submeter', 0XFF8BC34A)
                    ],
                  ),
                ),
              ),
            ],
            clipBehavior: Clip.none,
          ),
        ],
      ),
    );
  }

  Widget insertText(BuildContext context, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: "  " + text,
            labelStyle: TextStyle(
                color: gray,
                fontSize: screenSize(context, "width", 0.048),
                fontFamily: 'DMSans'),
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder()
          ),
        )
      ],
    );
  }

  Widget loginContainersName(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize(context, "width", 0.012),
          vertical: screenSize(context, "height", 0.003)),
      child: Container(
        width: screenSize(context, "width", 0.44),
        height: screenSize(context, "height", 0.1),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(
        //       screenSize(context, "height", 0.0929) * 0.242),
        //   color: Colors.black,
        // ),
        child: insertText(context, text),
      ),
    );
  }

  Widget loginContainersGeneral(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.all(screenSize(context, "height", 0.003)),
      child: Container(
        width: screenSize(context, "width", 0.9),
        height: screenSize(context, "height", 0.1),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(
        //       screenSize(context, "height", 0.0929) * 0.242),
        //   color: Colors.black,
        // ),
        child: insertText(context, text),
      ),
    );
  }

  Widget imageCircle(BuildContext context) {
    double userRadius = screenSize(context, "height", 0.179);
    double imageRadius = screenSize(context, "height", 0.0704);

    return Stack(
      children: <Widget>[
        Container(
            height: userRadius,
            width: userRadius,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(userRadius), color: white),
            child: Center(
                child:
                    Image(image: AssetImage('assets/images/user_figure.png')))),
        Positioned(
          bottom: screenSize(context, "width", -0.025),
          right: screenSize(context, "width", -0.03),
          child: Container(
            height: imageRadius,
            width: imageRadius,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200), color: white),
            child: Center(
                child:
                    Image(image: AssetImage('assets/images/images_solid.png'))),
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }

  Widget smallContainer(BuildContext context, String text, int textColor) {
    return Center(
      child: Container(
        width: screenSize(context, "width", 0.4),
        height: screenSize(context, "height", 0.05847),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(screenSize(context, "height", 0.03125)),
          color: Color(textColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: white,
                fontSize: screenSize(context, "width", 0.048),
                fontFamily: 'DMSans'),
          ),
        ),
      ),
    );
  }
}
