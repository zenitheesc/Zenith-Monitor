import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/map/map.dart';

// ignore: camel_case_types
class navigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 1);
  @override
  Widget build(BuildContext context) {
    const name = 'fulano fulano';
    const email = 'fulano@usp.br';
    const urlImage = '';

    return Stack(
      children: [
        Container(
          width: 0.5 * MediaQuery.of(context).size.width,
          child: Drawer(
            child: Material(
              color: const Color.fromRGBO(0, 0, 0, 1),
              child: ListView(
                children: <Widget>[
                  buildHeader(
                      urlImage: urlImage,
                      name: name,
                      email: email,
                      onClicked: () {}
                      // => Navigator.of(context).push(MaterialPageRoute(
                      //   // builder: (context) => UserPage(
                      //   //   name: 'Sarah Abs',
                      //   //   urlImage: urlImage,
                      //   // ),
                      // )
                      // ),
                      ),
                  Column(
                    children: [
                      SizedBox(height: screenSize(context, "height", 0.01)),
                      buildMenuItem(
                        text: 'Terminal',
                        onClicked: () => selectedItem(context, 0),
                      ),
                      // const SizedBox(height: 8),
                      buildMenuItem(
                        text: 'Configurações',
                        onClicked: () => selectedItem(context, 1),
                      ),
                      // const SizedBox(height: 8),
                      buildMenuItem(
                        text: 'Estatísticas',
                        onClicked: () => selectedItem(context, 2),
                      ),
                      // const SizedBox(height: 8),
                      buildMenuItem(
                        text: 'Missões',
                        onClicked: () => selectedItem(context, 3),
                      ),
                      // const SizedBox(height: 8),
                      buildMenuItem(
                        text: 'Sobre nós',
                        onClicked: () => selectedItem(context, 3),
                      ),
                      SizedBox(height: screenSize(context, "height", 0.3)),
                      const Text('Sair',
                          style: TextStyle(
                            color: white,
                            fontFamily: 'DMSans',
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
            child: Stack(children: <Widget>[
          Center(
            child: CustomPaint(size: const Size(20, 50), painter: Draw()),
          ),
          Center(
              child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.black,
            child: IconButton(
              color: Colors.white,
              iconSize: MediaQuery.of(context).size.height * 0.02,
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
          )),
        ])),
      ],
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 10)),
          decoration: BoxDecoration(
              color: Colors.white, border: Border.all(color: Colors.white)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.black,
                  child: IconButton(
                    iconSize: 40,
                    icon: const Icon(Icons.person_add),
                    onPressed: () {},
                  )),

              const SizedBox(height: 4),
              //  backgroundImage: AssetImage(urlImage)),
              Text(
                name,
                style: const TextStyle(fontSize: 25, color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    VoidCallback? onClicked,
  }) {
    const color = white;
    final hoverColor = Colors.white70;

    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -3),
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(color: color, fontFamily: 'DMSans'),
            ),
          ],
        ),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    // switch (index) {
    //   case 0:
    //     Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => PeoplePage(),
    //     ));
    //     break;
    //   case 1:
    //     Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => FavouritesPage(),
    //     ));
    //     break;
    // }
  }
}
