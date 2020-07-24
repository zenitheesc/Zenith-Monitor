import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Are you a member??"),
          RaisedButton(
              onPressed: () => Navigator.pushNamed(context, '/map'),
              child: Text("Yes")),
          RaisedButton(onPressed: () => {}, child: Text("No")),
        ],
      ),
    );
  }
}
