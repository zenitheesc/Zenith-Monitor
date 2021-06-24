// This file isn't complete
// It shouldn't be inclued on the main application
// This is still for testing purposes

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Nossos Valores'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Cores:
  var backgroundColor = 0xff292B2D;
  var backgroundTextsColor = 0xff161719;
  var fontColor = 0xffffffff;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(backgroundColor),
      appBar: AppBar(
        backgroundColor: Color(backgroundColor),
        title: Text(widget.title),
      ),
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
    );
  }
}

Widget nossosValoresContainer(String text, String pathToImg) {
  var backgroundTextsColor = 0xff161719;
  var fontColor = 0xffffffff;
  final ret = Container(
    width: 331,
    height: 94,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Color(backgroundTextsColor),
    ),
    child: Row(
      children: [
        Spacer(
          flex: 4,
        ),
        Container(
            child: Image.asset(
          pathToImg,
          color: null,
          fit: BoxFit.cover,
          width: 37.0,
          height: 38.11,
          colorBlendMode: BlendMode.dstATop,
        )),
        Spacer(
          flex: 1,
        ),
        Container(height: 49, child: VerticalDivider(color: Color(fontColor))),
        Spacer(
          flex: 4,
        ),
        Container(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(fontColor)),
          ),
        ),
        Spacer(
          flex: 4,
        )
      ],
    ),
  );
  return ret;
}
