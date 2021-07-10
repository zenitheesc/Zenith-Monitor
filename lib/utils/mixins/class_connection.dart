//import 'package:zenith_monitor/utils/helpers/string_to_pattern.dart';

class Connection {
  late String type;
  late bool state;

  Connection(String type, bool state ){
    this.type = type;
    this.state = state;
  }

  String getType(){
    return this.type;
  }

  bool getstate(){
    return this.state;
  }
}