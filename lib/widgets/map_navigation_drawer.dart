import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 1);
  double finalSize(
      Orientation orientation, double portraitValue, double landscapeValue) {
    if (orientation == Orientation.landscape) {
      return landscapeValue;
    } else {
      return portraitValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    const name = 'fulano fulano';
    const email = 'fulano@usp.br';
    const urlImage = '';
    const List<String> list = [
      'Terminal',
      'Configurações',
      'Estatísticas',
      'Missões',
      'Sobre nós'
    ];
    return OrientationBuilder(
        builder: (context, orientation) => (Stack(
              children: [
                Container(
                  width: finalSize(
                      orientation,
                      MediaQuery.of(context).size.width * 0.5,
                      MediaQuery.of(context).size.width * 0.3),
                  child: Drawer(
                    child: Material(
                      color: Colors.black,
                      child: ListView(
                        children: <Widget>[
                          buildHeader(context, orientation,
                              urlImage: urlImage,
                              name: name,
                              email: email,
                              onClicked: () {}),
                          SizedBox(
                              height: finalSize(
                                  orientation,
                                  MediaQuery.of(context).size.height * 0.005,
                                  MediaQuery.of(context).size.width * 0.005)),
                          for (String page in list)
                            buildMenuItem(context, orientation, text: page),

                          /// When all page routes are created, a navigator.push needs to be passed as an argument

                          SizedBox(
                              height: finalSize(
                                  orientation,
                                  MediaQuery.of(context).size.height * 0.35,
                                  MediaQuery.of(context).size.height * 0.01)),
                          buildMenuItem(
                            context,
                            orientation,
                            text: 'Sair',
                            onClicked: () {},
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
  }) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        padding: padding.add(EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01)),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: finalSize(
                    orientation,
                    MediaQuery.of(context).size.height * 0.04,
                    MediaQuery.of(context).size.width * 0.035),
                backgroundColor: Colors.black,
                child: IconButton(
                  iconSize: finalSize(
                      orientation,
                      MediaQuery.of(context).size.height * 0.045,
                      MediaQuery.of(context).size.width * 0.04),
                  icon: const Icon(
                    Icons.person_add,
                    color: white,
                  ),
                  onPressed: () {},
                )),

            SizedBox(
                height: finalSize(
                    orientation,
                    MediaQuery.of(context).size.height * 0.002,
                    MediaQuery.of(context).size.width * 0.002)),
            //  backgroundImage: AssetImage(urlImage)),
            Text(
              name,
              style: TextStyle(
                  fontSize: finalSize(
                      orientation,
                      MediaQuery.of(context).size.height * 0.022,
                      MediaQuery.of(context).size.width * 0.022),
                  color: Colors.black),
            ),
            SizedBox(
                height: finalSize(
                    orientation,
                    MediaQuery.of(context).size.height * 0.0015,
                    MediaQuery.of(context).size.width * 0.0015)),
            Text(
              email,
              style: TextStyle(
                  fontSize: finalSize(
                      orientation,
                      MediaQuery.of(context).size.height * 0.018,
                      MediaQuery.of(context).size.width * 0.018),
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

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
          horizontal: 0,
          vertical: (orientation == Orientation.landscape)
              ? VisualDensity.minimumDensity
              : 0),
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: finalSize(
                      orientation,
                      MediaQuery.of(context).size.height * 0.018,
                      MediaQuery.of(context).size.height * 0.035),
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
}
