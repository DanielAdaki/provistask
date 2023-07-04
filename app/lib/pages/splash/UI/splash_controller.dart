import 'dart:async';

import 'package:get/get.dart';
import 'package:provitask_app/services/preferences.dart';
import 'package:provitask_app/repositories/client_repository.dart';

class SplashController extends GetxController {
  final _prefs = Preferences();

  @override
  void onInit() {
    super.onInit();
    _start();
  }

  Timer _start() {
    return Timer(const Duration(seconds: 3), _initApp);
  }

  void _initApp() {
    if (_prefs.token == '' || _prefs.token == null) {
      Get.offNamed('/welcome');
    } else {
      Get.offNamed('/login');
    }
    ClientRepository.setClientLocalToken();
  }
}
