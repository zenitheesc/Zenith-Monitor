class StatusPacket {
  int bluetooth;
  int usb;
  int logger;

  StatusPacket({this.bluetooth, this.usb, this.logger});
  @override
  String toString() {
    // TODO: implement toString
    return "[$bluetooth, $usb, $logger]";
  }
}
