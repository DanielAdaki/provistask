import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
                    _controller.formStepOne.value == 1
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
                    _controller.formStepTwo.value == 1
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
                  onPressed: () {
                    // abro el dialog en el widget MapDialog

                    Get.dialog(
                      mapDialog(),
                      barrierDismissible: false,
                    );
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
                    value: _controller.lengthTask.value == "small",
                    shape: const CircleBorder(),
                    onChanged: (a) {
                      _controller.lengthTask.value = "small";
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
                    value: _controller.lengthTask.value == "medium",
                    shape: const CircleBorder(),
                    onChanged: (a) {
                      _controller.lengthTask.value = "medium";
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
                    value: _controller.lengthTask.value == "large",
                    shape: const CircleBorder(),
                    onChanged: (a) {
                      _controller.lengthTask.value = "large";
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
                          _controller.carTask.value = 1;
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _controller.carTask.value == 1
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
                          _controller.carTask.value = 2;
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _controller.carTask.value == 2
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
                          _controller.carTask.value = 3;
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _controller.carTask.value == 3
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
                          _controller.carTask.value = 4;
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _controller.carTask.value == 4
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _controller.filters["date"].value = "today";
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: Size.zero,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  backgroundColor: _controller.filters["date"].value != "today"
                      ? Colors.transparent
                      : Colors.indigo[800],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: _controller.filters["date"].value != "today"
                              ? Colors.white
                              : Colors.transparent)),
                ),
                child: Text(
                  'Today',
                  style: TextStyle(
                    color: _controller.dateTask.value != 1
                        ? Colors.white
                        : Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.filters["date"].value = "whitin_3_days";
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: Size.zero,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  backgroundColor:
                      _controller.filters["date"].value != "whitin_3_days"
                          ? Colors.transparent
                          : Colors.indigo[800],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: _controller.filters["date"].value !=
                                  "whitin_3_days"
                              ? Colors.white
                              : Colors.transparent)),
                ),
                child: Text(
                  'Within 3 days',
                  style: TextStyle(
                    color: _controller.filters["date"].value != "whitin_3_days"
                        ? Colors.white
                        : Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.filters["date"].value = "whitin_week";
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size.zero,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    backgroundColor:
                        _controller.filters["date"].value != "whitin_week"
                            ? Colors.transparent
                            : Colors.indigo[800],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: _controller.filters["date"].value !=
                                    "whitin_week"
                                ? Colors.white
                                : Colors.transparent)),
                  ),
                  child: Text(
                    'Within a week',
                    style: TextStyle(
                      color: _controller.dateTask.value != 3
                          ? Colors.white
                          : Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size.zero,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    backgroundColor:
                        _controller.filters["date"].value != "choose_date"
                            ? Colors.transparent
                            : Colors.indigo[800],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: _controller.filters["date"].value !=
                                    "choose_date"
                                ? Colors.white
                                : Colors.transparent)),
                  ),
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      color: _controller.filters["date"].value != "choose_date"
                          ? Colors.white
                          : Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
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
                    value: _controller.filters["time"].value == "morning",
                    onChanged: (c) {
                      _controller.filters["time"].value = "morning";
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
                    value: _controller.filters["time"].value == "afternoon",
                    onChanged: (c) {
                      _controller.filters["time"].value = "afternoon";
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
                    value: _controller.filters["time"].value == "evening",
                    onChanged: (c) {
                      _controller.filters["time"].value = "evening";
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
                margin: const EdgeInsets.only(left: 26, top: 10),
                child: const Text(
                  'Price',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
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
                          value:
                              _controller.filters["price"].value == "per_hour",
                          onChanged: (c) {
                            _controller.filters["price"].value = "per_hour";
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
                          value: _controller.filters["price"].value ==
                              "by_project_flat_rate",
                          onChanged: (c) {
                            _controller.filters["price"].value =
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
                          value: _controller.filters["price"].value ==
                              "free_trading",
                          onChanged: (c) {
                            _controller.filters["price"].value = "free_trading";
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
                child: const Text(
                  'Provider Type',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
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

  // widget de calentario usando table calendar y getx
}
