import 'package:flutter/material.dart';

/* This function is used to get the size of a string based on its TextStyle */
Size calcTextSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
    textScaleFactor: WidgetsBinding.instance!.window.textScaleFactor,
  )..layout();
  return textPainter.size;
}
