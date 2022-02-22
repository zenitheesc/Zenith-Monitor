import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/widgets/elevated_button_container.dart';
import 'package:zenith_monitor/widgets/text_field_container.dart';

class SignUpMainBody extends StatelessWidget {
  double screenWidth;
  double screenHeight;
  Orientation deviceOrientation;

  SignUpMainBody(
      {required this.screenWidth,
      required this.screenHeight,
      required this.deviceOrientation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ProfileImageSection(
                screenWidth: screenWidth, screenHeight: screenHeight),
            NamePasswordSection(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                deviceOrientation: deviceOrientation),
            ButtonsSection(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                deviceOrientation: deviceOrientation)
          ],
        ),
      ),
    );
  }
}

class ProfileImageSection extends StatelessWidget {
  double screenWidth;
  double screenHeight;
  double _imageContainerSize;
  double _iconButtonContainerSize;

  ProfileImageSection({required this.screenWidth, required this.screenHeight})
      : _imageContainerSize = 0.2 * screenHeight,
        _iconButtonContainerSize = 0.07 * screenHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: _imageContainerSize,
          width: _imageContainerSize,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.5 * _imageContainerSize),
              color: white),
          margin: EdgeInsets.only(
              right: 0.8 * screenWidth - _imageContainerSize,
              bottom: 0.07 * screenHeight),
          child: Center(
            child: Icon(
              Icons.person_outlined,
              size: 0.8 * _imageContainerSize,
            ),
          ),
        ),
        Positioned(
          top: 0.65 * _imageContainerSize,
          left: 0.75 * _imageContainerSize,
          child: Container(
            height: _iconButtonContainerSize,
            width: _iconButtonContainerSize,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(0.5 * _iconButtonContainerSize),
                color: white),
            child: IconButton(
              iconSize: 0.6 * _iconButtonContainerSize,
              padding: const EdgeInsets.all(0.0),
              splashRadius: 0.65 * _iconButtonContainerSize,
              onPressed: () {
                print('Icon button was pressed!');
              },
              icon: Icon(
                Icons.photo_library_outlined,
              ),
            ),
          ),
        )
      ],
      clipBehavior: Clip.none,
    );
  }
}

class NamePasswordSection extends StatelessWidget {
  double screenWidth;
  double screenHeight;
  Orientation deviceOrientation;

  NamePasswordSection(
      {required this.screenWidth,
      required this.screenHeight,
      required this.deviceOrientation});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFieldContainer(
            labelText: 'Nome',
            fontSize: _fontSize(),
            width: _width(isName: true),
            height: _height(),
            margin: EdgeInsets.only(
                bottom: 0.007 * screenHeight, right: 0.02 * screenWidth)),
        TextFieldContainer(
            labelText: 'Sobrenome',
            fontSize: _fontSize(),
            width: _width(isName: true),
            height: _height(),
            margin: EdgeInsets.only(bottom: 0.007 * screenHeight)),
      ]),
      TextFieldContainer(
          labelText: 'Email',
          fontSize: _fontSize(),
          width: _width(),
          height: _height(),
          margin: EdgeInsets.only(bottom: 0.007 * screenHeight)),
      TextFieldContainer(
          labelText: 'Senha',
          fontSize: _fontSize(),
          width: _width(),
          height: _height(),
          margin: EdgeInsets.only(bottom: 0.007 * screenHeight),
          isObscure: true),
      TextFieldContainer(
          labelText: 'Confirmar Senha',
          fontSize: _fontSize(),
          width: _width(),
          height: _height(),
          isObscure: true),
    ]);
  }

  double _fontSize() {
    return (deviceOrientation == Orientation.portrait)
        ? 0.024 * screenHeight
        : 0.024 * screenWidth;
  }

  double _width({bool isName = false}) {
    return (isName) ? 0.39 * screenWidth : 0.8 * screenWidth;
  }

  double _height() {
    return 0.08 * screenHeight;
  }
}

class ButtonsSection extends StatelessWidget {
  double screenWidth;
  double screenHeight;
  Orientation deviceOrientation;

  ButtonsSection(
      {required this.screenWidth,
      required this.screenHeight,
      required this.deviceOrientation});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButtonContainer(
          text: 'Voltar',
          textStyle: TextStyle(
              color: white, fontSize: _fontSize(), fontFamily: 'DMSans'),
          width: 0.39 * screenWidth,
          height: 0.05 * screenHeight,
          margin: _margin(),
          buttonStyle: _buttonStyle(lightCoral)),
      ElevatedButtonContainer(
          text: 'Submeter',
          textStyle: TextStyle(
              color: white, fontSize: _fontSize(), fontFamily: 'DMSans'),
          width: 0.39 * screenWidth,
          height: 0.05 * screenHeight,
          margin: _margin(),
          buttonStyle: _buttonStyle(mantisGreen))
    ]);
  }

  double _fontSize() {
    return (deviceOrientation == Orientation.portrait)
        ? 0.025 * screenHeight
        : 0.0195 * screenWidth;
  }

  EdgeInsets _margin() {
    return EdgeInsets.only(
        left: 0.01 * screenWidth,
        top: 0.16 * screenHeight,
        right: 0.01 * screenWidth);
  }

  ButtonStyle _buttonStyle(Color color) {
    return ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.03 * screenHeight),
                side: BorderSide(color: color))),
        fixedSize: MaterialStateProperty.all(
            Size(0.039 * screenWidth, 0.05 * screenHeight)),
        backgroundColor: MaterialStateProperty.all<Color>(color));
  }
}
