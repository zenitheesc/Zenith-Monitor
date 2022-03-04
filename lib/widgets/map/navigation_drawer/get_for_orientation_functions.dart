// ignore: file_names
import 'package:flutter/material.dart'
    show BuildContext, MediaQuery, Orientation, VisualDensity;
import '../map.dart';

double getAvatarSizeForOrientation(
    BuildContext context, Orientation orientation) {
  if (orientation == Orientation.landscape) {
    return screenSize(
        context, getTypeSizeForOrientation(context, orientation), 0.035);
  } else {
    return screenSize(
        context, getTypeSizeForOrientation(context, orientation), 0.04);
  }
}

double getIconSizeForOrientation(
    BuildContext context, Orientation orientation) {
  if (orientation == Orientation.landscape) {
    return screenSize(
        context, getTypeSizeForOrientation(context, orientation), 0.04);
  } else {
    return screenSize(
        context, getTypeSizeForOrientation(context, orientation), 0.045);
  }
}

double getSizeForOrientation(BuildContext context, Orientation orientation) {
  if (orientation == Orientation.landscape) {
    return 0.3 * MediaQuery.of(context).size.width;
  } else {
    return 0.5 * MediaQuery.of(context).size.width;
  }
}

String getTypeSizeForOrientation(
    BuildContext context, Orientation orientation) {
  if (orientation == Orientation.landscape) {
    return "width";
  } else {
    return "height";
  }
}

double getFontSizeForOrientation(
    BuildContext context, Orientation orientation) {
  if (orientation == Orientation.landscape) {
    return screenSize(context, "height", 0.035);
  } else {
    return screenSize(context, "height", 0.018);
  }
}

double getExitSpacingForOrientation(
    BuildContext context, Orientation orientation) {
  if (orientation == Orientation.landscape) {
    return screenSize(context, "height", 0.01);
  } else {
    return screenSize(context, "height", 0.35);
  }
}

double getVisualDensityForOrientation(Orientation orientation) {
  if (orientation == Orientation.landscape) {
    return VisualDensity.minimumDensity;
  } else {
    return 0;
  }
}
