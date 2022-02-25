import 'package:flutter/material.dart';

class ElevatedButtonContainer extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color buttonColor;
  final TextStyle textStyle;
  final String labelText;

  const ElevatedButtonContainer(
      {required this.width,
      required this.height,
      this.margin,
      required this.borderRadius,
      required this.buttonColor,
      required this.labelText,
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
            labelText,
            textAlign: TextAlign.center,
            style: textStyle,
          )),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              primary: buttonColor,
              onPrimary: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(borderRadius))),
              fixedSize: Size(width, height))),
    );
  }
}
