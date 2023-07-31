import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provitask_app/controllers/location/location_controller.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_controller.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_widgets.dart';
import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/components/main_drawer.dart';

class RegisterTaskPage extends GetView<RegisterTaskController> {
  final _widgets = RegisterTaskWidget();
  // llamo LocationController()
  final _controllerLocation = Get.find<LocationController>();

  RegisterTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controllerLocation.onInit();
    return Obx(
      () => Scaffold(
        appBar: const HomeMainAppBar(),
        backgroundColor: Colors.white,
        drawer: const HomeDrawer(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        drawerEnableOpenDragGesture: false,
        body: Scrollbar(
          thickness: 3, // Ajusta el grosor de la barra de desplazamiento
          radius: const Radius.circular(3),
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/REGISTER TASK/bg_degraded.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Visibility(
                      visible: controller.isLoading.value,
                      child: const Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Visibility(
                        visible: !controller.isLoading.value,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _widgets.registerTaskTopBar(1),
                              const SizedBox(
                                height: 30,
                              ),
                              Column(
                                children: [
                                  if (controller.listSkills.isNotEmpty) ...[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: DropdownButton<String>(
                                        value:
                                            controller.filters['skill'].value,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                          color: Color(0xFFDD7813),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20,
                                        ),
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            controller.filters['skill'].value =
                                                newValue;

                                            // si la ubicacion ya está seleccionada consulto proveedores para ver si hay

                                            if (_controllerLocation
                                                    .selectedAddress !=
                                                "") {
                                              controller.findProviders();
                                            }
                                          } else {
                                            controller.filters['skill'].value =
                                                "Ninguna habilidad seleccionada";
                                          }
                                        },
                                        items:
                                            controller.listSkills.map((skill) {
                                          return DropdownMenuItem<String>(
                                            value: skill['id'].toString(),
                                            child: Text(skill['name']),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                  if (controller.listSkills.isNotEmpty) ...[
                                    _widgets.registerTaskSelectLocation(),
                                  ] else ...[
                                    // si no hay skills muestro un mensaje indicando que se estan cargando

                                    Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: const Text(
                                        "Loading skills...",
                                        style: TextStyle(
                                          color: Color(0xFFDD7813),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                  const SizedBox(width: 50),
                                  if (_controllerLocation.selectedAddress !=
                                          "" &&
                                      controller.listProviders.isNotEmpty) ...[
                                    /*Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        alignment: Alignment.topLeft,
                                        width: Get.width * 0.9,
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          color: Color(0xff170591),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(width: 10),
                                            Text(
                                              'How long is your task?',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                //fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),*/
                                    _widgets.registerTaskSelectTimeLong(),
                                    // _widgets.timeLongSelected(),
                                    _widgets.registerTaskSelectTransport(),
                                    _widgets.registerTaskTellDetails(),

                                    _widgets.registerTaskImageZone(),
                                    _widgets.registerContinueButton('Continue',
                                        15, () => controller.continueForm1(),
                                        bgColor: Colors.indigo[800]!)
                                  ]
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
