import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provitask_app/controllers/auth/login_controller.dart'
    show LoginController;
import 'package:provitask_app/widget/auth/login_widget.dart' show LoginWidgets;
import 'package:loading_overlay/loading_overlay.dart';

class LoginPage extends GetView<LoginController> {
  final _widgets = LoginWidgets();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          body: LoadingOverlay(
            isLoading: controller.isLoading.value,
            progressIndicator: const CircularProgressIndicator(),
            color: Colors.white,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [_widgets.loginForm()],
                ),
              ),
            ),
          ),
        ));
  }
}
