class UsbSerial {
  Stream<int> receive() {
    return Stream<int>.periodic(Duration(seconds: 1), (int count) {
      return 2 * count - 1;
    }).take(3);
  }

  Stream<int> status() {
    return Stream<int>.periodic(Duration(seconds: 2), (int count) {
      return -count * 2;
    }).take(2);
  }

  void stop() {
    //sends status of closed in status stream
  }
}
