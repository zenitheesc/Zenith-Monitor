import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zenith_monitor/constants/colors_constants.dart';
import 'package:zenith_monitor/core/pipelines/data_pipeline/data_bloc.dart';
import 'package:zenith_monitor/modules/terminal/bloc/terminal_bloc.dart';
import 'package:zenith_monitor/utils/mixins/mission_variables/class_mission_variables.dart';
import 'package:zenith_monitor/widgets/standard_app_bar.dart';

/// All the code commented is related to TerminalController.
/// Due to a bloc package update, the code already implemented
/// in zenith_monitor has became obsolete.
/// New design decisions must be made prior to any implementation.

class Terminal extends StatelessWidget {
  Terminal({Key? key}) : super(key: key);
  final textController = TextEditingController();
  List<Widget> listItems = [];
  final _scrollController = ScrollController();

  _scrollToEnd() async {
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 50.0,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _scrollToEnd());
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
              /* if (state is NewPackageState) {
                listItems.add(terminalRow(listItems.length, state.usbResponse));
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              }*/

              //return SliverList(delegate: SliverChildListDelegate(listItems));
              List<Widget> terminalList = [];
              if (state is NewPackageState) {
                for (int i = 0; i < state.noParsedStringList.length; i++) {
                  terminalList.add(terminalRow(i, state.noParsedStringList[i]));
                }
              }
              _scrollToEnd();
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

  Wrap terminalRow(int index, String package) {
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
            package,
            style: const TextStyle(color: white),
          ), // Here will be showed the text appering in the terminal.
        )
      ],
    );
  }

  Widget terminalTextField(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(28, 0, 28, 10), //values from figma
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
                BlocProvider.of<DataBloc>(context).add(NewPackageEventData(
                    newPackage: MissionVariablesList(),
                    noParsedString: textController.text));
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
