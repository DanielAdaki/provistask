import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provitask_app/widget/auth/login_widget.dart' show LoginWidgets;

class LoginPage extends GetView {
  final _widgets = LoginWidgets();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        Scaffold(backgroundColor: Colors.white, body: _widgets.loginPage()));
  }
}
