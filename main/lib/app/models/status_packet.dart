class StatusPacket {
  int upload;
  int download;
  int usb;

  StatusPacket({this.download, this.usb, this.upload});
  @override
  String toString() {
    return "Status: [down:$download, usb: $usb, up:$upload]";
  }

  // bool isEqual(StatusPacket other) {
  //   return (this.download == other.download &&
  //       this.usb == other.usb &&
  //       this.upload == other.upload);
  // }
}
