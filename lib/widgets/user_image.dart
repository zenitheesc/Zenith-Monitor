import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';

class UserImage extends StatelessWidget {
  final LocalUser? user;
  final double radius;
  const UserImage({required this.user, required this.radius});

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return CircleAvatar(
        backgroundColor: eerieBlack,
        radius: radius,
        child: Icon(
          Icons.person,
          color: white,
          size: radius,
        ),
      );
    }

    String? link = user!.getImageLink();
    if (link == null) {
      return CircleAvatar(
        child: Text(
          user!.getFirstName()[0].toUpperCase(),
          style: TextStyle(
            fontSize: radius,
            color: white,
          ),
        ),
        backgroundColor: eerieBlack,
        radius: radius,
      );
    }

    return CircleAvatar(
      backgroundImage: NetworkImage(
        link,
      ),
      backgroundColor: eerieBlack,
      radius: radius,
    );
  }
}
