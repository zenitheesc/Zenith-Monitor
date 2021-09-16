//ignore_for_file: prefer_initializing_formals
class Connection {
  late String type;
  late bool state;

  Connection(String type, bool state) {
    this.type = type;
    this.state = state;
  }

  String getType() {
    return type;
  }

  bool getState() {
    return state;
  }
}
