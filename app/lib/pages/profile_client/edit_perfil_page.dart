import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';
import 'package:provitask_app/pages/profile_client/UI/profile_client_widgets.dart';

class EditPerfil extends GetView<ProfileController> {
  final _widgets = ProfileClientWidgets();

  final _controller = Get.put(ProfileController());

  EditPerfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // paso elñ titulo edit perfil
        appBar: _widgets.profileAppBar(context, 'Edit Profile'),
        backgroundColor: Colors.white,
        drawer: _widgets.homeDrawer(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        body: SafeArea(
          child: Column(
            children: [
              Visibility(
                visible: _controller.isLoading.value,
                child: const Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(),
                  ],
                )),
              ),
              Expanded(
                child: Visibility(
                  visible: !_controller.isLoading.value,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        _widgets.registerFrom(),
                        const SizedBox(
                          height: 30,
                        ),

                        // si es proveedor muestro sus opciones

                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
