import 'package:flutter/material.dart';
import 'scale_screen_size.dart';

Widget build_previous_text(String datatype, String previous_data, String unit) {
  if (datatype != "MISSION TIME") {
    return Expanded(
        flex: 2,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(
                "PREVIOUS:",
                style: TextStyle(
                  color: Colors.grey[350],
                  fontSize: (SizeConfig.blockSizeHorizontal) * 2.5,
                ),
              ),
              Text(
                (unit == "°")
                    ? previous_data + unit
                    : previous_data + " " + unit,
                style: TextStyle(
                  color: Colors.grey[350],
                  fontSize: (SizeConfig.blockSizeHorizontal) * 3,
                ),
              ),
            ],
          ),
        ));
  } else {
    return SizedBox.shrink();
  }
}

Widget build_side_bar(
    BuildContext context, int index, List<String> side_bar_list) {
  return new Padding(
      padding: EdgeInsets.only(
        left: 15,
        top: 10,
        bottom: 10,
      ),
      child: Text(
        side_bar_list[index],
        style: TextStyle(
          color: Colors.black,
          fontSize: (SizeConfig.blockSizeHorizontal) * 5,
          fontWeight: FontWeight.bold,
        ),
      ));
}
