import 'package:flutter/material.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';

class LoginZenithMonitor extends StatelessWidget {
  LoginZenithMonitor({Key? key});

  Widget loginContainersName(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.5),
      child: Container(
        width: 167,
        height: 62,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black,
        ),
              child: Padding(
          padding: const EdgeInsets.all(18),
          child: Text(texto,
          textAlign: TextAlign.left,
          style: TextStyle(color: gray, fontSize: 18, fontFamily: 'DMSans'),
          ),
        ),
      ),
      
    );
  }

  Widget loginContainersGeneral(String texto) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 339,
        height: 62,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Text(texto,
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

  Widget buildMainBody() {
    return Center(
      child: Container(
        width: 395,
        height: 434,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),gradient: LinearGradient(begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.5,1],
        colors: [raisingBlack,Colors.black]),
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
    );
  }
}
