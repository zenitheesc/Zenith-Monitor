import 'dart:html';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:flutter/material.dart';

class MissionCreation extends StatefulWidget {
  const MissionCreation({Key? key}) : super(key: key);

  @override
  _MissionCreationState createState() => _MissionCreationState();
}

class _MissionCreationState extends State<MissionCreation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1080.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              style: TextStyle(color: white,),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: gray),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: gray),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: gray),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                labelText: 'Inserir novo campo',
              ),
            ),
          ),  
          SizedBox(width: 20,),
          Expanded(
            child: TextField(
              style: TextStyle(color: white),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: gray),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: gray),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: gray),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                labelText: 'Tipo',
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Row(
              children: <Widget>[FloatingActionButton(
                  onPressed: (){
                    // onPressed code
                  },
                  child: const Icon(Icons.add, color: eerieBlack,),
                  backgroundColor: gray,
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}