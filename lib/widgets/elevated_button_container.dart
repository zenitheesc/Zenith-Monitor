import 'package:flutter/material.dart';

class ElevatedButtonContainer extends StatelessWidget {
  double width;
  double height;
  EdgeInsetsGeometry? margin;
  ButtonStyle buttonStyle;
  TextStyle textStyle;
  final String text;

  ElevatedButtonContainer(
      {required this.width,
      required this.height,
      this.margin,
      required this.buttonStyle,
      required this.text,
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ElevatedButton(
        child: Center(
            child: Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle,
        )),
        onPressed: () {},
        style: buttonStyle,
      ),
    );
  }
}
