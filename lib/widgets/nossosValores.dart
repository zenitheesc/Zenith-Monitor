// To-Do:
//        Add phrase under figure
//        Add top bar with 'Nossos valores' and return button.

import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class NossosValores extends StatelessWidget {
  NossosValores({Key? key});

  Widget nossosValoresContainer(String text, String pathToImg) {
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
          Container(
            child: Image.asset(
              pathToImg,
              color: null,
              fit: BoxFit.cover,
              width: 37.0,
              height: 38.11,
              colorBlendMode: BlendMode.dstATop,
            ),
            padding: EdgeInsets.all(10),
          ),
          Container(
            height: 49,
            child: VerticalDivider(color: white),
          ),
          Container(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(color: white),
            ),
            padding: EdgeInsets.all(2),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Spacer(flex: 2),
              nossosValoresContainer(
                  "Incentivar a produção científica nacional\n e facilitar o acesso à ciência no\n ambiente universitário",
                  "assets/images/figGroup.png"),
              Spacer(flex: 1),
              nossosValoresContainer(
                  "O zenith possui uma hierarquia horizontal,\n onde todos os integrantes possuem voz,\n mas responsabilidades distintas",
                  "assets/images/figProfessional.png"),
              Spacer(flex: 1),
              nossosValoresContainer(
                  "Os integrantes tem oportunidades de\n desenvolver capacitações técnicas\n em grupo, praticando suas soft skills.",
                  "assets/images/figScientist.png"),
              Spacer(flex: 8),
            ],
          ),
        ),
        backgroundColor: raisingBlack);
  }
}
