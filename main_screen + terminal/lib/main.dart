import 'package:flutter/material.dart';

import 'app/views/loginPage/fakeLoginPage.dart';
import 'app/views/mainScreen/Widgets/mainScreenWidget.dart';
import 'app/views/terminal/terminal.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  // Not a real part of the project ----------------------------------------------
  Stream<String> fakeDataSend =
      Stream<String>.periodic(Duration(seconds: 1), (int count) {
    return ('$count, ${count * 5}, ${count * 1.7 + 10}, ${count * 41.5 - 2}, ${count * 11}, ${count + 255}, 5');
  }).take(100);
  // -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Screen',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: MainScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/map': (context) => MainScreen(),
        '/terminal': (context) => TerminalView(input: fakeDataSend),
      },
    );
  }
}
