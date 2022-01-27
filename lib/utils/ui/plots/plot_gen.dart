import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

class DataPoints {
  final int x;
  final int y;
  DataPoints(this.x, this.y);
}

List<charts.Series<DataPoints, int>> createSampleData() {
  var rand = Random();

  final List<DataPoints> data = [];

  for(int i=0; i<10; i++) {
    data.add(DataPoints(i, rand.nextInt(1000)));
  }

  return [
    charts.Series<DataPoints, int>(
      id: 'DataPlot',
      colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
      domainFn: (DataPoints _data, _) => _data.x,
      measureFn: (DataPoints _data, _) => _data.y,
      data: data,
    )
  ];
}

class PlotGenerator extends StatelessWidget {
  final List<charts.Series<DataPoints, int>> seriesList;
  final bool animate;

  const PlotGenerator({required this.seriesList, required this.animate});

  // factory PlotGenerator.withSampleData() {
  //   return PlotGenerator(createSampleData(), animate: false);
  // }

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(seriesList, animate: animate);
  }
}
