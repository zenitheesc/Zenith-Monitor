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

  bool getState(){
    return this.state;
  }
}
