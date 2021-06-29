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
      "leon8**ardo ba+_-ptIs,\Tela",
      null,
      //"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2O-oloCyx1l_-eeEaj4Irgt9WsIBbzwli5A&usqp=CAU",
      "meMb0ro7 zenIT67%%H");

  //User user = User("Leonardo Baptistela", null, "Membro Zenith");

  //user.setName("leonardo");

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
      backgroundColor: raisingBlack,
    );
  }
}
