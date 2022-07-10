import 'package:flutter/painting.dart';
import 'package:zenith_monitor/utils/helpers/calc_text_size.dart';

/// The nameAbbreviation function takes the font size that will be used
/// in a widget, the window width and the name that will be abbreviated.
/// Based on this, the method will shorten the name until the space
/// occupied is less than 80% of the screen width. The abbreviation will
/// be from the last surname to the third name.
/// Then the short name will be returned.

String nameAbbreviation(String name, double screenWidth, double fontSize) {
  String finalName = name;

  Size size = calcTextSize(finalName, TextStyle(fontSize: fontSize));

  var list = <String>[];
  list = finalName.split(" ");
  list.removeWhere((item) => item == "");
  int i = list.length - 1;

  while (size.width > screenWidth * 0.8) {
    if (i > 0) {
      list[i] = list[i][0] + ".";
      i--;
    } else if (list.length > 2) {
      /// If the method hits the second name, the last names will be removed. Feel free to implement a better approach
      list.removeLast();
    } else {
      break;
    }

    finalName = list.join(" ");
    size = calcTextSize(finalName, TextStyle(fontSize: fontSize));
  }
  return finalName;
}
