import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_controller.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_widgets.dart';

class RegisterProviderPage extends GetView<RegisterProviderController> {
  final _widgets = RegisterProviderWidgets();

  RegisterProviderPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _widgets.registerProAppBAr(),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _widgets.registerProStepper(1),
              _widgets.registerProStepSubtitle(1),
              _widgets.registerProFormStep1(),
            ],
          ),
        ),
      ),
    );
  }
}
