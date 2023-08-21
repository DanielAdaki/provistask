import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_controller.dart';

import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_widgets.dart';

class RegisterTaskPage4 extends GetView<RegisterTaskController> {
  final _widgets = RegisterTaskWidget();
  final _controller = Get.find<RegisterTaskController>();

  final _controllerLocation = Get.find<LocationController>();

  RegisterTaskPage4({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: HomeMainAppBar(),
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
                    visible: _controller.isLoading.value,
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
                      visible: !_controller.isLoading.value,
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

                                                Image(
                                                  image: NetworkImage(
                                                      ConexionCommon.hostBase +
                                                          _controller
                                                                  .infoProvider
                                                                  .value[
                                                              "avatar_image"]),
                                                  width: 75,
                                                ),

                                                const SizedBox(width: 10),
                                                Text(
                                                  _controller.infoProvider
                                                          .value["name"] +
                                                      _controller.infoProvider
                                                          .value["lastname"],
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
                                                    _controller.dateResume(),
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
                                                    child: const Text(
                                                      "1 hour min",
                                                      style: TextStyle(
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

                                                  _controller.lengthTask
                                                              .value ==
                                                          "small"
                                                      ? const Text(
                                                          'Small - Est 1 hour',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                        )
                                                      : _controller.lengthTask
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

                                                  _controller.carTask.value == 1
                                                      ? const Text(
                                                          'Car',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                        )
                                                      : _controller.carTask
                                                                  .value ==
                                                              2
                                                          ? const Text(
                                                              'Motorcycle',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12,
                                                              ),
                                                            )
                                                          : _controller.carTask
                                                                      .value ==
                                                                  3
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
                                      InkWell(
                                        onTap: () => _controller.restartTask(),
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
                                      const SizedBox(height: 10),
                                      Container(
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
                                                    '${'\$' + _controller.infoProvider.value["cost_per_houers"]}/hr',
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
                                                    '\$12.45/hr',
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
                                                    '\$${_controller.totalMount.value}/hr',
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
                                                controller: _controller
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
                                    'Chat & confirm price', 20, () {
                                  //_controller.registerTask();
                                  _controller.initPaymentSheet();
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
}
