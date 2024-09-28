import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// The function calcTextSize is used to get the size of a string based on its TextStyle
Size calcTextSize(String text, TextStyle style) {
  // TextScaler textScaler = TextScaler(WidgetsBinding.instance!.window.scale);

  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
    textScaler: TextScaler.noScaling,
  )..layout();
  return textPainter.size;
}
