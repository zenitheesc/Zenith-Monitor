import 'package:google_maps_flutter/google_maps_flutter.dart';

/// The idea for this class is to encapsuate all the
/// information related to map and the tracker navigation,
/// such as gps instructions, distance between the tracker
/// and the probe, how long the rescue will take, and so on

class MapData {
  final List<LatLng> routePoints;
  LatLng probeLocation;
  /*final double distance;
	  final double duration;*/

  MapData(
      {required this.routePoints,
      required this.probeLocation /*,
							      required this.distance,
							      required this.duration*/
      });
}
