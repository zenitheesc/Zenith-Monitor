import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: mainBody(context),
        backgroundColor: eerieBlack,
      ),
    );
  }
}

Center mainBody(BuildContext context) {
  return Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              VerticalDivider(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              profileImage(context)
            ],
          ),
          Divider(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          namePasswordColumn(context),
          Divider(
            height: MediaQuery.of(context).size.height * 0.16,
          ),
          backSubmitButtonsRow(context),
        ],
      ),
    ),
  );
}

Widget profileImage(BuildContext context) {
  var imageRadius = MediaQuery.of(context).size.height * 0.1;
  var iconButtonRadius = MediaQuery.of(context).size.height * 0.035;

  return Stack(
    children: <Widget>[
      Container(
        height: 2.0 * imageRadius,
        width: 2.0 * imageRadius,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(imageRadius), color: white),
        child: Center(
          child: Icon(
            Icons.person_outlined,
            size: 1.6 * imageRadius,
          ),
        ),
      ),
      Positioned(
        top: 2.0 * imageRadius * 0.65,
        left: 2.0 * imageRadius * 0.75,
        child: Container(
          height: 2 * iconButtonRadius,
          width: 2 * iconButtonRadius,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(iconButtonRadius),
              color: white),
          child: IconButton(
            iconSize: 1.2 * iconButtonRadius,
            padding: EdgeInsets.all(0.0),
            splashRadius: 1.3 * iconButtonRadius,
            onPressed: () {
              print('Icon button was pressed!');
            },
            icon: Icon(
              Icons.photo_library_outlined,
            ),
          ),
        ),
      )
    ],
    clipBehavior: Clip.none,
  );
}

Container textField(
    BuildContext context, String text, bool isObscure, double width) {
  var height = MediaQuery.of(context).size.height * 0.08;
  var fontSize = (MediaQuery.of(context).orientation == Orientation.portrait)
      ? 0.3 * height
      : (text == 'Nome' || text == 'Sobrenome')
      ? 0.06 * width
      : 0.03 * width;

  return Container(
    width: width,
    height: height,
    child: TextField(
      style: TextStyle(
          color: white, fontWeight: FontWeight.normal, fontFamily: 'DMSans'),
      decoration: InputDecoration(
          labelText: "  " + text,
          labelStyle:
              TextStyle(color: white, fontSize: fontSize, fontFamily: 'DMSans'),
          filled: true,
          fillColor: Colors.black,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  MediaQuery.of(context).size.height * 0.015)))),
      obscureText: isObscure,
    ),
  );
}

Row nameRow(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      textField(
          context, 'Nome', false, MediaQuery.of(context).size.width * 0.39),
      VerticalDivider(width: MediaQuery.of(context).size.width * 0.02),
      textField(
          context, 'Sobrenome', false, MediaQuery.of(context).size.width * 0.39)
    ],
  );
}

Column namePasswordColumn(BuildContext context) {
  var width = MediaQuery.of(context).size.width * 0.8;
  var dividerHeight = MediaQuery.of(context).size.height * 0.007;

  var divider = Divider(height: dividerHeight);

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      nameRow(context),
      divider,
      textField(context, 'Email', false, width),
      divider,
      textField(context, 'Senha', true, width),
      divider,
      textField(context, 'Confirmar Senha', true, width),
    ],
  );
}

Row backSubmitButtonsRow(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      buttonContainer(context, 'Voltar', 0XFFE57373),
      VerticalDivider(width: MediaQuery.of(context).size.width * 0.02),
      buttonContainer(context, 'Submeter', 0XFF8BC34A)
    ],
  );
}

Container buttonContainer(BuildContext context, String text, int textColor) {
  var width = MediaQuery.of(context).size.width * 0.39;
  var height = MediaQuery.of(context).size.height * 0.05; 
  var fontSize = (MediaQuery.of(context).orientation == Orientation.portrait)
      ? 0.5 * height
      : 0.05 * width;

  return Container(
    width: width,
    height: height,
    child: ElevatedButton(
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style:
              TextStyle(color: white, fontSize: fontSize, fontFamily: 'DMSans'),
        )
      ),
      onPressed: () {},
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * 0.03),
                  side: BorderSide(color: Color(textColor)))),
          fixedSize: MaterialStateProperty.all(Size(width, height)),
          backgroundColor: MaterialStateProperty.all<Color>(Color(textColor))),
    ),
  );
}
