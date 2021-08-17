import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StandardAppBar({Key? key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 80,
        backgroundColor: raisingBlack,
        elevation: 0.0,
        title: Text(title, style: const TextStyle(color: white, fontSize: 20)),
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_new_rounded)));
  }
}
