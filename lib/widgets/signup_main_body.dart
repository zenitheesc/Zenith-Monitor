import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class SignUpMainBody extends StatelessWidget {
  final BuildContext _rootContext;

  const SignUpMainBody({required BuildContext rootContext})
      : _rootContext = rootContext;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ProfileImageSection(rootContext: _rootContext),
            NamePasswordSection(rootContext: _rootContext),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ButtonContainer(
                  rootContext: _rootContext,
                  text: 'Voltar',
                  buttonColor: 0XFFE57373),
              ButtonContainer(
                  rootContext: _rootContext,
                  text: 'Submeter',
                  buttonColor: 0XFF8BC34A)
            ])
          ],
        ),
      ),
    );
  }
}

class ProfileImageSection extends StatelessWidget {
  double _screenWidth;
  double _screenHeight;
  double _imageContainerSize;
  double _iconButtonContainerSize;

  ProfileImageSection({required BuildContext rootContext})
      : _screenWidth = MediaQuery.of(rootContext).size.width,
        _screenHeight = MediaQuery.of(rootContext).size.height,
        _imageContainerSize = 0.2 * MediaQuery.of(rootContext).size.height,
        _iconButtonContainerSize =
            0.07 * MediaQuery.of(rootContext).size.height;

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
              right: 0.8 * _screenWidth - _imageContainerSize,
              bottom: 0.07 * _screenHeight),
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

class TextFieldContainer extends StatelessWidget {
  final BuildContext _rootContext;
  final String _labelText;
  final bool _isObscure;
  double _containerWidth;
  double _containerHeight;
  double _fontSize;
  double _bottomMargin;

  TextFieldContainer(
      {required BuildContext rootContext,
      required String labelText,
      bool isObscure = false})
      : _rootContext = rootContext,
        _labelText = labelText,
        _isObscure = isObscure,
        _containerWidth = (labelText == 'Nome' || labelText == 'Sobrenome')
            ? 0.39 * MediaQuery.of(rootContext).size.width
            : 0.80 * MediaQuery.of(rootContext).size.width,
        _containerHeight = 0.08 * MediaQuery.of(rootContext).size.height,
        _fontSize =
            (MediaQuery.of(rootContext).orientation == Orientation.portrait)
                ? 0.024 * MediaQuery.of(rootContext).size.height
                : 0.024 * MediaQuery.of(rootContext).size.width,
        _bottomMargin = 0.007 * MediaQuery.of(rootContext).size.height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _containerWidth,
      height: _containerHeight,
      margin: EdgeInsets.only(bottom: _bottomMargin),
      child: TextField(
        style: TextStyle(
            color: white, fontWeight: FontWeight.normal, fontFamily: 'DMSans'),
        decoration: InputDecoration(
            labelText: "  " + _labelText,
            labelStyle: TextStyle(
                color: white, fontSize: _fontSize, fontFamily: 'DMSans'),
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(
                    MediaQuery.of(_rootContext).size.height * 0.015)))),
        obscureText: _isObscure,
      ),
    );
  }
}

class NamePasswordSection extends StatelessWidget {
  final BuildContext _rootContext;

  const NamePasswordSection({required BuildContext rootContext})
      : _rootContext = rootContext;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFieldContainer(rootContext: _rootContext, labelText: 'Nome'),
        VerticalDivider(width: MediaQuery.of(_rootContext).size.width * 0.02),
        TextFieldContainer(rootContext: _rootContext, labelText: 'Sobrenome')
      ]),
      TextFieldContainer(rootContext: _rootContext, labelText: 'Email'),
      TextFieldContainer(
          rootContext: _rootContext, labelText: 'Senha', isObscure: true),
      TextFieldContainer(
          rootContext: _rootContext,
          labelText: 'Confirmar Senha',
          isObscure: true),
    ]);
  }
}

class ButtonContainer extends StatelessWidget {
  final String _text;
  final int _buttonColor;
  double _screenWidth;
  double _screenHeight;
  double _leftMargin;
  double _rightMargin;
  double _topMargin;
  double _fontSize;

  ButtonContainer(
      {required BuildContext rootContext,
      required String text,
      required int buttonColor})
      : _text = text,
        _buttonColor = buttonColor,
        _screenWidth = MediaQuery.of(rootContext).size.width,
        _screenHeight = MediaQuery.of(rootContext).size.height,
        _leftMargin = 0.01 * MediaQuery.of(rootContext).size.width,
        _rightMargin = 0.01 * MediaQuery.of(rootContext).size.width,
        _topMargin = 0.16 * MediaQuery.of(rootContext).size.height,
        _fontSize =
            (MediaQuery.of(rootContext).orientation == Orientation.portrait)
                ? 0.025 * MediaQuery.of(rootContext).size.height
                : 0.0195 * MediaQuery.of(rootContext).size.width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.39 * _screenWidth,
      height: 0.05 * _screenHeight,
      margin: EdgeInsets.only(
          left: _leftMargin, top: _topMargin, right: _rightMargin),
      child: ElevatedButton(
        child: Center(
            child: Text(
          _text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: white, fontSize: _fontSize, fontFamily: 'DMSans'),
        )),
        onPressed: () {},
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.03 * _screenHeight),
                    side: BorderSide(color: Color(_buttonColor)))),
            fixedSize: MaterialStateProperty.all(
                Size(0.039 * _screenWidth, 0.05 * _screenHeight)),
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(_buttonColor))),
      ),
    );
  }
}
