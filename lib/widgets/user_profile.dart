import 'package:flutter/material.dart';
import 'package:zenith_monitor/utils/helpers/name_abbreviation.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/utils/ui/animations/zenith_progress_indicator.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key, required this.user});

  final LocalUser user;

  Future<Widget> profileChild() async {
    double radius = 80.0;
    Color color = eerieBlack;
    String? link = user.getImageLink();

    if (link == null) {
      return CircleAvatar(
        child: Text(
          user.getFirstName()[0].toUpperCase(),
          style: const TextStyle(
            fontSize: 60.0,
            color: white,
          ),
        ),
        backgroundColor: color,
        radius: radius,
      );
    }

    return CircleAvatar(
      backgroundImage: NetworkImage(
        link,
      ),
      backgroundColor: color,
      radius: radius,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80.0, 0, 20.0),
              child: FutureBuilder(
                future: profileChild(),
                builder: (context, AsyncSnapshot<Widget> snapshot) {
                  if (!snapshot.hasData) {
                    return const ZenithProgressIndicator(
                      size: 160.0,
                      fileName: "z_icon_white.png",
                    );
                  }
                  return snapshot.data!;
                },
              ),
            ),
            Text(
              nameAbbreviation(user.getCompleteName(), screenWidth, 24.0),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: white,
                fontFamily: 'DMSans',
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
              decoration: const BoxDecoration(
                color: gray,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Text(
                user.getAccessLevel(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: white,
                  fontFamily: 'DMSans',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
