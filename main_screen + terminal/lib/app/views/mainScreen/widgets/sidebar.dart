import 'package:flutter/material.dart';

import '../datatypes.dart';
import '../../../scale_screen_size.dart';

class SideBar extends StatefulWidget {
  User user;
  SideBar(this.user);

  @override
  SideBarState createState() => SideBarState();
}

class SideBarState extends State<SideBar> {
  List<String> zenithUserSideBarList = [
    "Terminal",
    "Últimas missões",
    "Sobre nós"
  ];
  List<String> entusiastaSideBarList = ["Últimas missões", "Sobre nós"];

  Widget build_side_bar(
      BuildContext context, int index, List<String> sideBarList) {
    return new ListTile(
      title: Text(
        sideBarList[index],
        style: TextStyle(
          color: Colors.black,
          fontSize: (SizeConfig.blockSizeHorizontal) * 5,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: sideBarList[index] == "Terminal"
          ? () => Navigator.pushNamed(context, '/terminal')
          : () {},
    );
  }

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
            accountEmail: Text(widget.user.accessLevel),
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
            itemCount: (widget.user.accessLevel == "Entusiasta")
                ? entusiastaSideBarList.length
                : zenithUserSideBarList.length,
            itemBuilder: (widget.user.accessLevel == "Entusiasta")
                ? (BuildContext context, int index) =>
                    build_side_bar(context, index, entusiastaSideBarList)
                : (BuildContext context, int index) =>
                    build_side_bar(context, index, zenithUserSideBarList),
          )
        ],
      ),
    );
  }
}
