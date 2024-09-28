import 'package:flutter/material.dart';
import 'package:zenith_monitor/widgets/login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginWidget();
    // final ButtonStyle style =
    //     ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    // return Center(
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: <Widget>[
    //       ElevatedButton(
    //         style: style,
    //         onPressed: () {},
    //         child: Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Image.asset('assets/images/devicon_google.png', height: 20),
    //             const SizedBox(width: 10),
    //             const Text('Entrar com o Google'),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
