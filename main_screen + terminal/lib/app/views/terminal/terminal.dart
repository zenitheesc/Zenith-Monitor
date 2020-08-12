import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zenith_monitor/app/bloc/data_bloc/data_bloc.dart';
import 'package:zenith_monitor/app/bloc/terminal_bloc/terminal_bloc.dart';
import 'package:zenith_monitor/app/models/status_packet.dart';
import 'widgets/customAppbar.dart';

class TerminalView extends StatefulWidget {
  final Stream<String> input;

  TerminalView({Key key, this.input}) : super(key: key);

  @override
  _TerminalViewState createState() => _TerminalViewState();
}

class _TerminalViewState extends State<TerminalView> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  Color backgroundColor = Colors.black87;
  Color textColor = Colors.grey[100];

  List<String> accumulator = [];
  List<String> cleanAccumulator = [];

  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Widget _terminalMainBody() {
    return Container(
      color: backgroundColor,
      child: StreamBuilder(
          stream: widget.input,
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              accumulator.add(snapshot.data);
              cleanAccumulator.add(snapshot.data);
            }
            return ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: cleanAccumulator.length,
                itemBuilder: (context, int index) {
                  // -------------------- Adjust time according to data receving
                  _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(seconds: 1),
                      curve: Curves.easeOut);
                  // -----------------------------------------------------------
                  return Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 7),
                        child: Text(
                          index.toString(),
                          style: GoogleFonts.sourceCodePro(
                              fontSize: 14, color: textColor),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            cleanAccumulator[index].toString(),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.ltr,
                            style: GoogleFonts.sourceCodePro(
                                fontSize: 14, color: textColor),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }

  Widget _terminalWriteLine() {
    return Container(
      height: 25,
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: Colors.grey[800],
            width: 0.5,
          )),
      child: TextField(
        controller: _textController,
        textAlign: TextAlign.start,
        cursorColor: Colors.grey[600],
        style: GoogleFonts.sourceCodePro(color: textColor, fontSize: 14),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(bottom: 12),
          fillColor: backgroundColor,
          icon: Icon(Icons.arrow_forward_ios, color: textColor, size: 20),
          hintText: "Escreva um comando",
          hintStyle: GoogleFonts.sourceCodePro(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        onSubmitted: (string) =>
            _commandLine(accumulator, string, _textController),
      ),
    );
  }

  void _commandLine(List<String> accumulator, String command,
      TextEditingController controller) {
    accumulator.add(command);
    cleanAccumulator.add(command);
    controller.clear();

    // Send command to the Space Probe
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(textColor, accumulator, cleanAccumulator),
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 20,
              child: _terminalMainBody(),
            ),
            _terminalWriteLine(),
          ],
        ));
  }
}

// -----------------------------------------------------------------------------
// Codigo usando BLoC
class TerminalView2 extends StatefulWidget {
  TerminalView2({Key key}) : super(key: key);

  @override
  _TerminalView2State createState() => _TerminalView2State();
}

class _TerminalView2State extends State<TerminalView2> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // this shoud be somewhere else
    // aí todo terminal vai poder ser stateless
    // se não o terminal não vai mostrar os dados de antes dele ser aberto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terminal"),
        actions: [
          IconButton(
              icon: Icon(Icons.linear_scale),
              onPressed: () {
                BlocProvider.of<TerminalBloc>(context)
                    .add(TerminalNewData(123));
              })
        ],
      ),
      body: BlocBuilder<TerminalBloc, TerminalState>(
        builder: (context, state) {
          print(state);
          if (state is TerminalInitial) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is TerminalUpdate) {
            return TerminalList(
              data: state.data,
            );
          } else
            return Container();
        },
      ),
    );
  }
}

class TerminalList extends StatelessWidget {
  final List<dynamic> data;
  final Color backgroundColor = Colors.black87;
  Color textColor = Colors.grey[100];
  final controller = ScrollController();
  TerminalList({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: ListView.builder(
        controller: controller,
        itemCount: data.length,
        shrinkWrap: true,
        itemBuilder: (context, int index) {
          if (controller.position.maxScrollExtent != null) {
            controller.animateTo(controller.position.maxScrollExtent,
                duration: Duration(milliseconds: 500), curve: Curves.easeOut);
          }
          if (data[index] is StatusPacket) {
            textColor = Colors.blue[200];
          } else {
            textColor = Colors.grey[100];
          }

          return Row(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7),
                child: Text(
                  index.toString(),
                  style:
                      GoogleFonts.sourceCodePro(fontSize: 14, color: textColor),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Text(
                    data[index].toString(),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.ltr,
                    style: GoogleFonts.sourceCodePro(
                        fontSize: 14, color: textColor),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
