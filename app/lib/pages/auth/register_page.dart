import 'package:flutter/material.dart';
import 'package:get/get.dart';

// importo controlador de registro

import 'package:provitask_app/controllers/auth/register_controller.dart'
    show RegisterController;

class Register extends GetView<RegisterController> {
  // final _widgets = RegisterWidget();

  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.amber[800],
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //  _widgets.registerHeader(),
              // _widgets.registerFrom(),
            ],
          ),
        ),
      ),
    );
  }
}
