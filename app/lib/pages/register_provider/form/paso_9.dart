import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_controller.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_widgets.dart';

class RegisterProviderPage9 extends GetView<RegisterProviderController> {
  final _widgets = RegisterProviderWidgets();

  RegisterProviderPage9({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // cargo la metadata del usaurio
    return Obx(
      () => Scaffold(
        appBar: _widgets.registerProAppBAr(9),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                _widgets.registerProStepper(9),
                _widgets.registerProStepSubtitle(9),
                _widgets.registerProFormStep9(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
