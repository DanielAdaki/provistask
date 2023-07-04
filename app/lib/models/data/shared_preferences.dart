import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _preferences = Preferences._internal();
  factory Preferences() => _preferences;
  Preferences._internal();

  late SharedPreferences _prefs;

  Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  // Local Token Client
  String? get localToken => _prefs.getString('localToken');

  set localToken(String? value) => _prefs.setString('localToken', value!);

  // Notification Token Client
  String? get notificationToken => _prefs.getString('notificationToken');

  set notificationToken(String? value) =>
      _prefs.setString('notificationToken', value!);

  // Allow notifications
  bool? get allowNotifications => _prefs.getBool('allowNotifications');

  set allowNotification(bool? value) =>
      _prefs.setBool('allowNotifications', value!);
}
