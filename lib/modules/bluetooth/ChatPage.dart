import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({required this.server});

  @override
  ChatPageState createState() => ChatPageState();
}

class Message {
  int whom;
  String text;
  double? latitude;
  double? longitude;

  Message(this.whom, this.text, {this.latitude, this.longitude});
}

class ChatPageState extends State<ChatPage> {
  static const clientID = 0;
  BluetoothConnection? connection;

  List<Message> messages = List<Message>.empty(growable: true);
  String _messageBuffer = '';

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Row> list = messages.map((_message) {
      return Row(
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color:
                    _message.whom == clientID ? Colors.blueAccent : Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (text) {
                    return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                  }(_message.text.trim()),
                  style: const TextStyle(color: Colors.white),
                ),
                if (_message.longitude != null &&
                    _message.latitude != null) ...[
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      openGoogleMaps(_message.latitude!, _message.longitude!);
                    },
                    child: const Text('Abrir endereço no Google Maps'),
                  ),
                ],
              ],
            ),
          ),
        ],
      );
    }).toList();

    final serverName = widget.server.name ?? "Unknown";
    return Scaffold(
      appBar: AppBar(
          title: (isConnecting
              ? Text('Connecting chat to $serverName...')
              : isConnected
                  ? Text('Live chat with $serverName')
                  : Text('Chat log with $serverName'))),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView(
                  padding: const EdgeInsets.all(12.0),
                  controller: listScrollController,
                  children: list),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      style: const TextStyle(fontSize: 15.0),
                      controller: textEditingController,
                      decoration: InputDecoration.collapsed(
                        hintText: isConnecting
                            ? 'Wait until connected...'
                            : isConnected
                                ? 'Type your message...'
                                : 'Chat got disconnected',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                      enabled: isConnected,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: isConnected
                          ? () => _sendMessage(textEditingController.text)
                          : null),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> openGoogleMaps(double latitude, double longitude) async {
    final Uri googleMapsUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  void _onDataReceived(Uint8List data) {
    // Converter buffer para string
    String dataString = String.fromCharCodes(data);
    print("Data received (len: ${data.length}): $dataString");
    if (dataString.isEmpty) {
      // descartar se estiver em branco
      return;
    }

    // Checar pacote
    RegExp regExp =
        RegExp(r'-?[0-9.]+;[0-9]+;-?[0-9.]+;-?[0-9.]+;[0-9.]+;"[0-9:]+"');
    if (regExp.hasMatch(dataString) == false) {
      print("Pacote inválido: $dataString");
      return;
    }

    // Dividir pacote
    // 85;6;-23.550501;-46.633301;760;"12:30:45"
    // rssi;id;latitude;longitude;altitude
    List<String> parts = dataString.split(';');

    // Extrair dados
    double? rssi;
    double? id;
    double? latitude;
    double? longitude;
    double? altitude;
    String? datahora;

    if (parts.length >= 1) rssi = double.tryParse(parts[0].trim());
    if (parts.length >= 2) id = double.tryParse(parts[1].trim());
    if (parts.length >= 3) latitude = double.tryParse(parts[2].trim());
    if (parts.length >= 4) longitude = double.tryParse(parts[3].trim());
    if (parts.length >= 5) altitude = double.tryParse(parts[4].trim());
    if (parts.length >= 6) datahora = parts[5].trim();
    print(
        "- RSSI: $rssi, ID: $id, Latitude: $latitude, Longitude: $longitude, Altitude: $altitude, Data/Hora: $datahora");

    setState(() {
      messages.add(
        Message(
          1,
          "$id ($datahora, $rssi dB)",
          longitude: longitude,
          latitude: latitude,
        ),
      );
    });
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.isNotEmpty) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode("$text\r\n")));
        await connection!.output.allSent;

        setState(() {
          messages.add(Message(clientID, text));
        });

        Future.delayed(const Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
}
