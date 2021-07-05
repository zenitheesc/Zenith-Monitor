// To-Do:
//        Fix Alignment of everything

import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class NossosValores extends StatelessWidget {
  NossosValores({Key? key});

  Widget nossosValoresContainer(String text, String pathToImg, String nomeImg) {
    return Container(
      width: 340,
      height: 94,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: eerieBlack,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  pathToImg,
                  color: null,
                  fit: BoxFit.cover,
                  width: 37.0,
                  height: 38.11,
                  colorBlendMode: BlendMode.dstATop,
                ),
                Text(
                  nomeImg,
                  style: TextStyle(
                      color: white, fontSize: 11, fontFamily: 'DMSans'),
                ),
              ],
            ),
          ),
          Container(
            child: VerticalDivider(color: white),
            height: 49,
          ),
          Expanded(
            flex: 4,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: white, fontFamily: 'DMSans'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: buildMainBody(),
        backgroundColor: raisingBlack);
  }

  Center buildMainBody() {
    return Center(
      child: GridView.count(
        crossAxisCount: 1,
        primary: false,
        childAspectRatio: 4,
        padding: EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          nossosValoresContainer(
              "Incentivar a produção científica nacional e facilitar o acesso à ciência no ambiente universitário.",
              "assets/images/figScientist.png",
              "Ciência"),
          nossosValoresContainer(
              "O zenith possui uma hierarquia horizontal, onde todos os integrantes possuem voz, mas responsabilidades distintas.",
              "assets/images/figGroup.png",
              "Pessoas"),
          nossosValoresContainer(
              "Os integrantes tem oportunidades de desenvolver capacitações técnicas em grupo, praticando suas soft skills.",
              "assets/images/figProfessional.png",
              "Habilidade"),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
        toolbarHeight: 80,
        backgroundColor: raisingBlack,
        elevation: 0.0,
        title: Text("Nossos Valores",
            style: TextStyle(color: white, fontSize: 20)),
        leading: IconButton(
            onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new_rounded)));
  }
}
