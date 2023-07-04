import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/pages/welcome/UI/welcome_controller.dart';
import 'package:provitask_app/pages/welcome/UI/welcome_widgets.dart';

class WelcomePage extends GetView<WelcomeController> {
  final _widgets = WelcomeWidgets();

  WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _widgets.welcomeAppBar(),
        backgroundColor: Colors.white,
        floatingActionButton: _widgets.welcomeFloatingActionButton(),
        floatingActionButtonLocation: controller.floatingButtonController(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _widgets.welcomeStepPresentationController(),
            _widgets.welcomeStepIndicator(),
          ],
        ),
      ),
    );
  }
}
