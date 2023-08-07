import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';
import 'package:provitask_app/pages/profile_client/UI/profile_client_widgets.dart';

class ProfileClientPage extends GetView<ProfileController> {
  final _widgets = ProfileClientWidgets();

  ProfileClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _widgets.profileAppBar("Profile"),
        backgroundColor: Colors.white,
        drawer: _widgets.homeDrawer(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        body: Scrollbar(
          thickness: 3, // Ajusta el grosor de la barra de desplazamiento
          radius: const Radius.circular(3),
          child: RefreshIndicator(
            onRefresh: () async {
              controller.isLoading.value = true;
              await Future.wait<void>([controller.getProfileData()]);
              controller.isLoading.value = false;
            },
            child: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (controller.isLoading.value == true) ...[
                        Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        )
                      ] else ...[
                        const SizedBox(
                          height: 30,
                        ),
                        _widgets.profileImage(),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          controller.clientNameShow.value,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[900],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        _widgets.profileOptions(),
                        const SizedBox(
                          height: 30,
                        ),
                        controller.isProvider.value == true
                            ? _widgets.providerForm()
                            : Container(),
                        // botones de delsgoueo y  volverse proveedor

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            controller.isProvider.value == false
                                ? ElevatedButton(
                                    onPressed: () {
                                      // mando a la ruta /register_provider

                                      Get.toNamed('/register_provider');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 15),
                                    ),
                                    child: Text(
                                      'Go provider',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber[900],
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
