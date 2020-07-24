import 'package:arch_test/app/models/StandartPacket.dart';
import 'package:flutter/material.dart';

class TerminalView extends StatefulWidget {
  final Stream<StdPacket> input;

  TerminalView({Key key, this.input}) : super(key: key);

  @override
  _TerminalViewState createState() => _TerminalViewState();
}

class _TerminalViewState extends State<TerminalView> {
  List<StdPacket> accumulator = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: widget.input,
          builder: (context, AsyncSnapshot<StdPacket> snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done)
              accumulator.add(snapshot.data);
            return ListView.builder(
                itemCount: accumulator.length,
                itemBuilder: (context, int index) {
                  return ListTile(
                    title: Text(accumulator[index].x.toString()),
                  );
                });
          }),
    );
  }
}
