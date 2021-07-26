import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';

class NossosValores extends StatelessWidget {
  NossosValores({Key? key});

  final List<String> textosPrincipais = [
    "Incentivar a produção científica nacional e facilitar o acesso à ciência no ambiente universitário.",
    "O zenith possui uma hierarquia horizontal, onde todos os integrantes possuem voz, mas responsabilidades distintas.",
    "Os integrantes tem oportunidades de desenvolver capacitações técnicas em grupo, praticando suas soft skills."
  ];
  final List<String> caminhoImagens = [
    "assets/images/figScientist.png",
    "assets/images/figGroup.png",
    "assets/images/figProfessional.png"
  ];
  final List<String> nomeImagem = ["Ciência", "Pessoas", "Habilidade"];

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
                  style: const TextStyle(
                      color: white, fontSize: 11, fontFamily: 'DMSans'),
                ),
              ],
            ),
          ),
          Container(
            child: const VerticalDivider(color: white),
            height: 49,
          ),
          Expanded(
            flex: 4,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: white, fontFamily: 'DMSans'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const StandardAppBar(title: "Nossos Valores"),
        body: buildMainBody(),
        backgroundColor: raisingBlack);
  }

  Center buildMainBody() {
    return Center(
      child: GridView.count(
        crossAxisCount: 1,
        primary: false,
        childAspectRatio: 4,
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          for (var i = 0; i < nomeImagem.length; i++)
            nossosValoresContainer(
                textosPrincipais[i], caminhoImagens[i], nomeImagem[i])
        ],
      ),
    );
  }
}
