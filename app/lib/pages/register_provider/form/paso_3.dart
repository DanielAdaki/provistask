import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_controller.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_widgets.dart';

class RegisterProviderPage3 extends GetView<RegisterProviderController> {
  final _widgets = RegisterProviderWidgets();

  RegisterProviderPage3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _widgets.registerProAppBAr(3),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                _widgets.registerProStepper(3),
                _widgets.registerProStepSubtitle(3),
                _widgets.registerProFormStep3(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
