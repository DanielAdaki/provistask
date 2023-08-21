import 'dart:convert';
import 'package:get/get.dart';
import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/controllers/auth/auth_controller.dart';
import 'package:provitask_app/models/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _preferences = Preferences._internal();
  factory Preferences() => _preferences;
  Preferences._internal();
  final AuthController authController = Get.find();
  late SharedPreferences _prefs;

  Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  /*String? _token;
  String? get token => _token;*/

  String? get token => _prefs.getString('token');

  set token(String? value) {
    //_token = value;

    _prefs.setString('token', value!);
  }

  String? _fcmToken;

  String? get fcmToken => _fcmToken;

  set fcmToken(String? value) {
    _fcmToken = value;
    _prefs.setString('fcmToken', value!);
  }

  UserMe? _userMe;
  UserMe? get userMe => _userMe;
  set userMe(UserMe? value) {
    _userMe = value;
    _prefs.setString('userMe', jsonEncode(value?.toJson()));
  }

  // variables para saber si el usuario ya vio el tutorial inicial

  bool? get tutorialInitial {
    return _prefs.getBool('tutorialInitial');
  }

  set tutorialInitial(bool? value) {
    _prefs.setBool('tutorialInitial', value!);
  }

  String? _notificationToken;
  String? get notificationToken => _notificationToken;
  set notificationToken(String? value) {
    _notificationToken = value;
    _prefs.setString('notificationToken', value!);
  }

  bool? _allowNotifications;
  bool? get allowNotifications => _allowNotifications;
  set allowNotifications(bool? value) {
    _allowNotifications = value;
    _prefs.setBool('allowNotifications', value!);
  }

  RxString imageProfile = ''.obs;

  String get name {
    if (_userMe == null) {
      final userMeData = _prefs.getString('userMe');
      if (userMeData != null) {
        _userMe = UserMe.fromJson(jsonDecode(userMeData));
      }
    }
    return _userMe?.name ?? '';
  }

  set user(Map<String, dynamic>? value) {
    _prefs.setString('userMe', jsonEncode(value));

    imageProfile.value = value!['avatar_image'] == null
        ? ''
        : '${ConexionCommon.hostBase}${value['avatar_image']["url"]}';
  }

  Map<String, dynamic>? get user {
    if (_userMe == null) {
      final userMeData = _prefs.getString('userMe');
      if (userMeData != null) {
        _userMe = UserMe.fromJson(jsonDecode(userMeData));
      }
    }
    return _userMe?.toJson();
  }

  void clearUserData() async {
    await Future.wait([
      _prefs.remove('fcmToken'),
      _prefs.remove('token'),
      _prefs.remove('userMe'),
    ]);

    authController.isAuthenticated.value = false;
    // _token = null;
    _userMe = null;
    _fcmToken = null;

    //await _prefs.clear();
  }
}

/*import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'package:provitask_app/common/conexion_common.dart';

class Preferences {
  static final Preferences _preferences = Preferences._internal();
  factory Preferences() => _preferences;
  Preferences._internal();

  late SharedPreferences _prefs;

  Future<void> init() async => _prefs = await SharedPreferences.getInstance();

  String? _token;
  String? get token => _token;
  set token(String? value) {
    _token = value;
    _prefs.setString('token', value!);
  }

  Map<String, dynamic>? _name;
  Map<String, dynamic>? get name {
    if (_name == null) {
      final user = _prefs.getString('user');
      if (user != null) {
        _name = jsonDecode(user)['name'];
      }
    }
    return _name;
  }

  String? _notificationToken;
  String? get notificationToken => _notificationToken;
  set notificationToken(String? value) {
    _notificationToken = value;
    _prefs.setString('notificationToken', value!);
  }

  bool? _allowNotifications;
  bool? get allowNotifications => _allowNotifications;
  set allowNotifications(bool? value) {
    _allowNotifications = value;
    _prefs.setBool('allowNotifications', value!);
  }

  RxString imageProfile = ''.obs;

  set user(Map<String, dynamic>? value) {
    _prefs.setString('user', jsonEncode(value));
    imageProfile.value = value!['avatar_image'] == null
        ? ''
        : '${ConexionCommon.hostBase}${value['avatar_image']['url']}';
  }

  Map<String, dynamic>? _user;
  Map<String, dynamic>? get user {
    if (_user == null) {
      final userData = _prefs.getString('user');
      if (userData != null) {
        _user = jsonDecode(userData);
      }
    }
    return _user;
  }
}*/
