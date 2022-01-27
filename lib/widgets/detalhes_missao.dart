import 'package:flutter/material.dart';
import 'dart:io';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/utils/ui/plots/plot_gen.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';

class DetalhesMissao extends StatelessWidget {
  final String missionTitle;

  const DetalhesMissao({Key? key, required this.missionTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mainWidth = MediaQuery.of(context).size.width * 0.9;
    final _mainHeight = MediaQuery.of(context).size.height * 0.25;
    List<Widget> mainWidgetOrder = [
      mainContainerTitle(_mainWidth, _mainHeight),
      imageContainer(_mainWidth, _mainHeight),
      mainDataWidgets(_mainWidth, _mainHeight),
    ];

    return SafeArea(
        child: Scaffold(
      appBar: const StandardAppBar(title: "Detalhes da Missão"),
      backgroundColor: raisingBlack,
      body: Center(
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 0.8);
          },
          itemCount: mainWidgetOrder.length,
          itemBuilder: (context, index) {
            return Align(
                alignment: Alignment.center, child: mainWidgetOrder[index]);
          },
        ),
      ),
    ));
  }

  Container mainDataWidgets(double _mainWidth, double _mainHeight) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: eerieBlack),
      width: _mainWidth,
      child: Column(
        children: [
          titleDadosGerais(),
          tableData(),
          mapAccessButton(_mainWidth, _mainHeight),
          titleEstatisticas(),
          estatisticasContainer(_mainWidth, _mainHeight, "Altitude"),
          estatisticasContainer(_mainWidth, _mainHeight, "Velocidade"),
          estatisticasContainer(_mainWidth, _mainHeight, "Pressão"),
        ],
      ),
    );
  }

  Padding estatisticasContainer(
      double _mainWidth, double _mainHeight, String estatisticasType) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          width: _mainWidth,
          height: _mainHeight * 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: raisingBlack,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(estatisticasType,
                        style: const TextStyle(color: gray, fontSize: 16)),
                    const Text("data_from_type",
                        style: TextStyle(color: gray, fontSize: 16)),
                  ],
                ),
                Expanded(
                    child: PlotGenerator(
                        animate: false, seriesList: createSampleData()))
              ],
            ),
          ),
        ));
  }

  Padding mapAccessButton(double _mainWidth, double _mainHeight) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: _mainWidth,
        height: _mainHeight * 0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: raisingBlack),
        child: TextButton(
            onPressed: () {},
            child: const Text(
              "Acessar Mapa da Missão",
              style: TextStyle(color: white),
            )),
      ),
    );
  }

  Align titleEstatisticas() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12, 8, 0, 8),
        child: Text(
          "Estatísticas",
          style: TextStyle(color: gray, fontSize: 14),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Align titleDadosGerais() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12, 8, 0, 8),
        child: Text(
          "Dados Gerais",
          style: TextStyle(color: gray, fontSize: 14),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Padding tableData() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: raisingBlack),
        child: Table(
          border: TableBorder.symmetric(inside: const BorderSide(color: gray)),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: const [
            TableRow(children: [
              SizedBox(
                height: 50,
                child: Text("Altitude máxima alcançada",
                    style: TextStyle(color: white),
                    textAlign: TextAlign.center),
              ),
              Text("Data",
                  style: TextStyle(color: white), textAlign: TextAlign.center)
            ]),
            TableRow(children: [
              SizedBox(
                height: 30,
                child: Text("Data de lançameneto",
                    style: TextStyle(color: white),
                    textAlign: TextAlign.center),
              ),
              Text("Data",
                  style: TextStyle(color: white), textAlign: TextAlign.center)
            ]),
            TableRow(children: [
              SizedBox(
                height: 30,
                child: Text("Status da Missão",
                    style: TextStyle(color: white),
                    textAlign: TextAlign.center),
              ),
              Text("Data",
                  style: TextStyle(color: white), textAlign: TextAlign.center)
            ]),
            TableRow(children: [
              SizedBox(
                height: 30,
                child: Text("Tempo total",
                    style: TextStyle(color: white),
                    textAlign: TextAlign.center),
              ),
              Text("Data",
                  style: TextStyle(color: white), textAlign: TextAlign.center)
            ])
          ],
        ),
      ),
    );
  }

  Container mainContainerTitle(double _mainWidth, double _mainHeight) {
    return Container(
      alignment: Alignment.center,
      width: _mainWidth,
      height: _mainHeight * 0.25,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: eerieBlack.withOpacity(0.5)),
      child: Text(missionTitle,
          style: const TextStyle(fontSize: 20, color: white)),
    );
  }

  Container imageContainer(double _mainWidth, double _mainHeight) {
    final String imgPath = "assets/images/" + missionTitle + ".png";

    bool checkIfImageExists = File(imgPath).existsSync();

    return Container(
      width: _mainWidth,
      height: _mainHeight * 1.2,
      child: checkIfImageExists
          ? Image.asset(imgPath, fit: BoxFit.cover)
          : const Center(
              child: Text("Image Not Found",
                  style: TextStyle(color: white, fontSize: 20)),
            ),
      // child: Image.asset(imgPath, fit: BoxFit.cover),
    );
  }
}
