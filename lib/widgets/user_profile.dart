import 'package:flutter/material.dart';
import 'package:zenith_monitor/utils/helpers/name_abbreviation.dart';
import 'package:zenith_monitor/utils/mixins/class_user.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key, required this.user});

  final User user;

  Future<Widget> profileChild() async {
    double radius = 80.0;
    Color color = eerieBlack;
    String? link = await user.getImageLink();

    if (link == null) {
      return CircleAvatar(
        child: Text(
          user.getName()[0].toUpperCase(),
          style: TextStyle(
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
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return snapshot.data!;
                },
              ),
            ),
            Text(
              nameAbbreviation(user.getName(), screenWidth, 24.0),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: white,
                fontFamily: 'DMSans',
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 10),
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
