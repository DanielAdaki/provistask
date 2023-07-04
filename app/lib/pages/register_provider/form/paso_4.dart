import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_controller.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_widgets.dart';

class RegisterProviderPage4 extends GetView<RegisterProviderController> {
  final _widgets = RegisterProviderWidgets();

  RegisterProviderPage4({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _widgets.registerProAppBAr(4),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                _widgets.registerProStepper(4),
                _widgets.registerProStepSubtitle(4),
                _widgets.registerProFormStep4(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
