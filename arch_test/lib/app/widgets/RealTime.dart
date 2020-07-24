import 'package:arch_test/app/models/StandartPacket.dart';
import 'package:flutter/material.dart';

class RealTimeView extends StatefulWidget {
  final Stream<StdPacket> input;
  RealTimeView({Key key, this.input}) : super(key: key);

  @override
  _RealTimeViewState createState() => _RealTimeViewState();
}

class _RealTimeViewState extends State<RealTimeView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: widget.input,
          builder: (context, AsyncSnapshot<StdPacket> snapshot) {
            return Text(
              snapshot.data.x.toString(),
              style: TextStyle(color: Colors.red),
            );
          }),
    );
  }
}
