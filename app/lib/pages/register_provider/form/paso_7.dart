import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_widgets.dart';

class RegisterProviderPage7 extends GetView<ProfileController> {
  final _widgets = RegisterProviderWidgets();

  RegisterProviderPage7({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // cargo la metadata del usaurio
    return Obx(
      () => Scaffold(
        appBar: _widgets.registerProAppBAr(7),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                _widgets.registerProStepper(7),
                _widgets.registerProStepSubtitle(7),
                _widgets.registerProFormStep7(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
