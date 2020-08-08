import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../scale_screen_size.dart';
import '../datatypes.dart';

class DraggableSheet extends StatefulWidget {
  @override
  _DraggableSheetState createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DraggableScrollableSheet(
        // fps sofre muito com sheet parcial
        initialChildSize: 0.27,
        minChildSize: 0.1,
        builder: (BuildContext context, scroller) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200].withOpacity(0.9), //note
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              child: ListView(
                controller: scroller,
                children: <Widget>[
                  Icon(
                    Icons.maximize,
                    color: Colors.black12,
                    size: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ScrollableSheetCard(Altitude),
                        ScrollableSheetCard(Velocidade),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ScrollableSheetCard(Latitude),
                        ScrollableSheetCard(Longitude),
                      ],
                    ),
                  ),
                  ScrollableSheetDivider(),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text("\n     MORE INFORMATION",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: (SizeConfig.blockSizeHorizontal) * 3,
                        )),
                  ),
                  ScrollableSheetMainCard(),
                  ScrollableSheetButton(),
                ],
              ));
        });
  }
}

class ScrollableSheetCard extends StatefulWidget {
  DataType datatype;
  ScrollableSheetCard(this.datatype);

  @override
  _ScrollableSheetCardState createState() => _ScrollableSheetCardState();
}

class _ScrollableSheetCardState extends State<ScrollableSheetCard> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: 200,
      height: 100,
      child: Card(
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                widget.datatype.icon,
                color: Colors.white,
                size: 25,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(2),
                        child: Text(
                          widget.datatype.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: widget.datatype.name == "Velocidade"
                                ? (SizeConfig.blockSizeHorizontal) * 3.3
                                : (SizeConfig.blockSizeHorizontal) * 4,
                          ),
                        ),
                      ),
                      Container(
                          margin: widget.datatype.name == "Velocidade"
                              ? EdgeInsets.all(2.0)
                              : EdgeInsets.all(4.0),
                          padding: widget.datatype.name == "Velocidade"
                              ? EdgeInsets.all(2.0)
                              : EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Text(
                            widget.datatype.unit,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: widget.datatype.name == "Velocidade"
                                  ? (SizeConfig.blockSizeHorizontal) * 1.7
                                  : (SizeConfig.blockSizeHorizontal) * 2,
                            ),
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      widget.datatype.numericData,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: (SizeConfig.blockSizeHorizontal) * 6.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: Colors.black87,
        elevation: 10,
      ),
    );
  }
}

class ScrollableSheetMainCard extends StatefulWidget {
  _ScrollableSheetMainCardState createState() =>
      _ScrollableSheetMainCardState();
}

class _ScrollableSheetMainCardState extends State<ScrollableSheetMainCard> {
  List<Widget> generate_sheet_line_list() {
    List<DataType> datatypeList = [
      MissionTime,
      null,
      Temperatura,
      null,
      Radiacao,
      null,
      Other1,
      null,
      Other2
    ];
    List<Widget> scrollableSheetList = [];

    for (var i = 0; i < datatypeList.length; i++) {
      if (datatypeList[i] == null) {
        scrollableSheetList.add(ScrollableSheetDivider());
      } else {
        scrollableSheetList.add(ScrollableSheetLine(datatypeList[i]));
      }
    }

    return scrollableSheetList;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          height: 430,
          width: 400,
          child: Card(
            child: ListView(
              children: generate_sheet_line_list(),
            ),
            color: Colors.white,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 20,
          ),
        ));
  }
}

class ScrollableSheetDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.black38,
      height: 12.0,
      indent: 10.0,
      endIndent: 10.0,
    );
  }
}

class ScrollableSheetLine extends StatefulWidget {
  DataType datatype;
  ScrollableSheetLine(this.datatype);

  @override
  _ScrollableSheetLineState createState() => _ScrollableSheetLineState();
}

class _ScrollableSheetLineState extends State<ScrollableSheetLine> {
  Widget build_previous_text() {
    if (widget.datatype.name != "MISSION TIME") {
      return Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  "PREVIOUS:",
                  style: TextStyle(
                    color: Colors.grey[350],
                    fontSize: (SizeConfig.blockSizeHorizontal) * 2.5,
                  ),
                ),
                Text(
                  (widget.datatype.unit == "°")
                      ? widget.datatype.previousData + widget.datatype.unit
                      : widget.datatype.previousData +
                          " " +
                          widget.datatype.unit,
                  style: TextStyle(
                    color: Colors.grey[350],
                    fontSize: (SizeConfig.blockSizeHorizontal) * 3,
                  ),
                ),
              ],
            ),
          ));
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: (widget.datatype.name == "MISSION TIME") ? 2 : 3,
          child: Padding(
            padding: EdgeInsets.only(
              top: (widget.datatype.name == "MISSION TIME") ? 25 : 20,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                (widget.datatype.name == "MISSION TIME")
                    ? widget.datatype.name
                    : widget.datatype.name + " (${widget.datatype.unit})",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: (SizeConfig.blockSizeHorizontal) * 3,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: (widget.datatype.name == "MISSION TIME") ? 3 : 2,
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 10,
              top: 20,
              bottom: 20,
            ),
            child: Text(
              widget.datatype.numericData,
              textAlign: (widget.datatype.name == "MISSION TIME")
                  ? TextAlign.center
                  : TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: (SizeConfig.blockSizeHorizontal) * 4.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        build_previous_text()
      ],
    );
  }
}

class ScrollableSheetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: RaisedButton(
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          color: Colors.black,
          child: Row(
            children: <Widget>[
              Image.asset(
                "assets/images/zenith_black_logo.png",
                height: 50,
              ),
              Text(
                "Get Statistics",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: (SizeConfig.blockSizeHorizontal) * 4.7,
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
          onPressed: () {},
        ));
  }
}
