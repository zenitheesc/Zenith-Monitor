import 'package:firstattemptatmaps/bloc/data_bloc/data_bloc.dart';
import 'package:firstattemptatmaps/bloc/location_bloc/location_bloc.dart';
import 'package:firstattemptatmaps/bloc/map_bloc/map_bloc.dart';
import 'package:firstattemptatmaps/components/data.dart';
import 'package:firstattemptatmaps/components/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // only used here for the LatLng class
import 'package:firstattemptatmaps/widgets/gmap.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      debugShowCheckedModeBanner: false,
      home: MapSample(),
      showPerformanceOverlay: true,
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DataBloc(DataManager()),
        ),
        BlocProvider(
          create: (context) => LocationBloc(LocationManager()),
        ),
        BlocProvider(
          create: (context) => MapBloc(
            BlocProvider.of<LocationBloc>(context),
            BlocProvider.of<DataBloc>(context),
          ),
        ),
      ],
      child: BodyView(),
    );
  }
}

class BodyView extends StatelessWidget {
  const BodyView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GMapsConsumer(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            child: Icon(Icons.map),
            onPressed: () => BlocProvider.of<MapBloc>(context)
                .add(MapTypeChange(MapType.satellite)),
          ),
          FloatingActionButton(
            child: Icon(Icons.traffic),
            onPressed: () =>
                BlocProvider.of<MapBloc>(context).add(MapTrafficChange(false)),
          )
        ],
      ),
    );
  }
}
