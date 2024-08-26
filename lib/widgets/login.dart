import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/login/bloc/login_bloc.dart';
import 'package:rive/rive.dart' as rive;
import 'package:zenith_monitor/utils/ui/animations/zenith_progress_indicator.dart';
import 'package:zenith_monitor/widgets/status_message.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget();

  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {
  // final ButtonStyle style =
  //     ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  // late rive.RiveAnimationController _googleLoginController;

  void _toggleAnimation(rive.RiveAnimationController controller) {
    if (controller.isActive == false) {
      controller.isActive = true;
    }
  }

  @override
  void initState() {
    super.initState();
    // _googleLoginController = rive.OneShotAnimation(
    //   'changeColors',
    //   autoplay: false,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.popAndPushNamed(context, '/home');
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const ZenithProgressIndicator(
                size: 100,
                fileName: "z_icon_white.png",
              );
            }
            if (state is LoginError) {
              return mainCenter(state.errorMessage);
            }
            return mainCenter(null);
          },
        ),
        backgroundColor: raisingBlackDarker,
      ),
    );
  }

  Widget mainCenter(String? errorMsg) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Container(
          decoration: const BoxDecoration(
            color: eerieBlack,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height *
              ((MediaQuery.of(context).orientation == Orientation.portrait)
                  ? 0.80
                  : 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                width: 340,
                height: 80,
                child: const rive.RiveAnimation.asset(
                    "assets/animations/zenithlogo.riv"),
              ),
              StatusMessage(message: errorMsg, color: lightCoral),
              loginWithGoogleButton(),
            ],
          ),
        ),
      ),
    );
  }

  Center loginWithGoogleButton() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            // style: const TextStyle(fontSize: 20)),
            onPressed: () {
              // _toggleAnimation(_googleLoginController);
              BlocProvider.of<LoginBloc>(context).add(GoogleLoginEvent());
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/devicon_google.png', height: 20),
                const SizedBox(width: 10),
                const Text('Entrar com o Google'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
