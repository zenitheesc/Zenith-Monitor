import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class TextFieldContainer extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry? margin;
  final bool obscureText;
  final double fontSize;
  final String labelText;
  final TextEditingController controller;

  const TextFieldContainer(
      {required this.labelText,
      required this.fontSize,
      required this.width,
      required this.height,
      required this.controller,
      this.margin,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: TextField(
        controller: controller,
        cursorColor: white,
        style: TextStyle(
            color: white,
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            fontFamily: 'DMSans'),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0.24 * height)),
                borderSide: const BorderSide(color: white, width: 2.0)),
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
