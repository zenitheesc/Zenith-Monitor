import 'package:flutter/material.dart';

import '../../../constants/colors_constants.dart';
import '../map.dart';

double getSizeForOrientation(
    BuildContext context, Orientation orientation, double size) {
  if (orientation == Orientation.landscape) {
    return screenSize(context, "width", size);
  }
  return screenSize(context, "height", size);
}

Widget mapThemeButton(
    BuildContext context, Orientation orientation, BuildMap buildMap) {
  return Center(
    child: Container(
        height: getSizeForOrientation(context, orientation, 0.08),
        child: SizedBox.fromSize(
          size: Size(
              getSizeForOrientation(context, orientation, 0.068),
              getSizeForOrientation(
                  context, orientation, 0.068)), // button width and height
          child: ClipPath(
            child: Material(
              color: eerieBlack, // button color
              child: InkWell(
                onTap: () {
                  buildMap.setMap();
                },
                // button pressed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Tema",
                      style: TextStyle(
                        fontSize:
                            getSizeForOrientation(context, orientation, 0.015),
                        color: white,
                      ),
                    ), // icon
                    Icon(
                      Icons.palette,
                      size: getSizeForOrientation(context, orientation, 0.035),
                      color: white,
                    ), // text
                  ],
                ),
              ),
            ),
          ),
        )),
  );
}
