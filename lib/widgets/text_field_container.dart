import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class TextFieldContainer extends StatelessWidget {
  double width;
  double height;
  EdgeInsetsGeometry? margin;
  bool isObscure;
  double fontSize;
  final String labelText;

  TextFieldContainer(
      {required this.labelText,
      required this.fontSize,
      required this.width,
      required this.height,
      this.margin,
      this.isObscure = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: TextField(
        style: TextStyle(
            color: white, fontWeight: FontWeight.normal, fontFamily: 'DMSans'),
        decoration: InputDecoration(
            labelText: "  " + labelText,
            labelStyle: TextStyle(
                color: white, fontSize: fontSize, fontFamily: 'DMSans'),
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(0.24 * height)))),
        obscureText: isObscure,
      ),
    );
  }
}
