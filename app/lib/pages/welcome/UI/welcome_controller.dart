import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  final stepWelcome = RxInt(1);

  FloatingActionButtonLocation floatingButtonController() {
    if (stepWelcome.value == 1) {
      return FloatingActionButtonLocation.centerFloat;
    } else {
      return FloatingActionButtonLocation.endFloat;
    }
  }
}
