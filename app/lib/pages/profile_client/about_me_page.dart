import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';
import 'package:provitask_app/pages/profile_client/UI/profile_client_widgets.dart';

class AboutProvider extends GetView<ProfileController> {
  final _widgets = ProfileClientWidgets();

  AboutProvider({Key? key}) : super(key: key);

  // ejecuto el metodo getSkills para obtener los skills del usuario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // paso elñ titulo edit perfil
      appBar: _widgets.profileAppBar(''),
      backgroundColor: Colors.white,
      drawer: _widgets.homeDrawer(),
      bottomNavigationBar: const ProvitaskBottomBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              _widgets.formAboutMe(),
            ],
          ),
        ),
      ),
    );
  }
}
