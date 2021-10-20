import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';

abstract class Authentication {
  Future<String?> userCreationConditions(
      DocumentSnapshot? userDoc, LocalUser user);

  Future<void> signOut();
}
