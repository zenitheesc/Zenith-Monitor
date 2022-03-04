import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/map/map.dart';

double setSizeForOrientation(
    BuildContext context, Orientation orientation, double size) {
  if (orientation == Orientation.portrait) {
    return screenSize(context, "width", size);
  }
  return screenSize(context, "height", size);
}

Widget insertText(
    BuildContext context, Orientation orientation, String text, String input) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        text,
        style: TextStyle(
            color: white,
            fontSize: setSizeForOrientation(context, orientation, 0.04),
            fontFamily: 'DMSans'),
      ),
      Text(input,
          style: TextStyle(
              color: white,
              fontSize: setSizeForOrientation(context, orientation, 0.03),
              fontFamily: 'DMSans')),
    ],
  );
}

Container mapButton(BuildContext context) {
  return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.width * 0.1,
          bottom: MediaQuery.of(context).size.width * 0.1,
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1),
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0,
      decoration: const BoxDecoration(
        color: Colors.white,
      ));
}

Row informations(BuildContext context, Orientation orientation, String text1,
    String text2, String input1, String input2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      informationsContainer(context, orientation, text1, input1),
      informationsContainer(context, orientation, text2, input2)
    ],
  );
}

Widget informationsContainer(
    BuildContext context, Orientation orientation, String text, String input) {
  return Container(
    decoration: BoxDecoration(
      color: eerieBlack,
      borderRadius: BorderRadius.circular(10),
    ),
    width: screenSize(context, "width", 0.44),
    height: screenSize(context, "height", 0.1),
    child: Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Image(image: AssetImage('assets/images/award.png')),
        insertText(context, orientation, text, input),
      ],
    )),
  );
}

Widget smallContainer(BuildContext context, String text, int textColor) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: white,
              fontSize: screenSize(context, "width", 0.048),
              fontFamily: 'DMSans'),
        ),
        onPressed: () {
          print(text + ' Pressed!');
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        screenSize(context, "height", 0.03125)),
                    side: BorderSide(color: Color(textColor)))),
            fixedSize: MaterialStateProperty.all(Size(
              screenSize(context, "width", 0.4),
              screenSize(context, "height", 0.05847),
            )),
            backgroundColor: MaterialStateProperty.all<Color>(
              Color(textColor),
            )),
      ),
    ),
  );
}
