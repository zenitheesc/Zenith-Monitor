import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zenith_monitor/utils/services/firestore_services/firestore_services.dart';
import 'package:zenith_monitor/widgets/not_found_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zenith_monitor/core/pipelines/map_data_pipeline/map_data_bloc.dart';
import 'package:zenith_monitor/modules/configuration/screen/configuration_screen.dart';
import 'package:zenith_monitor/modules/terminal/bloc/terminal_bloc.dart';
import 'package:zenith_monitor/modules/terminal/screen/terminal_screen.dart';
import 'package:zenith_monitor/utils/services/usb/usb.dart';
import 'package:zenith_monitor/core/pipelines/data_pipeline/data_bloc.dart';
import 'package:zenith_monitor/modules/forget_password/screen/forgot_my_password_screen.dart';
import 'package:zenith_monitor/modules/login/bloc/login_bloc.dart';
import 'package:zenith_monitor/modules/map/screen/map_screen.dart';
import 'package:zenith_monitor/modules/signup/screen/sign_up_screen.dart';
import 'package:zenith_monitor/utils/ui/animations/zenith_progress_indicator.dart';
import 'package:zenith_monitor/modules/login/screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(const ZenithMonitor());
}

class ZenithMonitor extends StatelessWidget {
  const ZenithMonitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Application();
  }
}

class Application extends StatelessWidget {
  Application({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    UsbManager usbManager = UsbManager();
    FirestoreServices fireServices = FirestoreServices();
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(
              create: (context) =>
                  DataBloc(usbManager: usbManager, fireServices: fireServices)),
          BlocProvider(
              create: (context) => MapDataBloc(
                  usbManager: usbManager, fireServices: fireServices)),
          BlocProvider(
              create: (context) =>
                  TerminalBloc(dataBloc: BlocProvider.of<DataBloc>(context))),
        ],
        child: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Scaffold(backgroundColor: Colors.red);
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return MaterialApp(
                showPerformanceOverlay: false, // shows fps
                debugShowCheckedModeBanner: false,
                title: 'Main Screen',
                theme: ThemeData(
                  bottomSheetTheme: BottomSheetThemeData(
                      backgroundColor: Colors.black.withOpacity(0)),
                  primaryColor: Colors.black,
                ),
                initialRoute: '/login',
                routes: {
                  '/login': (context) => const LoginScreen(),
                  '/signup': (context) => const SignUpScreen(),
                  '/forgotPwd': (context) => const ForgotMyPassword(),
                  '/map': (context) => const MapScreen(),
                  '/configuration': (context) => ConfigurationScreen(),
                  '/terminal': (context) => const TerminalScreen(),
                  '/404': (context) => NotFoundScreen(),
                },
              );
            }
            return const ZenithProgressIndicator(
                size: 30, fileName: "z_icon_white.png");
          },
        ));
  }
}
