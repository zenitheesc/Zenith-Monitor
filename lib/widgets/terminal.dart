import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';

/* 
  todo: 
  .Get value from textfield 
  .Syncronize text with firebase storage
*/

class Terminal extends StatefulWidget {
  const Terminal({Key? key});

  @override
  _TerminalState createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

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
          terminalListView(),
          terminalTextField(),
        ],
      ),
    );
  }

  Expanded terminalListView() {
    return Expanded(
        child: ListView.builder(
      itemCount: 30, //Ammount of data to be shown at the screen.
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          "", // Here will be showed the text appering in the terminal.
          style: TextStyle(color: white),
        ),
      ),
      scrollDirection: Axis.vertical,
    ));
  }

  Padding terminalTextField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 0, 28, 37), //values from figma
      child: TextField(
        controller: textController,
        decoration: const InputDecoration(
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
