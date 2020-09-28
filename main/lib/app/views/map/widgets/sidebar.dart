import 'package:flutter/material.dart';
import 'package:zenith_monitor/app/models/user.dart';
import 'package:zenith_monitor/app/services/auth/firebase_authentication.dart';

import 'package:zenith_monitor/app/views/map/widgets/datatypes.dart';

import 'package:zenith_monitor/app/views/scale_screen_size.dart';

class SideBar extends StatefulWidget {
  final User user;
  SideBar(this.user);

  @override
  SideBarState createState() => SideBarState();
}

class SideBarState extends State<SideBar> {
  AuthManager _authManager;

  ZUser _user;

  SideBarState() {
    _authManager = AuthManager();
  }
  List<String> zenithUserSideBarList = [
    "Terminal",
    "Últimas missões",
    "Sobre nós"
  ];
  List<String> entusiastaSideBarList = ["Últimas missões", "Sobre nós"];

  Widget buildSideBar(
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
          StreamBuilder(
              stream: _authManager.user,
              initialData: _authManager.preLoggedUser,
              builder: (context, AsyncSnapshot<ZUser> snap) {
                // print(snap.data.name);
                if (snap.connectionState == ConnectionState.active &&
                    snap.data != null) {
                  return UserAccountsDrawerHeader(
                    accountName: Text(
                      snap.data.email.split('@')[0],
                      style: TextStyle(fontSize: 18.0),
                    ),
                    // Using accountEmail atribute to show access level
                    accountEmail: Text(snap.data.email),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: (snap.data.imageUrl == null)
                          ? Text(
                              snap.data.email[0],
                              style: TextStyle(
                                fontSize: 40.0,
                                color: Colors.black12,
                              ),
                            )
                          : Image.asset(snap.data.imageUrl),
                    ),
                  );
                } else
                  return Container();
              }),
          new ListView.builder(
            shrinkWrap: true,
            itemCount: (widget.user.accessLevel == "Entusiasta")
                ? entusiastaSideBarList.length
                : zenithUserSideBarList.length,
            itemBuilder: (widget.user.accessLevel == "Entusiasta")
                ? (BuildContext context, int index) =>
                    buildSideBar(context, index, entusiastaSideBarList)
                : (BuildContext context, int index) =>
                    buildSideBar(context, index, zenithUserSideBarList),
          ),
          ListTile(
            // title: Text("Sair"),
            title: Text(
              "Sair",
              style: TextStyle(
                color: Colors.black,
                fontSize: (SizeConfig.blockSizeHorizontal) * 5,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              _authManager.signOut();
              Navigator.of(context).popAndPushNamed('/login');
            },
          ),
        ],
      ),
    );
  }
}
