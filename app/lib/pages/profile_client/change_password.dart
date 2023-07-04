// creo pagina donde aparezaca un boton para solicitar el cambio de contraseña

// Compare this snippet from app\lib\pages\profile_client\change_password.dart:

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';

import 'package:provitask_app/pages/profile_client/UI/profile_client_widgets.dart';

class ChangePassword extends GetView<ProfileController> {
  final _widgets = ProfileClientWidgets();

  final _controller = Get.put(ProfileController());

  ChangePassword({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // paso elñ titulo edit perfil
        appBar: _widgets.profileAppBar('Change Password'),
        backgroundColor: Colors.white,
        drawer: _widgets.homeDrawer(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        body: SafeArea(
          child: Column(
            children: [
              Visibility(
                visible: _controller.isLoading.value,
                child: Expanded(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 150.0),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: !_controller.isLoading.value,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Visibility(
                            visible: !_controller.isResquestingCode.value &&
                                !_controller.succesCode.value,
                            child: _widgets.requestOtpForm()),
                        Visibility(
                            visible: _controller.isResquestingCode.value &&
                                !_controller.succesCode.value,
                            child: _widgets.optForm()),
                        Visibility(
                            visible: _controller.succesCode.value,
                            child: _widgets.changePasswordForm()),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
