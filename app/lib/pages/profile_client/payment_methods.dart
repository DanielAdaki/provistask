import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';
import 'package:provitask_app/pages/profile_client/UI/profile_client_widgets.dart';

class PaymentPerfil extends GetView<ProfileController> {
  final _widgets = ProfileClientWidgets();

  //final controller = Get.put(ProfileController());

  PaymentPerfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getProfileData();
    return Obx(
      () => Scaffold(
        // paso elñ titulo edit perfil
        appBar: _widgets.profileAppBar(context, 'Paymet Methods'),
        backgroundColor: Colors.white,
        drawer: _widgets.homeDrawer(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        body: SafeArea(
          child: Column(
            children: [
              Visibility(
                visible: controller.isLoading.value,
                child: const Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(),
                  ],
                )),
              ),
              Expanded(
                child: Visibility(
                  visible: !controller.isLoading.value,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        _widgets.paymentForm(),
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
