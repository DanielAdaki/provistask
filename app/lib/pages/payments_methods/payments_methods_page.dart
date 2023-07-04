import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/pages/payments_methods/UI/payments_metods_controller.dart';
import 'package:provitask_app/pages/payments_methods/UI/payments_metods_widgets.dart';

class PaymentMethodsPage extends GetView<PaymentMethodsController> {
  final _widgets = PaymentMethodsWidgets();

  PaymentMethodsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _widgets.pmAppBar(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: Get.width * 0.8,
                child: _widgets.pmOptionsController(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
