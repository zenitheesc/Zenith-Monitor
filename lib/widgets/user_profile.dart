import 'package:flutter/material.dart';
import 'package:zenith_monitor/utils/mixins/class_user.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class UserProfile extends StatelessWidget {
  UserProfile({Key? key, required this.user});

  final User user;

  Widget profileChild() {
    double radius = 80.0;
    Color color = eerieBlack;

    if (user.imageLink == null) {
      return CircleAvatar(
        child: Text(
          user.name[0].toUpperCase(),
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
        user.imageLink!,
      ),
      backgroundColor: color,
      radius: radius,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 80.0, 0, 20.0),
              child: profileChild(),
            ),
            Text(
              user.name,
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
                user.accessLevel,
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