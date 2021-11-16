import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zenith_monitor/utils/mixins/class_local_user.dart';

abstract class Authentication {
  String type = "";

  Future<LocalUser> getUserAuthentication();

  Future<LocalUser?> userCreationConditions(DocumentSnapshot? userDoc);

  Future<void> signOut();
}
