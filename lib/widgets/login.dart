import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

// import 'package:auto_size_text/auto_size_text.dart';
class LoginZenithMonitor extends StatelessWidget {
  LoginZenithMonitor({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildMainBody(context), backgroundColor: eerieBlack);
  }

  double screenSize(BuildContext context, String type, double size) {
    if (type == "height")
      return MediaQuery.of(context).size.height * size;
    else
      return MediaQuery.of(context).size.width * size;
  }

  Widget buildMainBody(BuildContext context) {
    Widget buildMainBody(BuildContext context) {
    return GridTile(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                    Container(child: imageCircle(context)),
                  ],
                ),
                Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            loginContainersName(context, 'Nome', 'General'),
                            loginContainersName(
                                context, 'Sobrenome ', 'General')
                          ],
                        ),
                        loginContainersGeneral(context, 'Email ', 'General'),
                        loginContainersGeneral(context, 'Senha ', 'Password'),
                        loginContainersGeneral(
                            context, 'Confirmar senha ', 'Password'),
                      ],
                    ),
                  ),
                ),
                Container(
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
            ),
          ),
        ],
      ),
    );
  }
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.07,
              ),
              Container(child: imageCircle(context)),
            ],
          ),
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      loginContainersName(context, 'Nome', 'General'),
                      loginContainersName(context, 'Sobrenome ', 'General')
                    ],
                  ),
                  loginContainersGeneral(context, 'Email ', 'General'),
                  loginContainersGeneral(context, 'Senha ', 'Password'),
                  loginContainersGeneral(
                      context, 'Confirmar senha ', 'Password'),
                ],
              ),
            ),
          ),
          Container(
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
      ),
    );
  }

  Widget insertText(BuildContext context, String text, String typeContainer) {
    bool key = false;

    if (typeContainer == 'Password') key = true;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              labelText: "  " + text,
              labelStyle: TextStyle(
                  color: white,
                  fontSize: screenSize(context, "width", 0.048),
                  fontFamily: 'DMSans'),
              filled: true,
              fillColor: Colors.black,
              border: OutlineInputBorder()),
          obscureText: key,
        )
      ],
    );
  }

  Widget loginContainersName(
      BuildContext context, String text, String typeContainer) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize(context, "width", 0.012),
          vertical: screenSize(context, "height", 0.003)),
      child: Container(
        width: screenSize(context, "width", 0.44),
        height: screenSize(context, "height", 0.1),
        child: insertText(context, text, typeContainer),
      ),
    );
  }

  Widget loginContainersGeneral(
      BuildContext context, String text, String typeContainer) {
    return Padding(
      padding: EdgeInsets.all(screenSize(context, "height", 0.003)),
      child: Container(
        width: screenSize(context, "width", 0.9),
        height: screenSize(context, "height", 0.1),
        child: insertText(context, text, typeContainer),
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
                    Icon(
                Icons.person_outlined,
                size: userRadius * 0.65,
              ),
        Positioned(
          bottom: screenSize(context, "width", -0.025),
          right: screenSize(context, "width", -0.03),
          child: Container(
            height: imageRadius,
            width: imageRadius,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200), color: white),
            child: Center(
                child: Image(
             IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.photo_library_outlined,
                  size: imageRadius * 0.5,
                ),
              ),
            )),
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }

  Widget smallContainer(BuildContext context, String text, int textColor) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: white,
                fontSize: screenSize(context, "width", 0.048),
                fontFamily: 'DMSans'),
          ),
          onPressed: () {
            print(text + ' Pressed!');
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          screenSize(context, "height", 0.03125)),
                      side: BorderSide(color: Color(textColor)))),
              fixedSize: MaterialStateProperty.all(Size(
                screenSize(context, "width", 0.4),
                screenSize(context, "height", 0.05847),
              )),
              backgroundColor: MaterialStateProperty.all<Color>(
                Color(textColor),
              )),
        ),
      ),
    );
  }
}
