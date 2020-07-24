import 'package:arch_test/app/models/StandartPacket.dart';
import 'package:arch_test/app/repos/CloudRepo.dart';
import 'package:arch_test/app/repos/LocalRepo.dart';

class Logger {
  CloudRepo firebase;
  LocalRepo localRepo;
  Future<bool> savePacket(StdPacket packet) {
    //try firebase and handle error
    //try local repository
    return Future.delayed(Duration(seconds: 1), () => true);
  }

  Stream<int> receive({String mission}) {
    return Stream.periodic(Duration(seconds: 1), (int count) => (count))
        .take(5);
  }

  Stream<int> status() {
    return Stream.periodic(Duration(seconds: 3), (int count) => count).take(5);
  }

  void stop() {
    //sends status of closed in status stream
  }
}
