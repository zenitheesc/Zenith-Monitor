import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class AboutUsZenithMonitor extends StatelessWidget {
  AboutUsZenithMonitor({Key? key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: aboutUsZenithMonitorContainer(),
      backgroundColor: raisingBlack,
    );
  }

  Center aboutUsZenithMonitorContainer() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 340,
            height: 94,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: eerieBlack,
            ),
            child: Center(
              child: Text(
                "O app conta com todo nosso acervo de projetos, com o acompanhamento em tempo real de todos nossos lançamentos e suas informações técnicas.",
                style:
                    TextStyle(color: white, fontSize: 11, fontFamily: 'DMSans'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        toolbarHeight: 80,
        backgroundColor: raisingBlack,
        elevation: 0.0,
        title: Text("O Zenith Monitor",
            style: TextStyle(color: white, fontSize: 20)),
        leading: IconButton(
            onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new_rounded)));
  }
}
