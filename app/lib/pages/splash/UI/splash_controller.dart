import 'dart:async';

import 'package:get/get.dart';

import 'package:provitask_app/services/preferences.dart';
import 'package:provitask_app/controllers/auth/login_controller.dart';
//import 'package:provitask_app/models/data/permission_data.dart';

final _prefs = Preferences();

class SplashController extends GetxController {
  final _loginController = Get.put(LoginController());

  @override
  void onInit() {
    super.onInit();
    // PermissionData.getPermissionUbication();
    _start();
  }

  Timer _start() {
    return Timer(const Duration(seconds: 3), _initApp);
  }

  void _initApp() {
    if (_prefs.tutorialInitial == true) {
      if (_prefs.token != null) {
        _loginController.autoLogin();
      } else {
        Get.offNamed('/login');
      }
    } else {
      Get.offNamed('/welcome');
    }

    // ClientRepository.setClientLocalToken();
  }
}
