import 'dart:io';

import 'package:cuidapet/app/repositories/shared_prefs_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessageConfigure {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future<void> configure() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
      final sharedPrefs = await SharedPrefsRepository.instance;
      sharedPrefs.registerDeviceToken(await _fcm.getToken());
    }
  }
}
