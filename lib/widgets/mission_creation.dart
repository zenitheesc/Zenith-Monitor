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
      width: MediaQuery.of(context).size.width*0.83,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          1: FractionColumnWidth(0.03),
          2: FractionColumnWidth(0.25),
          3: FractionColumnWidth (0.15)
        }, 
        children: [
          TableRow(children: [
            TextField(
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.normal
                ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(7.5),
                isDense: true,
                hintStyle: TextStyle(color: gray),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: gray),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: gray),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                hintText: 'Inserir novo campo'
              ),
            ),
            SizedBox(width: 10),
            TextField(
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.normal
                ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(7.5),
                isDense: true,
                hintStyle: TextStyle(color: gray),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: gray),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: gray),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                hintText: 'Tipo',
              ),
            ),
            SizedBox(
              height: 30,
              width: 30,
              child:
                FloatingActionButton(
                    onPressed: (){
                      // onPressed code
                    },
                    child: const Icon(Icons.add, color: eerieBlack,),
                    backgroundColor: gray,
                )
            ) 
          ]),
        ]
      ),
    );
  }
}