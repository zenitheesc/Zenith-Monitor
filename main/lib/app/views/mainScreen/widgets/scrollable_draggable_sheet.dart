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
        initialChildSize: 0.27,
        minChildSize: 0.1,
        expand: false,
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
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 2,
                      children: <Widget>[
                        ScrollableSheetCard(altitude),
                        ScrollableSheetCard(velocidade),
                        ScrollableSheetCard(latitude),
                        ScrollableSheetCard(longitude)
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
  final DataType datatype;
  ScrollableSheetCard(this.datatype);

  @override
  _ScrollableSheetCardState createState() => _ScrollableSheetCardState();
}

class _ScrollableSheetCardState extends State<ScrollableSheetCard> {
  Widget _firstLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                widget.datatype.name,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              margin: widget.datatype.name == "Velocidade"
                  ? EdgeInsets.all(2.0)
                  : EdgeInsets.all(3.0),
              padding: widget.datatype.name == "Velocidade"
                  ? EdgeInsets.all(2.0)
                  : EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: Colors.white),
              ),
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  widget.datatype.unit,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.transparent,
            height: 100,
            child: Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        widget.datatype.icon,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(height: 25, child: _firstLine()),
                          Container(
                            height: 35,
                            child: Padding(
                              padding: EdgeInsets.all(0),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  widget.datatype.numericData,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
          ),
        ),
      ],
    );
  }
}

class ScrollableSheetMainCard extends StatefulWidget {
  _ScrollableSheetMainCardState createState() =>
      _ScrollableSheetMainCardState();
}

class _ScrollableSheetMainCardState extends State<ScrollableSheetMainCard> {
  List<Widget> generateSheetLineList() {
    List<DataType> datatypeList = [
      missionTime,
      null,
      temperatura,
      null,
      radiacao,
      null,
      other1,
      null,
      other2,
      null,
      temperatura
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
        width: double.infinity,
        child: Card(
          child: Column(
            children: generateSheetLineList(),
          ),
          color: Colors.white,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 20,
        ),
      ),
    );
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
  final DataType datatype;
  ScrollableSheetLine(this.datatype);

  @override
  _ScrollableSheetLineState createState() => _ScrollableSheetLineState();
}

class _ScrollableSheetLineState extends State<ScrollableSheetLine> {
  Widget _buildDatatype() {
    return Expanded(
      flex: (widget.datatype.name == "MISSION TIME") ? 2 : 3,
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
    );
  }

  Widget _buildActualText() {
    return Expanded(
      flex: (widget.datatype.name == "MISSION TIME") ? 3 : 2,
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
    );
  }

  Widget _buildPreviousText() {
    if (widget.datatype.name != "MISSION TIME") {
      return Expanded(
        flex: 2,
        child: FittedBox(
          fit: BoxFit.fitHeight,
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
                    : widget.datatype.previousData + " " + widget.datatype.unit,
                style: TextStyle(
                  color: Colors.grey[350],
                  fontSize: (SizeConfig.blockSizeHorizontal) * 3,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: 62,
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(
          top: (widget.datatype.name == "MISSION TIME") ? 20 : 15,
          left: 20,
          right: 20,
          bottom: 15,
        ),
        child: Container(
          height: 27,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _buildDatatype(),
              _buildActualText(),
              _buildPreviousText()
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollableSheetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: RaisedButton(
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          color: Colors.black,
          child: Container(
            width: double.infinity,
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
          ),
          onPressed: () {},
        ));
  }
}
