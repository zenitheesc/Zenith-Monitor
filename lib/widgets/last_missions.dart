import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/detalhes_missao.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';

class LastMissions extends StatefulWidget {
  const LastMissions({Key? key}) : super(key: key);

  @override
  _LastMissionsState createState() => _LastMissionsState();
}

class _LastMissionsState extends State<LastMissions> {
  @override
  Widget build(BuildContext context) {
    final List<Container> entries = [
      mainMissionContainer(context, "Garatéa V"),
      mainMissionContainer(context, "Garatéa III"),
      mainMissionContainer(context, "Garatéa II"),
      mainMissionContainer(context, "test-launch")
    ];
    return SafeArea(
        child: Scaffold(
      appBar: const StandardAppBar(title: "Últimas Missões"),
      backgroundColor: raisingBlack,
      body: Center(
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Align(
                    alignment: Alignment.center, child: entries[index]);
              })),
    ));
  }

  Container mainMissionContainer(BuildContext context, String missionTitle) {
    final _mainWidth = MediaQuery.of(context).size.width * 0.85;
    final _mainHeight = MediaQuery.of(context).size.height * 0.25;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: eerieBlack),
      width: _mainWidth,
      height: _mainHeight,
      child: Center(
        child: Column(
          children: [
            _missionContainerTitle(_mainWidth, _mainHeight, missionTitle),
            _missionContainterBody(_mainWidth, _mainHeight, missionTitle),
            const Divider(
              height: 0.5,
              thickness: 0.5,
              color: white,
            ),
            _mainContainterButton(missionTitle)
          ],
        ),
      ),
    );
  }

  Container _missionContainerTitle(
      double _mainWidth, double _mainHeight, String missionTitle) {
    return Container(
      alignment: Alignment.center,
      color: raisingBlack.withOpacity(0.75),
      width: _mainWidth,
      height: _mainHeight * 0.2,
      child: Text(missionTitle, style: const TextStyle(color: white)),
    );
  }

  Container _missionContainterBody(
      double _mainWidth, double _mainHeight, String missionTitle) {
    return Container(
        width: _mainWidth,
        height: _mainHeight * 0.6,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Altitude máxima: ", style: TextStyle(color: white)),
                  Text("Data de lançamento: ", style: TextStyle(color: white)),
                  Text("Status: ", style: TextStyle(color: white))
                ],
              ),
              CircleAvatar(
                radius: 35,
                backgroundColor: raisingBlack.withOpacity(0.75),
                child: Text(
                  missionTitle.split(" ").length == 1
                      ? missionTitle[0].toUpperCase()
                      : missionTitle.split(" ").reversed.elementAt(0),
                  style: const TextStyle(fontSize: 25, color: white),
                ),
              ),
            ],
          ),
        ));
  }

  Expanded _mainContainterButton(String missionTitle) {
    return Expanded(
      child: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetalhesMissao(
                          missionTitle: missionTitle,
                        )));
          },
          child: const Text(
            "Expandir Detalhes",
            style: TextStyle(color: white),
          )),
    );
  }
}
