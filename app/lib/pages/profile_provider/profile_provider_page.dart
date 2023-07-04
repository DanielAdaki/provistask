import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/pages/profile_provider/UI/profile_provider_controller.dart';
import 'package:provitask_app/pages/profile_provider/UI/profile_provider_widgets.dart';

class ProfileProviderPage extends GetView<ProfileProviderController> {
  final _widgets = ProfileProviderWidgets();

  ProfileProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _widgets.profileProviderAppBar(),
        backgroundColor: Colors.white,
        bottomNavigationBar: const ProvitaskBottomBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: _widgets.profileProviderOptionsController(),
            ),
          ),
        ),
      ),
    );
  }
}
