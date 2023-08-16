import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterTaskWidget {
  final _controller = Get.put<RegisterTaskController>(RegisterTaskController());

  final _controllerLocation = Get.put(LocationController());

  Widget registerTaskTopBar([int step = 1]) {
    return Container(
      // height: Get.height * 0.77,
      width: Get.width,
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFDD7813),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // condicional imagen if _controller.formStepOne.value == 1 muestro la imagen stepCompleted.png sino muestro la imagen checkTask.png

                  Image.asset(
                    'assets/images/REGISTER TASK/stepCompleted.png',
                    /*  _controller.formStepTwo.value == 1
                        ? 'assets/images/REGISTER TASK/stepCompleted.png'
                        : 'assets/images/REGISTER TASK/checkTask.png',*/
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 15,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 50 * _controller.formStepOne.value,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDD7813),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // texto de color  #969699; con un salto de linea
                  Text(
                    'Tell us what\nyou need',
                    //alignment: Alignment.center,
                    textAlign: TextAlign.center,
                    // si _controller.formStepOne.value == 1 el color es  #DD7813  sino es #969699

                    style: TextStyle(
                      color: _controller.formStepOne.value == 1
                          ? const Color(0xFFDD7813)
                          : const Color(0xFF969699),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/REGISTER TASK/stepCompleted.png',
                    /* _controller.formStepTwo.value == 1
                        ? 'assets/images/REGISTER TASK/stepCompleted.png'
                        : 'assets/images/REGISTER TASK/checkTask.png',*/
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 15,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 50 * _controller.formStepTwo.value,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDD7813),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // texto de color  #969699; con un salto de linea
                  Text(
                    'Choose your \nbest provider',
                    //alignment: Alignment.center,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _controller.formStepTwo.value == 1
                          ? const Color(0xFFDD7813)
                          : const Color(0xFF969699),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    _controller.formStepThree.value == 1
                        ? 'assets/images/REGISTER TASK/stepCompleted.png'
                        : 'assets/images/REGISTER TASK/checkTask.png',
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 15,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 50 * _controller.formStepThree.value,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDD7813),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // texto de color  #969699; con un salto de linea
                  Text(
                    'Browse your \n date and time',
                    //alignment: Alignment.center,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _controller.formStepThree.value == 1
                          ? const Color(0xFFDD7813)
                          : const Color(0xFF969699),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/REGISTER TASK/checkTask.png',
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 15,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 50 * 0.25,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDD7813),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // texto de color  #969699; con un salto de linea
                  const Text(
                    'Tell us what\nyou need',
                    //alignment: Alignment.center,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF969699),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget registerTaskTitle() {
    return Container(
      //    height: Get.height * 0.77,
      width: Get.width,
      alignment: Alignment.topCenter,
      child: const Text(
        'Tell us about the task you\'re working on',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget registerTaskSubTitle() {
    return Container(
      //   height: Get.height * 0.77,
      width: Get.width,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: const Text(
        'These details are used to display Providers in your area who meet your requirements',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget registerTaskSelectLocation() {
    return Container(
      width: Get.width * 0.9,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFDD7813),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Your task location',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                // icono de la ubicacion si no hay seleccionada una

                _controllerLocation.selectedAddress == ""
                    ? const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 18,
                      )
                    : const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 18,
                      ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      border: _controllerLocation.selectedAddress == ""
                          ? Border.all(color: Colors.white, width: 1)
                          : Border.all(
                              color: const Color(0xFFDD7813), width: 1),
                    ),
                    child: Obx(() => Text(
                          _controllerLocation.selectedAddress == ""
                              ? 'Select your location'
                              : _controllerLocation.selectedAddress,
                          style: const TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final LatLng? initialLocation =
                        _controllerLocation.initialCameraPosition;
                    LocationResult result =
                        await Navigator.of(Get.context!).push(
                      MaterialPageRoute(
                        builder: (context) => PlacePicker(
                          "AIzaSyBbluXRjZ7O3n3A6n5Wi01ePbDm9pXMCH4",
                          defaultLocation: initialLocation,
                        ),
                      ),
                    );

                    _controllerLocation.updateSelectedLocation(result.latLng!);

                    _controllerLocation.getAddressFromLatLng();
                    await _controller.findProviders();
                    _controller.formStepOne.value = 0.7;
                    /* Get.dialog(
                      madDialogGooglePLace(),
                      barrierDismissible: false,
                    );*/
                  },
                  // si no hay seleccionada una direccion, el icono es un add  si no es un edit

                  icon: _controllerLocation.selectedAddress == ""
                      ? const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        )
                      : const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18,
                        ),
                ),
              ],
            ),
          ),
          _controllerLocation.selectedAddress != ""
              ? Container(
                  alignment: Alignment.centerLeft,
                  child: _controller.listProviders.isNotEmpty
                      ? const Text(
                          'Good news! Provitask is available in four area',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )
                      : const Text(
                          'No providers available in your area',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                )
              : Container(),

          // cuadro de texto que diga "How long is your task?"
        ],
      ),
    );
  }

  Widget registerTaskSelectTimeLong() {
    return Container(
      width: Get.width * 0.9,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFDD7813),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 5),
            child: const Text(
              'How long is your task?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 5),
            child: const Text(
              'Select the duration that your task requireds',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Checkbox(
                    value: _controller.filters["long_task"] == "small",
                    shape: const CircleBorder(),
                    onChanged: (a) {
                      _controller.filters["long_task"].value = "small";
                    },
                    activeColor: const Color(0xFFDD7813),
                    checkColor: const Color(0xFFDD7813),
                  ),
                  title: const Text('Small - Est. 1 hr',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.left),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Checkbox(
                    value: _controller.filters["long_task"].value == "medium",
                    shape: const CircleBorder(),
                    onChanged: (a) {
                      _controller.filters["long_task"].value = "medium";
                    },
                    activeColor: const Color(0xFFDD7813),
                    checkColor: const Color(0xFFDD7813),
                  ),
                  title: const Text('Medium - Est. 2-4 hr',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.left),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Checkbox(
                    value: _controller.filters["long_task"].value == "large",
                    shape: const CircleBorder(),
                    onChanged: (a) {
                      _controller.filters["long_task"].value = "large";
                    },
                    activeColor: const Color(0xFFDD7813),
                    checkColor: const Color(0xFFDD7813),
                  ),
                  title: const Text('Large - Est. 5+ hr',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.left),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget timeLongSelected() {
    return Container(
        width: Get.width * 0.9,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFDD7813),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              const Icon(
                Icons.av_timer_outlined,
                color: Colors.white,
                size: 20,
              ),
              // texto conditional dependiendo de la seleccion de _controller.lengthTask.value

              _controller.lengthTask.value == "small"
                  ? const Text(
                      'Small - Est 1 hr',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    )
                  : _controller.lengthTask.value == "medium"
                      ? const Text(
                          'Medium - Est 2-4 hr',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        )
                      : _controller.lengthTask.value == "large"
                          ? const Text(
                              'Large - Est 5+ hr',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            )
                          : const Text(""),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  _controller.formStepOne.value = 0.25;
                },
              ),
            ],
          ),
        ));
  }

  Widget registerTaskSelectTransport() {
    return Container(
      width: Get.width * 0.9,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFDD7813),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 5),
            child: const Text(
              'Any kind of transportation',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _controller.filters["transportation"].value =
                              "motorcycle";
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _controller
                                            .filters["transportation"].value ==
                                        "motorcycle"
                                    ? Colors.grey[400]
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(2),
                              margin: const EdgeInsets.only(right: 5),
                              child: Icon(
                                FontAwesomeIcons.motorcycle,
                                color: Colors.indigo[800],
                                size: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Motobicycle',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          _controller.filters["transportation"].value = "car";
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _controller
                                            .filters["transportation"].value ==
                                        "car"
                                    ? Colors.grey[400]
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(2),
                              margin: const EdgeInsets.only(right: 5),
                              child: Icon(
                                FontAwesomeIcons.car,
                                color: Colors.indigo[800],
                                size: 19,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Car',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _controller.filters["transportation"].value = "truck";
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _controller
                                            .filters["transportation"].value ==
                                        "truck"
                                    ? Colors.grey[400]
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(2),
                              margin: const EdgeInsets.only(right: 5),
                              child: Icon(
                                FontAwesomeIcons.truck,
                                color: Colors.indigo[800],
                                size: 19,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Truck',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          _controller.filters["transportation"].value =
                              "not_necessary";
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _controller
                                            .filters["transportation"].value ==
                                        "not_necessary"
                                    ? Colors.grey[400]
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(2),
                              margin: const EdgeInsets.only(right: 5),
                              child: Icon(
                                FontAwesomeIcons.xmark,
                                color: Colors.indigo[800],
                                size: 28,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Not needed',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget franjaInformativa(String texto,
      [int colorText = 0xFFFFFFFF,
      int colorFondo = 0xFFD67B21,
      double border = 10,
      double fontSize = 14,
      double height = 30,
      bool bold = false,
      String alignment = "center"]) {
    return Container(
      alignment: alignment == "center"
          ? Alignment.center
          : alignment == "left"
              ? Alignment.centerLeft
              : Alignment.centerRight,
      //padding: const EdgeInsets.only(left: 20),
      width: Get.width * 0.9,
      height: height,
      decoration: BoxDecoration(
        color: Color(colorFondo),
        borderRadius: BorderRadius.circular(border),
      ),
      child: Text(
        texto,
        textAlign: alignment == "center"
            ? TextAlign.center
            : alignment == "left"
                ? TextAlign.left
                : TextAlign.right,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: Color(colorText)),
      ),
    );
  }

  Widget franjaInformativaFlecha(
    String texto, [
    int colorText = 0xFF838383,
    int colorFondo = 0xFFFFFFFF,
    double border = 10,
    double fontSize = 18,
    double height = 30,
    bool bold = false,
    String alignment = "center",
    double iconSize = 20,
    int iconColor = 0xFFD67B21,
    IconData icon = Icons.watch_later_outlined,
    // una funcion

    Function? onTap,
  ]) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        width: Get.width * 0.9,
        height: height,
        decoration: BoxDecoration(
          color: Color(colorFondo),
          borderRadius: BorderRadius.circular(border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                texto,
                textAlign: alignment == "center"
                    ? TextAlign.center
                    : alignment == "right"
                        ? TextAlign.right
                        : TextAlign.left,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight:
                        bold == true ? FontWeight.bold : FontWeight.normal,
                    color: Color(colorText)),
              ),
            ),
            IconButton(
              icon: Icon(icon, size: iconSize, color: Color(iconColor)),
              onPressed: null,
            )
          ],
        ),
      ),
    );
  }

  Widget selectData() {
    return Container(
      width: Get.width * 0.9,
      height: Get.height * 0.25,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      //  margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFDD7813),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          franjaInformativa("Select date ", 0xFFFFFFFF, 0xFF3828a8, 15, 18, 30,
              false, "center"),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: _controller.filters["typeDate"].value == "today"
                        ? const Color(0xFF3828a8)
                        : const Color(0xFF3828a8).withOpacity(0.7),
                    onPressed: () {
                      _controller.filters["typeDate"].value = "today";

                      // calculo la fecha de hoy

                      DateTime today = DateTime.now();

                      _controller.filters["day"].value =
                          DateFormat('yyyy-MM-dd').format(today);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Today',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: _controller.filters["typeDate"].value == "within_3"
                        ? const Color(0xFF3828a8)
                        : const Color(0xFF3828a8).withOpacity(0.7),
                    onPressed: () {
                      _controller.filters["typeDate"].value = "within_3";
                      // calculo la fecha dentro de 3 dias iniciando desde hoy
                      DateTime nextWeek = DateTime.now().add(const Duration(
                        days: 3,
                      ));

                      _controller.filters["day"].value =
                          DateFormat('yyyy-MM-dd').format(nextWeek);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Within 3 days',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: _controller.filters["typeDate"].value == "next_week"
                        ? const Color(0xFF3828a8)
                        : const Color(0xFF3828a8).withOpacity(0.7),
                    onPressed: () {
                      _controller.filters["typeDate"].value = "next_week";
                      // calculo la fecha de la proxima semana iniciando desde hoy
                      DateTime nextWeek = DateTime.now().add(const Duration(
                        days: 7,
                      ));
                      // lo guardo en el filtro en el formato YYYY-MM-DD
                      _controller.filters["day"].value =
                          DateFormat('yyyy-MM-dd').format(nextWeek);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Within A Week',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color:
                        _controller.filters["typeDate"].value == "choose_date"
                            ? const Color(0xFF3828a8)
                            : const Color(0xFF3828a8).withOpacity(0.7),
                    onPressed: () {
                      _controller.filters["typeDate"].value = "choose_date";
                      Get.dialog(
                        Container(
                          color: Colors.white,
                          height: Get.height * 0.5,
                          child: Column(
                            children: [
                              Expanded(
                                child: CupertinoDatePicker(
                                  backgroundColor: Colors.white,
                                  onDateTimeChanged: (DateTime newDate) {
                                    _controller.filters["day"].value =
                                        DateFormat('yyyy-MM-dd')
                                            .format(newDate);
                                  },
                                  use24hFormat: true,
                                  maximumDate: DateTime.now().add(
                                    const Duration(days: 30),
                                  ),
                                  minimumYear: DateTime.now().year,
                                  maximumYear: DateTime.now().year + 1,
                                  minimumDate: DateTime.now(),
                                  initialDateTime: DateTime.now().add(
                                    const Duration(seconds: 10),
                                  ),
                                  minuteInterval: 1,
                                  mode: CupertinoDatePickerMode.date,
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text('Select'),
                              )
                            ],
                          ),
                        ),
                        barrierDismissible: false,
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                        _controller.filters["typeDate"] == 'choose_date' &&
                                _controller.filters["day"].value != ''
                            ? _controller.filters["day"].value
                            : ' Choose date',
                        style: const TextStyle(color: Colors.white)),

                    // si el filtro es choose_date, muestro el datepicker en un dialog
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget selectDataRangeTime() {
    return Container(
      width: Get.width * 0.9,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFDD7813),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 5),
            child: const Text(
              'Time of the day',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 5),
            child: const Text(
              'Select a time range for the task',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Checkbox(
                    value:
                        _controller.filters["time_of_day"].value == "morning",
                    shape: const CircleBorder(),
                    onChanged: (a) {
                      _controller.filters["time_of_day"].value = "morning";
                      _controller.filters["hour"].value = "I'm Flexible";
                    },
                    activeColor: const Color(0xFFDD7813),
                    checkColor: const Color(0xFFDD7813),
                  ),
                  title: const Text('Morning (8am - 12pm)',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                      textAlign: TextAlign.left),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Checkbox(
                    value:
                        _controller.filters["time_of_day"].value == "afternoon",
                    shape: const CircleBorder(),
                    onChanged: (a) {
                      _controller.filters["time_of_day"].value = "afternoon";
                      _controller.filters["hour"].value = "I'm Flexible";
                    },
                    activeColor: const Color(0xFFDD7813),
                    checkColor: const Color(0xFFDD7813),
                  ),
                  title: const Text('Afternoon (12pm - 5pm)',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                      textAlign: TextAlign.left),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Checkbox(
                    value:
                        _controller.filters["time_of_day"].value == "evening",
                    shape: const CircleBorder(),
                    onChanged: (a) {
                      _controller.filters["time_of_day"].value = "evening";
                      _controller.filters["hour"].value = "I'm Flexible";
                    },
                    activeColor: const Color(0xFFDD7813),
                    checkColor: const Color(0xFFDD7813),
                  ),
                  title: const Text('Evening (5pm - 9:30pm)',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                      textAlign: TextAlign.left),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget registerTaskTellDetails() {
    return Container(
      width: Get.width * 0.9,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFDD7813),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 5),
            child: const Text(
              'Tell us the details of the task',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: const Text(
              'Tell us in more detail what you need to do, how space, how to get to the place or other information so that Provitask can show you the most appropiate professionals for you needs.',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: TextField(
              controller: _controller.descriptionTask.value,
              maxLines: 3,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _controller.formStepOne.value = 1;
                } else {
                  _controller.formStepOne.value = 0.7;
                }
              },
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 12,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: const Text(
              'If you need two or more Providers, plis post additional Task for each Providers needed',
              style: TextStyle(
                color: Color(0xFF8B4001),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget registerTaskPickDate() {
    return Container(
      width: Get.width * 0.9,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 26, top: 10),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Date',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: _controller.filters["typeDate"].value == "today"
                        ? const Color(0xFF3828a8)
                        : const Color(0xFF3828a8).withOpacity(0.7),
                    onPressed: () {
                      _controller.filters["typeDate"].value = "today";

                      // calculo la fecha de hoy

                      DateTime today = DateTime.now();

                      _controller.filters["day"].value =
                          DateFormat('yyyy-MM-dd').format(today);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Today',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: _controller.filters["typeDate"].value == "within_3"
                        ? const Color(0xFF3828a8)
                        : const Color(0xFF3828a8).withOpacity(0.7),
                    onPressed: () {
                      _controller.filters["typeDate"].value = "within_3";
                      // calculo la fecha dentro de 3 dias iniciando desde hoy
                      DateTime nextWeek = DateTime.now().add(const Duration(
                        days: 3,
                      ));

                      _controller.filters["day"].value =
                          DateFormat('yyyy-MM-dd').format(nextWeek);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Within 3 days',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: _controller.filters["typeDate"].value == "next_week"
                        ? const Color(0xFF3828a8)
                        : const Color(0xFF3828a8).withOpacity(0.7),
                    onPressed: () {
                      _controller.filters["typeDate"].value = "next_week";
                      // calculo la fecha de la proxima semana iniciando desde hoy
                      DateTime nextWeek = DateTime.now().add(const Duration(
                        days: 7,
                      ));
                      // lo guardo en el filtro en el formato YYYY-MM-DD
                      _controller.filters["day"].value =
                          DateFormat('yyyy-MM-dd').format(nextWeek);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Within A Week',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color:
                        _controller.filters["typeDate"].value == "choose_date"
                            ? const Color(0xFF3828a8)
                            : const Color(0xFF3828a8).withOpacity(0.7),
                    onPressed: () {
                      _controller.filters["typeDate"].value = "choose_date";
                      Get.dialog(
                        Container(
                          color: Colors.white,
                          height: Get.height * 0.5,
                          child: Column(
                            children: [
                              Expanded(
                                child: CupertinoDatePicker(
                                  backgroundColor: Colors.white,
                                  onDateTimeChanged: (DateTime newDate) {
                                    _controller.filters["day"].value =
                                        DateFormat('yyyy-MM-dd')
                                            .format(newDate);
                                  },
                                  use24hFormat: true,
                                  maximumDate: DateTime.now().add(
                                    const Duration(days: 30),
                                  ),
                                  minimumYear: DateTime.now().year,
                                  maximumYear: DateTime.now().year + 1,
                                  minimumDate: DateTime.now(),
                                  initialDateTime: DateTime.now().add(
                                    const Duration(seconds: 10),
                                  ),
                                  minuteInterval: 1,
                                  mode: CupertinoDatePickerMode.date,
                                ),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text('Select'),
                              )
                            ],
                          ),
                        ),
                        barrierDismissible: false,
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                        _controller.filters["typeDate"] == 'choose_date' &&
                                _controller.filters["day"].value != ''
                            ? _controller.filters["day"].value
                            : ' Choose date',
                        style: const TextStyle(color: Colors.white)),

                    // si el filtro es choose_date, muestro el datepicker en un dialog
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget registerTaskPickCertainDate() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Or select a certain date',
              style: TextStyle(
                color: Colors.indigo[800],
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        _controller.certainDateTask.value == null
            ? ElevatedButton(
                onPressed: () async {
                  _controller.certainDateTask.value = await showDatePicker(
                    context: Get.context!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary:
                                Colors.indigo[800]!, // header background color
                            onPrimary: Colors.white, // header text color
                            onSurface: Colors.grey[600]!, // body text color
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFDD7813), // button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.indigo[800]),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: const Text(
                  'Select Date',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFDD7813),
                    ),
                    child: Text(
                      _controller.certainDateTask.value
                          .toString()
                          .substring(0, 10),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      _controller.certainDateTask.value = await showDatePicker(
                        context: Get.context!,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Colors
                                    .indigo[800]!, // header background color
                                onPrimary: Colors.white, // header text color
                                onSurface: Colors.grey[600]!, // body text color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(
                                      0xFFDD7813), // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
      ],
    );
  }

  Widget registerTaskPickTimeOfDay() {
    return Container(
      width: Get.width * 0.9,
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 26, top: 10),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Time of day',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    value:
                        _controller.filters["time_of_day"].value == "morning",
                    onChanged: (c) {
                      _controller.filters["time_of_day"].value = "morning";
                      _controller.filters["hour"].value = "I'm Flexible";
                    },
                    activeColor: Colors.indigo[800],
                    checkColor: Colors.indigo[800],
                    shape: const CircleBorder(),
                  ),
                  const Text(
                    'Morning (8am - 12pm)',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value:
                        _controller.filters["time_of_day"].value == "afternoon",
                    onChanged: (c) {
                      _controller.filters["time_of_day"].value = "afternoon";
                      _controller.filters["hour"].value = "I'm Flexible";
                    },
                    activeColor: Colors.indigo[800],
                    checkColor: Colors.indigo[800],
                    shape: const CircleBorder(),
                  ),
                  const Text(
                    'Afternoon (12pm - 5pm)',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value:
                        _controller.filters["time_of_day"].value == "evening",
                    onChanged: (c) {
                      _controller.filters["time_of_day"].value = "evening";
                      _controller.filters["hour"].value = "I'm Flexible";
                    },
                    activeColor: Colors.indigo[800],
                    checkColor: Colors.indigo[800],
                    shape: const CircleBorder(),
                  ),
                  const Text(
                    'Evening (5pm - 9:30pm)',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget registerTaskPickResume() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          margin: const EdgeInsets.symmetric(vertical: 15),
          width: Get.width * 0.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Request for:',
                  style: TextStyle(
                    color: Colors.indigo[800],
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                  _controller.dateResume(),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: Get.width * 0.7,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.library_add_check_rounded,
                color: Color(0xFFDD7813),
              ),
              Text(
                'Next confirm your details to get connected\nwith your provider',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        registerContinueButton('Let\'s find your provider', 40,
            () => _controller.formController.value = 3,
            bgColor: const Color(0xFFDD7813)),
      ],
    );
  }

  Widget registerTaskDrawerFilter() {
    return Drawer(
      backgroundColor: const Color(0xFFDD7813),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20, left: 20),
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black45,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 26, top: 10),
                child: const Text(
                  'Filters',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              registerTaskPickDate(),
              const SizedBox(
                height: 20,
              ),
              registerTaskPickTimeOfDay(),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
                width: Get.width * 0.8,
                child: franjaInformativa("Or select a specific time",
                    0xFFFFFFFF, 0xFF3828a8, 15, 18, 30, false, "center"),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 26, vertical: 5),
                      width: Get.width * 0.6,
                      child: Align(
                        alignment: Alignment
                            .centerLeft, // Alineación a la izquierda del DropdownButtonFormField
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                          ),
                          dropdownColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          value: _controller.filters['hour'].value,
                          items: _controller.arrayHours
                              .map(
                                (hour) => DropdownMenuItem(
                                  value: hour,
                                  child: Text(
                                    hour,
                                    style: const TextStyle(
                                      color: Color(0xFF3828a8),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            _controller.filters['hour'].value =
                                value.toString();

                            _controller.filters["time_of_day"].value = "";

                            _controller.formStepThree.value = 0.5;
                          },
                        ),
                      )
                      // Agrega un Container vacío si _controller.disponibility está vacío
                      ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 26, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Price',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_controller.filters["type_price"].value !=
                        "not_price") ...[
                      IconButton(
                        onPressed: () {
                          _controller.filters["type_price"].value = "not_price";
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
              Container(
                width: Get.width * 0.9,
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 26, top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _controller.filters["type_price"].value ==
                              "per_hour",
                          onChanged: (c) {
                            _controller.filters["type_price"].value =
                                "per_hour";
                          },
                          activeColor: Colors.indigo[800],
                          checkColor: Colors.indigo[800],
                          shape: const CircleBorder(),
                        ),
                        const Text(
                          'Per hour',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _controller.filters["type_price"].value ==
                              "by_project_flat_rate",
                          onChanged: (c) {
                            _controller.filters["type_price"].value =
                                "by_project_flat_rate";
                          },
                          activeColor: Colors.indigo[800],
                          checkColor: Colors.indigo[800],
                          shape: const CircleBorder(),
                        ),
                        const Text(
                          'By project/flat rate',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _controller.filters["type_price"].value ==
                              "free_trading",
                          onChanged: (c) {
                            _controller.filters["type_price"].value =
                                "free_trading";
                          },
                          activeColor: Colors.indigo[800],
                          checkColor: Colors.indigo[800],
                          shape: const CircleBorder(),
                        ),
                        const Text(
                          'Free Trading',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.white,
                height: 30,
                endIndent: 25,
                indent: 25,
                thickness: 1,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 26, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Provider Type',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_controller.filters["provider_type"].value !=
                        "not_provider") ...[
                      IconButton(
                        onPressed: () {
                          _controller.filters["provider_type"].value =
                              "not_provider";
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      ),
                    ]
                  ],
                ),

                // si el filtro esta activo, muestro el icono para limpiar el filtro
              ),
              Container(
                width: Get.width * 0.9,
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 26, top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _controller.filters["provider_type"].value ==
                              "elite",
                          onChanged: (c) {
                            _controller.filters["provider_type"].value =
                                "elite";
                          },
                          activeColor: Colors.indigo[800],
                          checkColor: Colors.indigo[800],
                          shape: const CircleBorder(),
                        ),
                        const Text(
                          'Elite Provider',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _controller.filters["provider_type"].value ==
                              "great_value",
                          onChanged: (c) {
                            _controller.filters["provider_type"].value =
                                "great_value";
                          },
                          activeColor: Colors.indigo[800],
                          checkColor: Colors.indigo[800],
                          shape: const CircleBorder(),
                        ),
                        const Text(
                          'Great Value',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // botonera para aplicar filtro y limpiar filtro
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: Get.width * 0.2,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () async {
                          _controller.key.currentState!.openEndDrawer();
                          await _controller.findProviders();

                          //cierro el drawer
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.2,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          _controller.clearFilters();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Clear',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset(
                          'assets/images/REGISTER TASK/proteger.png',
                          color: Colors.indigo[800],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Text(
                        'Keep your mind at ease at all times. All Providers are subjected to identification and criminal background checks.',
                        style: TextStyle(
                          color: Colors.indigo[800],
                          overflow: TextOverflow.clip,
                          fontSize: 10,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget registerTaskReviewTask() {
    return Column(
      children: [
        Container(
          width: Get.width * 0.9,
          margin: const EdgeInsets.only(top: 25),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            /*  boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                spreadRadius: 1,
              )
            ],*/
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 15),
                child: Text(
                  'Review your task description',
                  style: TextStyle(
                    color: Colors.indigo[800],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFDD7813),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: // colo un campo de texto

                    TextFormField(
                  controller: _controller.descriptionTask.value,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Describe your task',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 15),
                child: Text(
                  'Payment method',
                  style: TextStyle(
                    color: Colors.indigo[800],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'You may see a temporary hold on your payment method in the amount of your Providers hourly rate. Don\'t worry - you\'re only billed when your task is complete!',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          margin: const EdgeInsets.symmetric(vertical: 15),
          width: Get.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: Image.asset(
                    'assets/images/REGISTER TASK/proteger.png',
                    color: const Color(0xFFDD7813),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Flexible(
                flex: 3,
                child: Text(
                  'Keep your mind at ease at all times. All Providers are subjected to identification and criminal background checks.',
                  style: TextStyle(
                    color: Colors.grey,
                    overflow: TextOverflow.clip,
                    fontSize: 11,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: Get.width * 0.9,
          child: const Text(
            'Don\'t worry you won\'t be builled until your task is complete. Once confirmed, you can chat with your Provider to update the details.',
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ),
        registerContinueButton('Confirm', 20, () {
          if (_controller.reviewCardTask.value.text.isNotEmpty) {
            _controller.formController.value = 5;
          } else {
            Get.snackbar(
              'Information!',
              "Pease enter a card information",
              backgroundColor: Colors.yellow,
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        }, bgColor: const Color(0xFFDD7813)),
      ],
    );
  }

  Widget registerContinueButton(
      String text, double margin, void Function() onTap,
      {Color bgColor = Colors.amber, Color textColor = Colors.white}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }

// mapa en ventana modal

  Widget mapDialog() {
    final LatLng? initialLocation = _controllerLocation.initialCameraPosition;

    ///    final LatLng? selectedLocation = _controllerLocation.selectedLocation;
    Set<Marker> markers = <Marker>{};

    // Agregar un marcador en la posición inicial

    // Agregar un marcador si se ha seleccionado una ubicación
    if (_controllerLocation.selectedLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: _controllerLocation.selectedLocation!,
          draggable: true,
          onDragEnd: (LatLng newPosition) {
            // Manejar el evento de arrastrar el marcador
            //_controllerLocation.updateSelectedLocation(newPosition);
          },
        ),
      );

      _controllerLocation.update();
    } else {
      markers.add(
        Marker(
          markerId: const MarkerId('initialLocation'),
          position: initialLocation != null
              ? LatLng(initialLocation.latitude, initialLocation.longitude)
              : const LatLng(37.42796133580664,
                  -122.085749655962), // Usa la ubicación actual o una ubicación predeterminada si no se ha obtenido la ubicación actual
          draggable: true,
          onDragEnd: (LatLng newPosition) {
            // Manejar el evento de arrastrar el marcador
            // _controllerLocation.updateSelectedLocation(newPosition);
          },
        ),
      );
    }

    return Obx(() => AlertDialog(
          title: const Text('Selecciona una ubicación'),
          content: SizedBox(
            width: Get.width * 1,
            height: Get.height * 1,
            child: GetBuilder<LocationController>(
              builder: (controller) => GoogleMap(
                mapType: MapType.normal,
                markers: markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: initialLocation != null
                      ? LatLng(
                          initialLocation.latitude, initialLocation.longitude)
                      : const LatLng(37.42796133580664,
                          -122.085749655962), // Usa la ubicación actual o una ubicación predeterminada si no se ha obtenido la ubicación actual
                  zoom: 16.0,
                ),
                onTap: (LatLng location) {
                  //controller.updateSelectedLocation(location);

                  _controllerLocation.updateSelectedLocation(location);
                  markers.clear();

                  // Añadir un nuevo marcador en la ubicación seleccionada
                  markers.add(
                    Marker(
                      markerId: const MarkerId('selectedLocation'),
                      position: location,
                      draggable: true,
                      onDragEnd: (LatLng newPosition) {
                        // Manejar el evento de arrastrar el marcador
                        // _controllerLocation.updateSelectedLocation(newPosition);
                      },
                    ),
                  );

                  // Actualizar el estado del controlador para que el marcador aparezca en el mapa
                  _controllerLocation.update();
                },
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              onPressed: _controllerLocation.selectedLocation != null
                  ? () async {
                      // Si se ha seleccionado una ubicación, obtener la dirección y cerrar el diálogo
                      _controllerLocation.getAddressFromLatLng();
                      await _controller.findProviders();
                      Get.back(result: _controllerLocation.selectedAddress);
                    }
                  : null,
              child: const Text('Seleccionar'),
            ),
          ],
        ));
  }

  Widget registerTaskImageZone() {
    return Obx(
      () => Container(
        // height: Get.height * 0.2,
        width: Get.width * 0.9,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity, // Hace que el botón ocupe todo el ancho
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_a_photo), // Añade un icono al botón
                label: Text(
                  'Add images',
                  style: TextStyle(
                    color: Colors.indigo[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: Get.context!,
                    builder: (context) => AlertDialog(
                      title: const Text('Select an option'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: const Text('Cámara'),
                            onTap: () async {
                              Navigator.pop(context);
                              final picker = ImagePicker();
                              final pickedFile = await picker.pickImage(
                                source: ImageSource.camera,
                                maxWidth: 800,
                                maxHeight: 800,
                                imageQuality: 80,
                              );
                              if (pickedFile == null) return;
                              _controller.images.clear();
                              int length = await pickedFile.length();
                              if (length <= 10000000 &&
                                  _controller.images.length < 3) {
                                _controller.images.add(File(pickedFile.path));
                              }
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo),
                            title: const Text('Galería'),
                            onTap: () async {
                              Navigator.pop(context);
                              final picker = ImagePicker();
                              final List<XFile> pickedFile =
                                  await picker.pickMultiImage(
                                maxWidth: 800,
                                maxHeight: 800,
                                imageQuality: 80,
                              );

                              if (pickedFile.isEmpty) return;

                              //vacio el array de imagenes

                              _controller.images.clear();
                              for (var img in pickedFile) {
                                int length = await img.length();
                                print("añadiendo");
                                if (length <= 10000000 &&
                                    _controller.images.length < 3) {
                                  _controller.images.add(File(img.path));
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  )),
                ),
              ),
            ),
            const Text(
              'Máximo 5MB por imagen, máximo 3 imágenes',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
            if (_controller.images.isNotEmpty) ...[
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _controller.images.length,
                  itemBuilder: (BuildContext context, int index) {
                    var img = _controller.images[index];
                    return Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(img!),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _controller.images.remove(img),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  // widget de calentario usando table calendar y getx
}
