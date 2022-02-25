import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class TextFieldContainer extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry? margin;
  final bool obscureText;
  final double fontSize;
  final String labelText;

  const TextFieldContainer(
      {required this.labelText,
      required this.fontSize,
      required this.width,
      required this.height,
      this.margin,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: TextField(
        style: TextStyle(
            color: white,
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            fontFamily: 'DMSans'),
        decoration: InputDecoration(
            labelText: "  " + labelText,
            labelStyle: TextStyle(
                color: white, fontSize: fontSize, fontFamily: 'DMSans'),
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(0.24 * height)))),
        obscureText: obscureText,
      ),
    );
  }
}
