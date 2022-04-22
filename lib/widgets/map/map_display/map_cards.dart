import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class MapInformationsContainer extends StatelessWidget {
  const MapInformationsContainer(
      {Key? key, required this.variableName, required this.variableValue});
  final String variableName;
  final String variableValue;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context, orientation) => Container(
              decoration: BoxDecoration(
                color: eerieBlack,
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width * 0.44,
              height: 80,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      variableName,
                      style: const TextStyle(
                          color: white, fontSize: 20, fontFamily: 'DMSans'),
                    ),
                    Text(
                      variableValue,
                      style: const TextStyle(
                          color: white, fontSize: 15, fontFamily: 'DMSans'),
                    ),
                  ],
                ),
              ),
            ));
  }
}
