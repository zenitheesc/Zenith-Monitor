import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:zenith_monitor/utils/mixins/class_map_data.dart';

Future<MapData?> routesRequest(LatLng start, LatLng end) async {
  String? routesApiKey = dotenv.env['ROUTES_API'];
  if (routesApiKey == null) return null;

  String startCoordinate =
      start.longitude.toString() + "," + start.latitude.toString();
  String endCoordinate =
      end.longitude.toString() + "," + end.latitude.toString();
  var url = Uri.parse(
      'https://api.openrouteservice.org/v2/directions/driving-car?api_key=' +
          routesApiKey +
          '&start=' +
          startCoordinate +
          '&end=' +
          endCoordinate);

  var response = await http.get(url);
  if (response.statusCode != 200) return null;

  final jsonBody = json.decode(response.body);

  //coordinates
  List<dynamic> l = jsonBody["features"][0]["geometry"]["coordinates"];
  List<LatLng> coordinates = [];
  for (List<dynamic> coordinate in l) {
    coordinates.add(LatLng(coordinate[1], coordinate[0]));
  }

  //
  return MapData(routePoints: coordinates, probeLocation: end);
}
