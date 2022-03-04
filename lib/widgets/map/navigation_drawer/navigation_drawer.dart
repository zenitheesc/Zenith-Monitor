import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/map/map.dart';
import 'get_for_orientation_functions.dart';

// ignore: camel_case_types
class navigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 1);

  @override
  Widget build(BuildContext context) {
    const name = 'fulano fulano';
    const email = 'fulano@usp.br';
    const urlImage = '';

    return OrientationBuilder(
        builder: (context, orientation) => (Stack(
              children: [
                Container(
                  width: getSizeForOrientation(context, orientation),
                  child: Drawer(
                    child: Material(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      child: ListView(
                        children: <Widget>[
                          buildHeader(context, orientation,
                              urlImage: urlImage,
                              name: name,
                              email: email,
                              onClicked: () {}
                              // => Navigator.of(context).push(MaterialPageRoute(
                              //   // builder: (context) => UserPage(
                              //   // ),
                              // )
                              // ),
                              ),
                          Column(
                            children: [
                              SizedBox(
                                  height: screenSize(
                                      context,
                                      getTypeSizeForOrientation(
                                          context, orientation),
                                      0.005)),
                              buildMenuItem(
                                context,
                                orientation,
                                text: 'Terminal',
                                onClicked: () => selectedItem(context, 0),
                              ),
                              buildMenuItem(
                                context,
                                orientation,
                                text: 'Configurações',
                                onClicked: () => selectedItem(context, 1),
                              ),
                              buildMenuItem(
                                context,
                                orientation,
                                text: 'Estatísticas',
                                onClicked: () => selectedItem(context, 2),
                              ),
                              buildMenuItem(
                                context,
                                orientation,
                                text: 'Missões',
                                onClicked: () => selectedItem(context, 3),
                              ),
                              buildMenuItem(
                                context,
                                orientation,
                                text: 'Sobre nós',
                                onClicked: () => selectedItem(context, 3),
                              ),
                              SizedBox(
                                  height: getExitSpacingForOrientation(
                                      context, orientation)),
                              Text('Sair',
                                  style: TextStyle(
                                    fontSize: getFontSizeForOrientation(
                                        context, orientation),
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
              ],
            )));
  }

  Widget buildHeader(
    BuildContext context,
    Orientation orientation, {
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(
              vertical: screenSize(context, "height", 0.01))),
          decoration: BoxDecoration(
              color: Colors.white, border: Border.all(color: Colors.white)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: getAvatarSizeForOrientation(context, orientation),
                  backgroundColor: Colors.black,
                  child: IconButton(
                    iconSize: getIconSizeForOrientation(context, orientation),
                    icon: const Icon(Icons.person_add),
                    onPressed: () {},
                  )),

              SizedBox(
                  height: screenSize(context,
                      getTypeSizeForOrientation(context, orientation), 0.002)),
              //  backgroundImage: AssetImage(urlImage)),
              Text(
                name,
                style: TextStyle(
                    fontSize: screenSize(context,
                        getTypeSizeForOrientation(context, orientation), 0.022),
                    color: Colors.black),
              ),
              SizedBox(
                  height: screenSize(context,
                      getTypeSizeForOrientation(context, orientation), 0.0015)),
              Text(
                email,
                style: TextStyle(
                    fontSize: screenSize(context,
                        getTypeSizeForOrientation(context, orientation), 0.018),
                    color: Colors.black),
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem(
    BuildContext context,
    Orientation orientation, {
    required String text,
    VoidCallback? onClicked,
  }) {
    const color = white;
    const hoverColor = Colors.white70;

    return ListTile(
      visualDensity: VisualDensity(
          horizontal: 0, vertical: getVisualDensityForOrientation(orientation)),
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: getFontSizeForOrientation(context, orientation),
                  color: color,
                  fontFamily: 'DMSans'),
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
    //       builder: (context) => Page...(),
    //     ));
    //     break;
    //   case 1:
    //     Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => Page..(),
    //     ));
    //     break;
    // }
  }
}
