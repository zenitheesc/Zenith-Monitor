import 'package:flutter/material.dart';

class ZenithProgressIndicator extends StatefulWidget {
  const ZenithProgressIndicator(
      {Key? key, required this.size, required this.fileName});

  final double size;
  final String fileName;

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<ZenithProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> loaderMenu;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    loaderMenu = Tween(begin: 2.0, end: 0.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      child: RotationTransition(
        turns: loaderMenu,
        child: Image.asset('assets/images/' + widget.fileName),
      ),
    );
  }
}
