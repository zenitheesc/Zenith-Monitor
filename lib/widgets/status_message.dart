import 'package:flutter/material.dart';

class StatusMessage extends StatelessWidget {
  final String? message;
  final Color? color;

  const StatusMessage({required this.message, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        child: Center(
          child: Text(
            message ?? "",
            style: TextStyle(color: color ?? Colors.black),
          ),
        ));
  }
}
