import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';

/* 
  todo: 
  .Get value from textfield 
  .Create text to show up on terminal
  .Syncronize text with firebase storage
*/

class Terminal extends StatefulWidget {
  const Terminal({Key? key});

  @override
  _TerminalState createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StandardAppBar(title: "Terminal"),
      body: buildMainBody(),
      backgroundColor: raisingBlack,
    );
  }

  Center buildMainBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          terminalTextField(),
        ],
      ),
    );
  }

  Padding terminalTextField() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(28, 0, 28, 37), //values from figma
      child: TextField(
        decoration: InputDecoration(
          fillColor: gray,
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            Icons.arrow_forward_ios_rounded,
            color: white,
          ),
        ),
      ),
    );
  }
}
