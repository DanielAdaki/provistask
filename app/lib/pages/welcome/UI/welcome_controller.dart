import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/services/preferences.dart';

final _prefs = Preferences();

class WelcomeController extends GetxController {
  final stepWelcome = RxInt(1);

  // preferences

  FloatingActionButtonLocation floatingButtonController() {
    if (stepWelcome.value == 1) {
      return FloatingActionButtonLocation.centerFloat;
    } else {
      return FloatingActionButtonLocation.endFloat;
    }
  }

  void setTutorialViewed() async {
    _prefs.tutorialInitial = true;
  }
}
