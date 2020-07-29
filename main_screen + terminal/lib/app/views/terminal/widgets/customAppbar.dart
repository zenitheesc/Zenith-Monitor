import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  Color textColor = Colors.grey[100];
  List<String> accumulator;
  List<String> cleanAccumulator;
  final Size preferredSize;

  CustomAppBar(this.textColor, this.accumulator, this.cleanAccumulator)
      : preferredSize = Size.fromHeight(110.0);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  List<PopupMenuItem> menuItems = [
    PopupMenuItem(
      value: 1,
      child: Text("Clean Terminal"),
    ),
  ];

  void _selected(int value) {
    setState(() {
      if (value == 1) {
        widget.cleanAccumulator.clear();
      }
    });
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/map')),
                PopupMenuButton(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  itemBuilder: (BuildContext context) => menuItems,
                  onSelected: (value) => _selected(value),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Terminal",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Open Sans",
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 25)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
