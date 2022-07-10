import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/login/bloc/login_bloc.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/widgets/user_image.dart';
import 'package:zenith_monitor/utils/helpers/name_abbreviation.dart';

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
    final LocalUser? user = context.select((LoginBloc bloc) => bloc.state.user);
    const Map<String, String> map = {
      'Terminal': '/terminal',
      'Configurações': '/configuration',
      'Estatísticas': '/configuration',
      'Missões': '/configuration',
      'Sobre nós': '/configuration'
    };
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
                          buildHeader(context, orientation, user,
                              onClicked: () {}),
                          SizedBox(
                              height: finalSize(
                                  orientation,
                                  MediaQuery.of(context).size.height * 0.005,
                                  MediaQuery.of(context).size.width * 0.005)),
                          for (final page in map.entries)
                            buildMenuItem(context, orientation, text: page.key,
                                onClicked: () {
                              Navigator.popAndPushNamed(context, page.value);
                            }),
                          SizedBox(
                              height: finalSize(
                                  orientation,
                                  MediaQuery.of(context).size.height * 0.35,
                                  MediaQuery.of(context).size.height * 0.01)),
                          buildMenuItem(
                            context,
                            orientation,
                            text: 'Sair',
                            onClicked: () {
                              BlocProvider.of<LoginBloc>(context)
                                  .add(SignOutEvent(context: context));
                            },
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
    Orientation orientation,
    LocalUser? user, {
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
            UserImage(
              user: user,
              radius: finalSize(
                  orientation,
                  MediaQuery.of(context).size.height * 0.04,
                  MediaQuery.of(context).size.width * 0.035),
            ),
            SizedBox(
                height: finalSize(
                    orientation,
                    MediaQuery.of(context).size.height * 0.002,
                    MediaQuery.of(context).size.width * 0.002)),
            Text(
              nameAbbreviation(
                  user!.getCompleteName(),
                  finalSize(
                      orientation,
                      MediaQuery.of(context).size.width * 0.5,
                      MediaQuery.of(context).size.width * 0.3),
                  finalSize(
                      orientation,
                      MediaQuery.of(context).size.height * 0.022,
                      MediaQuery.of(context).size.width * 0.022)),
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
              user.getAccessLevel(),
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
