import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/modules/terminal/bloc/terminal_bloc.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';

class Terminal extends StatelessWidget {
  final textController = TextEditingController();
  final _scrollController = ScrollController();

  _scrollToEnd() async {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 100.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
    }
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          shrinkWrap: true,
          slivers: [
            const SliverAppBar(
              pinned: false,
              snap: false,
              floating: false,
              backgroundColor: raisingBlack,
              expandedHeight: 80.0,
              title: StandardAppBar(title: "Terminal"),
            ),
            BlocBuilder<TerminalBloc, TerminalState>(builder: (context, state) {
              List<Widget> terminalList = [];
              if (state is TerminalRow) {
                terminalList.addAll(
                    context.select((TerminalBloc bloc) => bloc.terminalList));
                terminalList.add(terminalRow(
                    terminalList.length, state.message, state.color));

                context.select(
                    (TerminalBloc bloc) => bloc.terminalList = terminalList);
                _scrollToEnd();
              } else if (state is CleanTerminalList) {
                terminalList.clear();
              } else if (state is CmdHistory) {
                terminalList.addAll(
                    context.select((TerminalBloc bloc) => bloc.terminalList));
                for (String command in state.cmdHistory) {
                  terminalList.add(terminalRow(
                      terminalList.length, command, Colors.orangeAccent));
                }

                context.select(
                    (TerminalBloc bloc) => bloc.terminalList = terminalList);
                _scrollToEnd();
              }
              return SliverList(
                  delegate: SliverChildListDelegate(terminalList));
            }),
            SliverToBoxAdapter(
              child: Container(
                height: 50,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: terminalTextField(context),
      backgroundColor: raisingBlack,
    );
  }

  Wrap terminalRow(int index, String text, Color color) {
    return Wrap(
      spacing: 20,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 0, 15),
          child: Text("$index", style: const TextStyle(color: gray)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 5, 15),
          child: Text(
            text,
            style: TextStyle(color: color),
          ),
        )
      ],
    );
  }

  Widget terminalTextField(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(28, 0, 28, 10),
        child: TextField(
          controller: textController,
          cursorColor: white,
          style: const TextStyle(color: white),
          minLines: 1,
          maxLines: 3,
          decoration: InputDecoration(
            fillColor: gray,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide.none,
            ),
            prefixIcon: IconButton(
              onPressed: () {
                BlocProvider.of<TerminalBloc>(context)
                    .add(TerminalCommand(command: textController.text));
                textController.clear();
              },
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: white,
              ),
            ),
          ),
        ));
  }
}
