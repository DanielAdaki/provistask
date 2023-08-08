import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_widgets.dart';

class RegisterProviderPage2 extends GetView<ProfileController> {
  final _widgets = RegisterProviderWidgets();

  RegisterProviderPage2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _widgets.registerProAppBAr(2),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _widgets.registerProStepper(2),
              _widgets.registerProStepSubtitle(2),
              _widgets.registerProFormStep2(),
            ],
          ),
        ),
      ),
    );
  }
}
