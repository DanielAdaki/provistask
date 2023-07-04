import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:provitask_app/common/conexion_common.dart';

// llamo getx

import 'package:get/get.dart';

class Preferences {
  static final Preferences _preferences = Preferences._internal();
  factory Preferences() => _preferences;
  Preferences._internal();

  late SharedPreferences _prefs;

  Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  // Local Token Client
  String? get token => _prefs.getString('token');

  set token(String? value) => _prefs.setString('token', value!);

  // Notification Token Client
  String? get notificationToken => _prefs.getString('notificationToken');

  set notificationToken(String? value) =>
      _prefs.setString('notificationToken', value!);

  // Allow notifications
  bool? get allowNotifications => _prefs.getBool('allowNotifications');

  set allowNotification(bool? value) =>
      _prefs.setBool('allowNotifications', value!);

  // creo el set de datos del usuario
  set user(Map<String, dynamic>? value) {
    _prefs.setString('user', jsonEncode(value));
    // actualizo la variable imageProfile
    imageProfile.value = value!['avatar_image'] == null
        ? ''
        : '${ConexionCommon.hostBase}${value['avatar_image']['url']}';
  }

  // creo el get de datos del usuario

  Map<String, dynamic>? get user {
    final user = _prefs.getString('user');
    if (user == null) return null;
    return jsonDecode(user);
  }

  // returno la imagen del usuario si no tiene imagen de perfil retorna null la variable es de tipo observable
  RxString imageProfile = ''.obs;

  // get data user
}
