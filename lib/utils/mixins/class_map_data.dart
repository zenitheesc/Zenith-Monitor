import 'package:google_maps_flutter/google_maps_flutter.dart';

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
