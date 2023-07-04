import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_controller.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_widgets.dart';

class RegisterProviderPage5 extends GetView<RegisterProviderController> {
  final _widgets = RegisterProviderWidgets();

  RegisterProviderPage5({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // cargo la metadata del usaurio
    return Obx(
      () => Scaffold(
        appBar: _widgets.registerProAppBAr(5),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                _widgets.registerProStepper(5),
                _widgets.registerProStepSubtitle(5),
                _widgets.registerProFormStep5(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
