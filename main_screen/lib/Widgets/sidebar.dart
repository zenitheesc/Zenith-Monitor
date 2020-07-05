import 'package:flutter/material.dart';
import '../datatypes.dart';
import '../function.dart';

List<String> zenith_user_side_bar_list = [
  "Terminal",
  "Últimas missões",
  "Sobre nós"
];
List<String> entusiasta_side_bar_list = ["Últimas missões", "Sobre nós"];

class SideBar extends StatefulWidget {
  User user;

  SideBar(this.user);

  @override
  SideBarState createState() => SideBarState();
}

class SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              widget.user.name,
              style: TextStyle(fontSize: 18.0),
            ),
            // Using accountEmail atribute to show access level
            accountEmail: Text(widget.user.access_level),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: (widget.user.image == null)
                  ? Text(
                      widget.user.name[0],
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.black12,
                      ),
                    )
                  : Image.asset(widget.user.image),
            ),
          ),
          new ListView.builder(
            shrinkWrap: true,
            itemCount: (widget.user.access_level == "Entusiasta")
                ? entusiasta_side_bar_list.length
                : zenith_user_side_bar_list.length,
            itemBuilder: (widget.user.access_level == "Entusiasta")
                ? (BuildContext context, int index) =>
                    build_side_bar(context, index, entusiasta_side_bar_list)
                : (BuildContext context, int index) =>
                    build_side_bar(context, index, zenith_user_side_bar_list),
          )
        ],
      ),
    );
  }
}
