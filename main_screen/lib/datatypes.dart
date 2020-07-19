import 'package:flutter/material.dart';
import 'speedometer_icons.dart';

class DataType {
  String name;
  String numericData;
  String unit;
  String previousData;
  IconData icon;

  DataType(
      {this.name, this.numericData, this.unit, this.previousData, this.icon});
}

DataType Altitude = DataType(
  name: "Altitude",
  numericData: "1884.48",
  unit: "KM",
  previousData: null,
  icon: Icons.terrain,
);

DataType Velocidade = DataType(
  name: "Velocidade",
  numericData: "447.58",
  unit: "KM/H",
  previousData: null,
  icon: Speedometer.speedometer,
);

DataType Latitude = DataType(
  name: "Latitude",
  numericData: "- 64.23",
  unit: "°",
  previousData: null,
  icon: Icons.gps_fixed,
);

DataType Longitude = DataType(
  name: "Longitude",
  numericData: "47.69",
  unit: "°",
  previousData: null,
  icon: Icons.gps_fixed,
);

DataType MissionTime = DataType(
  name: "MISSION TIME",
  numericData: "01:25:43",
  unit: "H",
  previousData: null,
  icon: null,
);

DataType Temperatura = DataType(
  name: "TEMPERATURA",
  numericData: "95.69",
  unit: "°C",
  previousData: "74.41",
  icon: null,
);

DataType Radiacao = DataType(
  name: "RADIAÇÃO",
  numericData: "748",
  unit: "R",
  previousData: "549",
  icon: null,
);

DataType Other1 = DataType(
  name: "SOME OTHER DATA",
  numericData: "47.69",
  unit: "N",
  previousData: "58.74",
  icon: null,
);

DataType Other2 = DataType(
  name: "SOME OTHER DATA",
  numericData: "547.69",
  unit: "°",
  previousData: "596.58",
  icon: null,
);

// -----------------------------------------------------------------------------

class User {
  String name;
  String accessLevel;
  String image;

  User({this.name, this.accessLevel, this.image});
}

User user = User(
  name: "Leonardo Baptistella",
  accessLevel: "Zenith User",
  image: null,
);
