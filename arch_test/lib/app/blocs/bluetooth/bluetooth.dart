class Bluetooth {
  Stream<int> receive() {
    return Stream<int>.periodic(Duration(seconds: 1), (int count) {
      return count;
    }).take(9);
  }

  void stop() {
    //sends status of closed in status stream
  }

  Stream<int> status() {
    return Stream<int>.periodic(Duration(seconds: 2), (int count) {
      return count * 2;
    }).take(10);
  }
}
