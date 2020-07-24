import 'package:arch_test/app/blocs/status_bloc/status_bloc.dart';
import 'package:arch_test/app/blocs/data_bloc/data_bloc.dart';
import 'package:arch_test/app/models/StandartPacket.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<StdPacket> acc = [];
  int status = 0;
  @override
  void didChangeDependencies() {
    // BlocProvider.of<DataBloc>(context).add(BluetoothInit());
    BlocProvider.of<StatusBloc>(context).add(StatusStarted());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Titole"),
        actions: <Widget>[
          BlocBuilder<StatusBloc, StatusState>(
            builder: (context, state) {
              if (state is StatusTickSuccess)
                return Text(
                  "status: " + state.packet.toString(),
                  style: TextStyle(fontSize: 24),
                );
              if (state is StatusInitial) return Text("-1");
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Maps"),
            BlocBuilder<DataBloc, DataState>(
              builder: (context, state) {
                if (state is DataInitial) {
                  return Column(
                    children: <Widget>[
                      Text("No data yet"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            child: Text('Use Bluetooth'),
                            onPressed: () {
                              BlocProvider.of<DataBloc>(context)
                                  .add(BluetoothInit());
                            },
                          ),
                          RaisedButton(
                            child: Text('Use USB'),
                            onPressed: () {
                              BlocProvider.of<DataBloc>(context).add(UsbInit());
                            },
                          ),
                          RaisedButton(
                            child: Text('Use Cloud'),
                            onPressed: () {
                              BlocProvider.of<DataBloc>(context)
                                  .add(LoggerInit());
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                }
                if (state is DataReceived) {
                  acc.add(state.packet);
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          // PRETEND THIS IS THE REALTIME
                          child: Text(
                            "Current: " + state.packet.x.toString(),
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            RaisedButton(
                              child: Text('Bluetooth'),
                              onPressed: () {
                                BlocProvider.of<DataBloc>(context)
                                    .add(BluetoothInit());
                              },
                            ),
                            RaisedButton(
                              child: Text('USB'),
                              onPressed: () {
                                BlocProvider.of<DataBloc>(context)
                                    .add(UsbInit());
                              },
                            ),
                            RaisedButton(
                              child: Text('Cloud'),
                              onPressed: () {
                                BlocProvider.of<DataBloc>(context)
                                    .add(LoggerInit());
                              },
                            ),
                            RaisedButton(
                              color: Colors.redAccent,
                              child: Text(
                                'Stop',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                BlocProvider.of<DataBloc>(context)
                                    .add(DataStop());
                              },
                            ),
                          ],
                        ),
                        ListView.builder(
                            //PRETEND THIS IS THE MAP
                            itemCount: acc.length,
                            shrinkWrap: true,
                            itemBuilder: (context, int index) {
                              return ListTile(
                                dense: true,
                                title: Text("Packet ($index): " +
                                    acc[index].x.toString()),
                              );
                            }),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
