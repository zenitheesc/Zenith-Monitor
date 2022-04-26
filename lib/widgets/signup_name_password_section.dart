import 'package:flutter/material.dart';
import 'package:zenith_monitor/widgets/text_field_container.dart';

class NamePasswordSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final Orientation deviceOrientation;
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController pwdConfirmController;

  const NamePasswordSection(
      {required this.screenWidth,
      required this.screenHeight,
      required this.deviceOrientation,
      required this.nameController,
      required this.surnameController,
      required this.emailController,
      required this.passwordController,
      required this.pwdConfirmController});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFieldContainer(
            controller: nameController,
            labelText: 'Nome',
            fontSize: _fontSize(),
            width: _width(isName: true),
            height: _height(),
            margin: EdgeInsets.only(
                bottom: 0.007 * screenHeight, right: 0.02 * screenWidth)),
        TextFieldContainer(
            controller: surnameController,
            labelText: 'Sobrenome',
            fontSize: _fontSize(),
            width: _width(isName: true),
            height: _height(),
            margin: EdgeInsets.only(bottom: 0.007 * screenHeight)),
      ]),
      TextFieldContainer(
          controller: emailController,
          labelText: 'Email',
          fontSize: _fontSize(),
          width: _width(),
          height: _height(),
          margin: EdgeInsets.only(bottom: 0.007 * screenHeight)),
      TextFieldContainer(
          controller: passwordController,
          labelText: 'Senha',
          fontSize: _fontSize(),
          width: _width(),
          height: _height(),
          margin: EdgeInsets.only(bottom: 0.007 * screenHeight),
          obscureText: true),
      TextFieldContainer(
          controller: pwdConfirmController,
          labelText: 'Confirmar Senha',
          fontSize: _fontSize(),
          width: _width(),
          height: _height(),
          obscureText: true),
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
