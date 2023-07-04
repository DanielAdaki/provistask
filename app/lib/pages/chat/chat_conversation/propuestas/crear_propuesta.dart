import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/pages/chat/chat_conversation/propuestas/chat_propuesta_controller.dart';
import 'package:provitask_app/pages/chat/chat_conversation/propuestas/chat_propuesta_widgets.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/components/main_app_bar.dart';

class CrearPropuestaChat extends GetView<ChatPropuestaController> {
  final _widgets = ChatConversationWidgets();

  final _controller = Get.put(ChatPropuestaController());

  CrearPropuestaChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeMainAppBar(),
      bottomNavigationBar: const ProvitaskBottomBar(),
      body: SafeArea(
        child: Obx(
          () => _controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  // Envuelve SingleChildScrollView con un Container
                  height: Get.height, // Define la altura del Container
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: DropdownButton<String>(
                                value: _controller.selectedSkill.value,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(
                                  color: Color(0xFFDD7813),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                ),
                                onChanged: _controller.typePage.value == "edit"
                                    ? (String? newValue) {
                                        if (newValue != null) {
                                          _controller.selectedSkill.value =
                                              newValue;
                                        } else {
                                          _controller.selectedSkill.value =
                                              "No Skill Selected";
                                        }
                                      }
                                    : null,
                                items: <String>{
                                  "Celling Fan Instalation",
                                  "Appliance Removal",
                                  "Baby Food Delivery",
                                  "Accounting Services",
                                  "Bartending",
                                  "Baby Prep",
                                  "Cleaning",
                                  "Bookshelf Assembly"
                                }.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),

                            //icono de view para ver la tarea

                            Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 30),
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                onPressed: () {
                                  // muestro en un dialog el detalle de la tarea

                                  dialogTaskDetail();
                                },
                                icon: const Icon(
                                  Icons.remove_red_eye,
                                  color: Color(0xFF170591),
                                ),
                              ),
                            ),
                          ],
                        ),

                        if (_controller.typePage.value == "edit") ...[
                          _widgets.registerTaskSelectLocation(),
                          const SizedBox(width: 50),
                          _widgets.timeLongSelected(),
                          _widgets.registerTaskSelectTimeLong(),
                          _widgets.registerTaskSelectTransport(),
                          Container(
                            width: Get.width * 0.9,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
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
                                    'Task Details',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(top: 20),
                                  child: const Text(
                                    'These are the task details provided by the customer:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(top: 10),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    _controller.descriptionTask.value.text,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        // container con campo para ingresar el precio del servicio
                        if (_controller.isFinalPrice.value == false) ...[
                          Container(
                            width: Get.width * 0.9,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDD7813),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(top: 5),
                                child: const Text(
                                  'Price',
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
                                      const Text(
                                        'Enter the price of the service: ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: Get.width *
                                            0.15, // Define la altura deseada aquí
                                        child: TextField(
                                          controller:
                                              _controller.brutePrice.value,
                                          onChanged: (value) {},
                                          maxLines: 1,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                      ),

                                      // simbolo de dolar

                                      const SizedBox(
                                        width: 10,
                                      ),

                                      const Text(
                                        '\$',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ), // simbolo de dolar
                                    ],
                                  )),
                            ]),
                          ),
                        ] else ...[
                          Container(
                            width: Get.width * 0.9,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDD7813),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(top: 5),
                                child: const Text(
                                  'Final Price',
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
                                    const Text(
                                      'If the final price varies from  the budget,\n please enter the total amount here. :',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: Get.width *
                                          0.15, // Define la altura deseada aquí
                                      child: TextField(
                                        controller:
                                            _controller.finalPrice.value,
                                        onChanged: (value) {},
                                        maxLines: 1,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),

                                    // simbolo de dolar

                                    const SizedBox(
                                      width: 10,
                                    ),

                                    const Text(
                                      '\$',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ), // simbolo de dolar
                                  ],
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            width: Get.width * 0.9,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF170591),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              'The customer will be notified of the change in price and must approve it.',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                        _controller.isAddDetails.value == true
                            ? _widgets.registerTaskTellDetails()
                            : Container(),
                        const SizedBox(height: 10),
                        Container(
                          width: Get.width * 0.9,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Add Details :',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Switch(
                                    value: _controller.isAddDetails.value,
                                    onChanged: (bool value) {
                                      _controller.isAddDetails.value = value;
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Modify price :',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Switch(
                                    value: _controller.isFinalPrice.value,
                                    onChanged: (bool value) {
                                      _controller.isFinalPrice.value = value;
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        /*  Container(
                          width: Get.width * 0.9,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDD7813),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'Price with commission: ${_controller.netoPrice.value.text} \$',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ),*/

                        _widgets.registerContinueButton('Send', 40, () async {
                          if (_controller.isFinalPrice.value) {
                            Logger().i(
                                _controller.finalPrice.value.text.runtimeType);

                            if (_controller.finalPrice.value.text == "" ||
                                double.parse(
                                        _controller.finalPrice.value.text) <=
                                    double.parse(
                                        _controller.brutePrice.value.text)) {
                              Get.snackbar(
                                'Error!',
                                'Final price must be greater than neto price',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );

                              return;
                            }
                          }

                          Get.dialog(
                            AlertDialog(
                              title: const Text('Confirm send'),
                              content: const Text(
                                  'Are you sure you want to submit this proposal ?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      await _controller
                                          .registerTask(_controller.task["id"]);

                                      Get.snackbar("Success",
                                          "The proposal was sent successfully, you will be notified when the customer accepts it or rejects it",
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.BOTTOM);

                                      // mando al chat

                                      final id = // lo saco argumento ruta
                                          Get.parameters['id'] ?? '';

                                      await Future.delayed(
                                          const Duration(seconds: 2));

                                      Get.offAllNamed("/chat/$id");
                                    } catch (e) {
                                      Logger().e(e);
                                    }

                                    Get.back();
                                  },
                                  child: const Text('Send'),
                                ),
                              ],
                            ),
                          );
                        }, bgColor: const Color(0xFF170591))
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  dialogTaskDetail() {
    Get.defaultDialog(
      title: "",
      titlePadding: const EdgeInsets.all(0),
      content: Container(
        width: Get.width * 0.9,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
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
                      Text(
                        _controller.selectedSkill.value ?? "Task request",
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 25),
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
                          alignment: Alignment.centerLeft,
                          child: _controller.task["timeFlexible"] == true
                              ? Text(
                                  "${DateFormat('dd/MM/yyyy').format(DateTime.parse(_controller.task["datetime"]))} - Flexible",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                )
                              : Text(
                                  DateFormat('dd/MM/yyyy - H:m').format(
                                      DateTime.parse(
                                          _controller.task["datetime"])),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                )),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 25),
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
                      _controller.task["location"]["name"],
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 25),
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

                        _controller.task["taskLength"] == "small"
                            ? const Text(
                                'Small - Est 1 hour',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              )
                            : _controller.task["taskLength"] == "medium"
                                ? const Text(
                                    'Medium - Est 3 hours',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  )
                                : const Text(
                                    'Long - Est 5 hours',
                                    style: TextStyle(
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 25),
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

                        _controller.task["transportation"] == "car"
                            ? const Text(
                                'Car',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              )
                            : _controller.task["transportation"] == "motorcycle"
                                ? const Text(
                                    'Motorcycle',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  )
                                : _controller.task["transportation"] == "truck"
                                    ? const Text(
                                        'Truck',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      )
                                    : const Text(
                                        'Not needed',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                const Text(
                  "Task Description",
                  style: TextStyle(
                    color: Color(0xff170591),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _controller.task["description"],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text(
            'Close',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
