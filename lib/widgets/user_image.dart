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
        radius: radius,
        child: const Icon(Icons.favorite),
      );
    }

    String? link = user!.getImageLink();
    if (link == null) {
      return CircleAvatar(
        child: Text(
          user!.getFirstName()[0].toUpperCase(),
          style: const TextStyle(
            fontSize: 60.0,
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
