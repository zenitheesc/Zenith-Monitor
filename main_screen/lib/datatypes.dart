import 'package:flutter/material.dart';
import 'speedometer_icons.dart';

class DataType {
  String name;
  String numeric_data;
  String unit;
  String previous_data;
  IconData icon;

  DataType(
      {this.name, this.numeric_data, this.unit, this.previous_data, this.icon});
}

var Altitude = DataType(
  name: "Altitude",
  numeric_data: "1884.48",
  unit: "KM",
  previous_data: null,
  icon: Icons.terrain,
);

var Velocidade = DataType(
  name: "Velocidade",
  numeric_data: "447.58",
  unit: "KM/H",
  previous_data: null,
  icon: Speedometer.speedometer,
);

var Latitude = DataType(
  name: "Latitude",
  numeric_data: "- 64.23",
  unit: "°",
  previous_data: null,
  icon: Icons.gps_fixed,
);

var Longitude = DataType(
  name: "Longitude",
  numeric_data: "47.69",
  unit: "°",
  previous_data: null,
  icon: Icons.gps_fixed,
);

var MissionTime = DataType(
  name: "MISSION TIME",
  numeric_data: "01:25:43",
  unit: "H",
  previous_data: null,
  icon: null,
);

var Temperatura = DataType(
  name: "TEMPERATURA",
  numeric_data: "95.69",
  unit: "°C",
  previous_data: "74.41",
  icon: null,
);

var Radiacao = DataType(
  name: "RADIAÇÃO",
  numeric_data: "748",
  unit: "R",
  previous_data: "549",
  icon: null,
);

var Other1 = DataType(
  name: "SOME OTHER DATA",
  numeric_data: "47.69",
  unit: "N",
  previous_data: "58.74",
  icon: null,
);

var Other2 = DataType(
  name: "SOME OTHER DATA",
  numeric_data: "547.69",
  unit: "°",
  previous_data: "596.58",
  icon: null,
);

// -----------------------------------------------------------------------------
class User {
  String name;
  String access_level;
  String image;

  User({this.name, this.access_level, this.image});
}

var user = User(
  name: "Leonardo Baptistella",
  access_level: "Zenith User",
  image: null,
);
