import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class LoginZenithMonitor extends StatelessWidget {
  LoginZenithMonitor({Key? key});

  Widget loginContainersName(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.5,vertical: 2.5),
      child: Container(
        width: 167,
        height: 62,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Text(
            texto,
            textAlign: TextAlign.left,
            style: TextStyle(color: gray, fontSize: 18, fontFamily: 'DMSans'),
          ),
        ),
      ),
    );
  }

  Widget loginContainersGeneral(String texto) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: Container(
        width: 339,
        height: 62,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Text(
            texto,
            textAlign: TextAlign.left,
            style: TextStyle(color: gray, fontSize: 18, fontFamily: 'DMSans'),
          ),
        ),
      ),
    );
  }

  // Widget fundoContainers() {
  //   return Container(
  //     width: 395,
  //     height: 434,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(59),
  //       color: Colors.black,
  //     ),
  //     child: Text("ok",),
  //   );
  // }
  // AppBar appBarlogin(){
  //   return AppBar();
  // }

  // Body bodyLogin(){
  //   return  ;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: appBarLogin(),
        body: buildMainBody(),
        backgroundColor: eerieBlack);
  }

  Widget smallContainer(String text, int textColor) {
    return Center(
      child: Container(
        width: 173,
        height: 39,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
            color: Color(textColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(color: white, fontSize: 18, fontFamily: 'DMSans'),
      ),
        ),
    ),);
  }

  Widget buildMainBody() {
    return GridTile(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Container(
              width: 395,
              height: 434,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.5, 1],
                    colors: [raisingBlack, Colors.black]),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        loginContainersName('Nome'),
                        loginContainersName('Sobrenome')
                      ],
                    ),
                    loginContainersGeneral('Email'),
                    loginContainersGeneral('Senha'),
                    loginContainersGeneral('Confirmar senha')
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [smallContainer('Voltar',0XFFE57373),smallContainer('Submeter',0XFF8BC34A)],
          )
        ],
      ),
    );
  }
}
