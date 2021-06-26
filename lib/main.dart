import 'package:flutter/material.dart';
import 'package:zenith_monitor/utils/mixins/class_user.dart';
import 'package:zenith_monitor/widgets/user_profile.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

void main() {
  runApp(const ZenithMonitor());
}

class ZenithMonitor extends StatelessWidget {
  const ZenithMonitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PagQualquer(),
    );
  }
}

class PagQualquer extends StatelessWidget {
  User user = User(
      "Leonardo Baptistela",
      //null,
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2O-oloCyx1l_-eeEaj4Irgt9WsIBbzwli5A&usqp=CAU",
      "Membro Zenith");

  //User user = User("Leonardo Baptistela", null, "Membro Zenith");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              UserProfile(user: user),
            ],
          ),
        ),
        backgroundColor: raisingBlack);
  }
}
