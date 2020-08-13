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

DataType altitude = DataType(
  name: "Altitude",
  numericData: "1884.48",
  unit: "KM",
  previousData: null,
  icon: Icons.terrain,
);

DataType velocidade = DataType(
  name: "Velocidade",
  numericData: "447.58",
  unit: "KM/H",
  previousData: null,
  icon: Speedometer.speedometer,
);

DataType latitude = DataType(
  name: "Latitude",
  numericData: "- 64.23",
  unit: "°",
  previousData: null,
  icon: Icons.gps_fixed,
);

DataType longitude = DataType(
  name: "Longitude",
  numericData: "47.69",
  unit: "°",
  previousData: null,
  icon: Icons.gps_fixed,
);

DataType missionTime = DataType(
  name: "MISSION TIME",
  numericData: "01:25:43",
  unit: "H",
  previousData: null,
  icon: null,
);

DataType temperatura = DataType(
  name: "TEMPERATURA",
  numericData: "95.69",
  unit: "°C",
  previousData: "74.41",
  icon: null,
);

DataType radiacao = DataType(
  name: "RADIAÇÃO",
  numericData: "748",
  unit: "R",
  previousData: "549",
  icon: null,
);

DataType other1 = DataType(
  name: "SOME OTHER DATA",
  numericData: "47.69",
  unit: "N",
  previousData: "58.74",
  icon: null,
);

DataType other2 = DataType(
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
