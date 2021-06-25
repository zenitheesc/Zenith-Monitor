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
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                ),
                Container(
                  child: Text(
                    nomeImg,
                    style: TextStyle(color: white, fontSize: 11),
                  ),
                ),
              ],
            ),
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
              Spacer(),
              Container(
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(25),
                        child: Image.asset(
                          "assets/images/botaoVoltar.png",
                          color: white,
                          fit: BoxFit.cover,
                          width: 12,
                          height: 12,
                        )),
                    Container(
                      child: Text(
                        "Nossos Valores",
                        style: TextStyle(color: white, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
              nossosValoresContainer(
                  "Incentivar a produção científica nacional\n e facilitar o acesso à ciência no\n ambiente universitário",
                  "assets/images/figScientist.png",
                  "Ciência"),
              Spacer(flex: 1),
              nossosValoresContainer(
                  "O zenith possui uma hierarquia\n horizontal, onde todos os integrantes\n possuem voz, mas responsabilidades\n distintas",
                  "assets/images/figGroup.png",
                  "Pessoas"),
              Spacer(flex: 1),
              nossosValoresContainer(
                  "Os integrantes tem oportunidades de\n desenvolver capacitações técnicas\n em grupo, praticando suas soft skills.",
                  "assets/images/figProfessional.png",
                  "Habilidade"),
              Spacer(flex: 12),
            ],
          ),
        ),
        backgroundColor: raisingBlack);
  }
}
