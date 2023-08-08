// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';
import 'package:provitask_app/pages/profile_client/UI/profile_client_widgets.dart';

class EditSkills extends GetView<ProfileController> {
  final _widgets = ProfileClientWidgets();

  EditSkills({Key? key}) : super(key: key);

  // ejecuto el metodo getSkills para obtener los skills del usuario

  @override
  Widget build(BuildContext context) {
    controller.getSkills();
    return Obx(
      () => Scaffold(
        // paso elñ titulo edit perfil
        appBar: _widgets.profileAppBar(),
        backgroundColor: Colors.white,
        drawer: _widgets.homeDrawer(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Skills',
                  style: TextStyle(
                    color: Color(0xff170591),
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7),
                _widgets.formSkills(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
