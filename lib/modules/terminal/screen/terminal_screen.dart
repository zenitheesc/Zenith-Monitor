import 'package:flutter/cupertino.dart';
import 'package:zenith_monitor/widgets/scroll_glow_remove.dart';
import 'package:zenith_monitor/widgets/terminal.dart';

class TerminalScreen extends StatelessWidget {
  const TerminalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(behavior: ScrollGlowRemove(), child: Terminal());
  }
}
