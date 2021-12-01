import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/modules/terminal/bloc/terminal_bloc.dart';
import 'package:zenith_monitor/widgets/terminal.dart';

class TerminalScreen extends StatelessWidget {
  const TerminalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => TerminalBloc(), child: Terminal());
  }
}
