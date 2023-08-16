import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_controller.dart';

import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_widgets.dart';

class RegisterTaskPage4 extends GetView<RegisterTaskController> {
  final _widgets = RegisterTaskWidget();

  final _controllerLocation = Get.find<LocationController>();

  RegisterTaskPage4({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: const HomeMainAppBar(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        drawerEnableOpenDragGesture: false,
        backgroundColor: Colors.white,
        body: SafeArea(
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
                            _widgets.registerTaskTopBar(4),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: Get.width * 0.9,
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.only(top: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            alignment: Alignment.topLeft,
                                            padding: const EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                              //
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                // imagen del proveedor redondeada
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(75),
                                                  child: Image(
                                                    image: NetworkImage(
                                                        controller
                                                                .perfilProvider[
                                                            "avatar_image"]),
                                                    width: 75,
                                                    height: 75,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),

                                                const SizedBox(width: 10),
                                                Text(
                                                  controller.perfilProvider[
                                                              "name"] +
                                                          " " +
                                                          controller
                                                                  .perfilProvider[
                                                              "lastname"] ??
                                                      "",
                                                  style: const TextStyle(
                                                    color: Color(0xff170591),
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 25),
                                            alignment: Alignment.centerLeft,
                                            child: Icon(
                                              Icons.calendar_today,
                                              color: Colors.indigo[800],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    controller.dateResume(
                                                        controller
                                                            .selectedDay.value
                                                            .toString(),
                                                        controller.selectedHour
                                                            .value),
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 2,
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFDD7813),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              45),
                                                    ),
                                                    child: Text(
                                                      "${controller.perfilProvider['skill_select']!['hourMinimum'].replaceAll("hour_", "") ?? 0} hour min",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 25),
                                            alignment: Alignment.centerLeft,
                                            child: Icon(
                                              Icons.location_on_sharp,
                                              color: Colors.indigo[800],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                _controllerLocation
                                                    .selectedAddress,
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 25),
                                            alignment: Alignment.centerLeft,
                                            child: Icon(
                                              //icono de cinta metrica inlclinada

                                              FontAwesomeIcons.ruler,

                                              color: Colors.indigo[800],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: // condicional de acuerdo a longitud de tartea elegida lengthTask

                                                  controller
                                                              .filters[
                                                                  'long_task']
                                                              .value ==
                                                          "small"
                                                      ? const Text(
                                                          'Small - Est 1 hour',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                        )
                                                      : controller.lengthTask
                                                                  .value ==
                                                              "medium"
                                                          ? const Text(
                                                              'Medium - Est 3 hours',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12,
                                                              ),
                                                            )
                                                          : const Text(
                                                              'Long - Est 5 hours',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 10, right: 25),
                                            alignment: Alignment.centerLeft,
                                            child: Icon(
                                              Icons.local_car_wash,
                                              color: Colors.indigo[800],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: // condicional deacuerdo al vehiculo seleccionado  carTask , si es 1 es "Car" si es 2 es "Motorcycle" si es 3 es "Truck"  si es 4 es "Not needed"

                                                  controller.filters[
                                                              'transportation'] ==
                                                          'car'
                                                      ? const Text(
                                                          'Car',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                        )
                                                      : controller.filters[
                                                                  'transportation'] ==
                                                              'motorcycle'
                                                          ? const Text(
                                                              'Motorcycle',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12,
                                                              ),
                                                            )
                                                          : controller.filters[
                                                                      'transportation'] ==
                                                                  'truck'
                                                              ? const Text(
                                                                  'Truck',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                )
                                                              : const Text(
                                                                  'Not needed',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextFormField(
                                          controller:
                                              controller.descriptionTask.value,
                                          decoration: const InputDecoration(
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => controller.restartTask(),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10, right: 25),
                                              alignment: Alignment.centerLeft,
                                              child: const Icon(
                                                Icons.edit,
                                                color: Color(0xFFDD7813),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: const Text(
                                                  'Edit Task',
                                                  style: TextStyle(
                                                    color: Color(0xFFDD7813),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFDD7813),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  margin: const EdgeInsets.only(
                                                      right: 15),
                                                  child: const Icon(
                                                    //icono de oferta
                                                    FontAwesomeIcons.tag,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: const Text(
                                                      'Price Details',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: const Text(
                                                    'Hourly rate',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    '${'\$' + controller.perfilProvider["skill_select"]["cost"].toString()}/bpfr',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: const Text(
                                                    'Trust and support free',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: const Text(
                                                    '12%',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: const Text(
                                                    'Total rate',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    '\$ ${formatFinalMount(controller.perfilProvider["skill_select"], controller.filters['long_task'].value)}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            // campo de texto
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: TextFormField(
                                                controller: controller
                                                    .descriptionTask.value,
                                                decoration:
                                                    const InputDecoration(
                                                  hintStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                  border: InputBorder.none,
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                _widgets.registerContinueButton(
                                    'Chat & confirm', 20, () async {
                                  await controller.initPaymentSheet();
                                }, bgColor: Colors.indigo[800]!),
                              ],
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
    );
  }

  formatFinalMount(Map skillSelect, String longTask, [int tax = 12]) {
    final double cost = skillSelect["cost"].toDouble();

    final String minimalHour =
        skillSelect["hourMinimum"].replaceAll("hour_", "");
    int hour = 1;
    if (longTask == "small") {
      hour = 1;
    } else if (longTask == "medium") {
      hour = 4;
    } else {
      hour = 8;
    }

    if (int.parse(minimalHour) > hour) {
      hour = int.parse(minimalHour);
    }

    final String type = skillSelect["type_price"];

    // los tipos son by_project_flat_rate , per_hour y free_trading

    if (type == "by_project_flat_rate") {
      // si es por proyecto el precio es el mismo - el 12% de impuestos x la horas
      return (cost) + ((cost * hour) * tax / 100);
    } else if (type == "per_hour") {
      // si es por hora el precio es el costo por la cantidad de horas mas el 12% de impuestos

      return (cost * hour) + ((cost * hour) * tax / 100);
    } else {
      // si es free trading el precio es el costo por la cantidad de horas mas el 12% de impuestos

      return (cost) + ((cost * hour) * tax / 100);
    }
  }
}
