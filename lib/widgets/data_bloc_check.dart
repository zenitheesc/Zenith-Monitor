import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/core/pipelines/data_pipeline/bloc/data_bloc.dart';
import 'package:zenith_monitor/core/pipelines/mission_pipeline/mission_bloc.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';

class MissionSelectorPage extends StatefulWidget {
  const MissionSelectorPage({Key? key}) : super(key: key);

  @override
  _MissionSelectorPageState createState() => _MissionSelectorPageState();
}

class _MissionSelectorPageState extends State<MissionSelectorPage> {
  late String _missionNameString;
  bool buildData = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const StandardAppBar(title: "Mission Selector"),
        body: mainBody(context),
        backgroundColor: eerieBlack,
      ),
    );
  }

  Center mainBody(BuildContext context) {
    final FirestoreServices _fireServ = FirestoreServices();
    return Center(
      child: Column(
        children: [
          dropDownAndButton(),
          // expandedFunc(),
        ],
      ),
    );
  }

  Expanded expandedFunc() {
    return Expanded(
        child: BlocBuilder<DataBloc, DataState>(builder: (context, state) {
      return const Text("Teste", style: TextStyle(color: white));
    }));
  }

  Padding dropDownAndButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 25, 5, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          dropDownButtonFunc(),
          elevatedButtonFunc(),
        ],
      ),
    );
  }

  void getMissionData(String _missionName) {
    print(_missionName);
    final FirestoreServices _fireServ = FirestoreServices();
    _fireServ.init(_missionName);
    setState(() {
      buildData = true;
    });
  }

  ElevatedButton elevatedButtonFunc() => ElevatedButton(
      onPressed: () => getMissionData(_missionNameString),
      child: const Text("Get data"));

  Future<List<String>> callAsyncFetch() async {
    final FirestoreServices _fireServ = FirestoreServices();
    List<String> _missionNames = await _fireServ.getMissionNames();
    _missionNames.add('');
    return _missionNames;
  }

  FutureBuilder<List<String>> dropDownButtonFunc() {
    return FutureBuilder(
      future: callAsyncFetch(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          return DropdownButton<String>(
            value: _missionNameString,
            onChanged: (String? newValue) {
              setState(() {
                _missionNameString = newValue!;
              });
            },
            items: snapshot.data!.map((String missionNames) {
              return DropdownMenuItem(
                value: missionNames,
                child: Text(missionNames),
              );
            }).toList(),
            underline: Container(height: 2, color: gray),
            style: const TextStyle(color: gray),
          );
        } else {
          _missionNameString = '';
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
