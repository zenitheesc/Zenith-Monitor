import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: eerieBlack,
      appBar: const StandardAppBar(title: "404"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 20),
                child: Text(
                  "Ops!",
                  style: TextStyle(
                    color: white,
                    fontSize: 100,
                    fontFamily: 'DMSans',
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 10, end: 10),
            child: Text(
                "Parece que os desenvolvedores do Zenith Monitor estavam com muitas provas e ainda não acabaram essa página...",
                style: TextStyle(
                  color: white,
                  fontSize: 30,
                  fontFamily: 'DMSans',
                )),
          )
        ],
      ),
    );
  }
}
