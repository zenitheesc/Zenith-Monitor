import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

void showDialogFunction(BuildContext context, String title, String errorMessage,
    List<Widget> actions) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title, style: const TextStyle(color: white)),
            content: Text(errorMessage, style: const TextStyle(color: white)),
            backgroundColor: black.withOpacity(1),
            actions: actions,
          ));
}
