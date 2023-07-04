import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provitask_app/services/preferences.dart';
import 'package:uuid/uuid.dart';

class ClientRepository {
  static final _prefs = Preferences();

  // Save the notification token to  shared preferences
  static void setClientLocalToken() async {
    const uuid = Uuid();
    _prefs.token = uuid.v4();
  }

  // Save the token instance to shared preferences
  static void setClientNotificationToken() async {
    FirebaseMessaging.instance.getToken().then((token) {
      if (_prefs.notificationToken != token) {
        _prefs.notificationToken = token!;
      }
    });
  }
}
