import 'package:arch_test/app/widgets/Terminal.dart';
import 'package:flutter/material.dart';

class TerminalPage extends StatefulWidget {
  @override
  _TerminalPageState createState() => _TerminalPageState();
}

class _TerminalPageState extends State<TerminalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[Text("This is the Terminal"), TerminalView()],
      ),
    );
  }
}
