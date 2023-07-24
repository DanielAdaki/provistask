import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/pages/login/UI/login2_controller.dart';
import 'package:provitask_app/pages/login/UI/login_widgets.dart';

class LoginPage extends GetView<LoginController2> {
  final _widgets = LoginWidgets();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_widgets.loginFrom()],
            ),
          ),
        ),
      ),
    );
  }
}
