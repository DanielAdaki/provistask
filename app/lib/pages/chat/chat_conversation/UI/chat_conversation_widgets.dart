import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';
import 'package:provitask_app/pages/chat/chat_conversation/UI/chat_conversation_controller.dart';
import 'package:provitask_app/pages/chat/chat_conversation/propuestas/chat_propuesta_controller.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatConversationWidgets {
  final _controller = Get.put<ChatConversationController>(
    ChatConversationController(),
  );

  final _controllerP = Get.put<ChatPropuestaController>(
    ChatPropuestaController(),
  );

  Widget messagesAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.amber[800],
      elevation: 0,
      titleTextStyle: const TextStyle(
        color: Colors.amber,
        fontSize: 25,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              '${_controller.user["name"]}  ${_controller.user["lastname"] ?? ""}',
              style: TextStyle(
                color: Colors.indigo[800],
                fontSize: 25,
              ),
            ),
          ),

          // coloco icono de 3 puntos que abre el menu de opciones

          Align(
            // alineo a la derecha
            alignment: Alignment.centerRight,
            child: Row(children: [
              if (_controller.task.isNotEmpty &&
                  _controller.prefs.user?["isProvider"] == true) ...[
                IconButton(
                  onPressed: () {
                    //final id = Get.parameters['id'];
                    dialogTaskPresupuesto();
                    // Get.toNamed("/chat/$id/crearTareaProvider/");
                  },
                  icon: _controller.task["brutePrice"] == null
                      ? const Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.amber,
                        )
                      : const Icon(
                          Icons.monetization_on,
                          color: Colors.amber,
                        ),
                ),
              ],
              if (_controller.task.isNotEmpty &&
                  _controller.prefs.user?["id"] ==
                      _controller.task['client']) ...[
                IconButton(
                  onPressed: () {
                    //final id = Get.parameters['id'];
                    dialogTaskDetail();
                    // Get.toNamed("/chat/$id/crearTareaProvider/");
                  },
                  icon: _controller.task["status"] != 'request'
                      ? const Icon(
                          Icons.newspaper,
                          color: Colors.amber,
                        )
                      : const Icon(
                          Icons.remove_red_eye,
                          color: Colors.amber,
                        ),
                ),
              ],
              if ((_controller.task.isEmpty &&
                          _controller.prefs.user?["isProvider"]) ==
                      true ||
                  _controller.task["status"] == 'offer' &&
                      _controller.prefs.user?["id"] ==
                          _controller.task["provider"]) ...[
                IconButton(
                  onPressed: () {
                    final id = Get.parameters['id'];

                    Get.toNamed("/chat/$id/crearTareaProvider/");
                  },
                  icon: _controller.task.isEmpty
                      ? const Icon(
                          Icons.bookmark_add_outlined,
                          color: Colors.amber,
                        )
                      : const Icon(
                          Icons.bookmark,
                          color: Colors.amber,
                        ),
                )
              ] else if ((_controller.task["idCreador"] ==
                          _controller.prefs.user?["id"] &&
                      _controller.prefs.user?["isProvider"] == false &&
                      (_controller.task["status"] == "request" ||
                          _controller.task["status"] == "offer") ||
                  _controller.task.isEmpty &&
                      _controller.prefs.user?["isProvider"] == false)) ...[
                IconButton(
                  onPressed: () {
                    final id = Get.parameters['id'];
                    //  Get.delete<LocationController>();
                    Get.put(LocationController());
                    Get.toNamed("/chat/$id/crearTareaClient/");
                  },
                  icon: _controller.task.isEmpty
                      ? const Icon(
                          Icons.bookmark_add_outlined,
                          color: Colors.amber,
                        )
                      : const Icon(
                          Icons.bookmark,
                          color: Colors.amber,
                        ),
                )
              ],
              /* PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.amber,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: () => {},
                      child: const Text(
                        'View profile',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),

                    // onTap: () => Get.toNamed(Routes.PROFILE),
                  ),

                  /* if _controller.task.notEmpty then show this
                PopupMenuItem(
                  child: TextButton(
                    onPressed: () => {},
                    child: const Text(
                      'View request task',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),

                  // onTap: () => Get.toNamed(Routes.PROFILE),
                ),


*/

                  if (_controller.task.isNotEmpty)
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: () => {
                          // muestro el dialogo de detalle de la tarea

                          dialogTaskDetail(),
                        },
                        child: const Text(
                          'View request task',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),

                      // onTap: () => Get.toNamed(Routes.PROFILE),
                    ),
                  if (_controller.task.isNotEmpty &&
                      _controller.task["createdBy"] ==
                          _controller.prefs.user!["id"])
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: () {
                          final id = Get.parameters['id'];

                          Get.toNamed("/chat/$id/crearPropusta?type=edit");
                        },
                        child: const Text(
                          'Send proposal',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                ],
              ),*/
            ]),
          ),
        ],
      ),
      leading: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            margin: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: _controller.user["avatar_image"] != null
                    ? NetworkImage(_controller.user["avatar_image"])
                    : const AssetImage("assets/images/REGISTER TASK/avatar.jpg")
                        as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  dialogTaskPresupuesto() {
    Get.dialog(
        AlertDialog(
          scrollable: true,
          contentPadding: const EdgeInsets.all(10),
          content: Obx(
            () => Container(
              width: Get.width * 1,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  // titulo con el nombre de la tarea

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                              _controller.task["skill"]["name"],
                              style: const TextStyle(
                                color: Color(0xff170591),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // button eye icon para ver la tarea

                            IconButton(
                              onPressed: () {
                                dialogTaskDetail(false);
                              },
                              icon: const Icon(
                                Icons.remove_red_eye,
                                color: Color(0xff170591),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (_controllerP.task['status'] == 'offer' ||
                      _controllerP.task['status'] == 'request') ...[
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
                                    controller: _controllerP.brutePrice.value,
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
                        ],
                      ),
                    ),
                  ] else ...[
                    //muestro el precio sin campo de entrada

                    Container(
                      width: Get.width * 1,
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
                                  'Price of the service: ',
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
                                  child: Text(
                                    _controllerP.task["brutePrice"] != null
                                        ? _controllerP.task["brutePrice"]
                                            .toString()
                                        : "",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
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
                        ],
                      ),
                    ),
                  ],

                  // sizebox para separar

                  const SizedBox(height: 10),

                  if (_controllerP.isFinalPrice.value == true &&
                      _controllerP.task['status'] == 'acepted') ...[
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
                                'Please enter the \n total amount here. :',
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
                                  controller: _controllerP.finalPrice.value,
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
                  _controllerP.isAddDetails.value == true
                      ? registerTaskTellDetails()
                      : Container(),
                  const SizedBox(height: 10),
                  Container(
                    width: Get.width * 1,
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
                                fontSize: 11,
                              ),
                            ),
                            Switch(
                              value: _controllerP.isAddDetails.value,
                              onChanged: (bool value) {
                                _controllerP.isAddDetails.value = value;
                              },
                            ),
                          ],
                        ),
                        if (_controllerP.task['status'] == 'acepted') ...[
                          Row(
                            children: [
                              const Text(
                                'Modify price :',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                              ),
                              Switch(
                                value: _controllerP.isFinalPrice.value,
                                onChanged: (bool value) {
                                  _controllerP.isFinalPrice.value = value;
                                  if (value == false) {
                                    _controllerP.finalPrice.value.text = "";
                                  }
                                },
                              ),
                            ],
                          )
                        ]
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
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
            TextButton(
              onPressed: () {
                if (_controllerP.isFinalPrice.value) {
                  if (_controllerP.finalPrice.value.text == "" ||
                      double.parse(_controllerP.finalPrice.value.text) <=
                          double.parse(_controllerP.brutePrice.value.text)) {
                    Get.snackbar(
                      'Error!',
                      'Final price must be greater than neto price',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                    );

                    return;
                  }
                } else if (_controllerP.brutePrice.value.text == "") {
                  Get.snackbar(
                    'Error!',
                    'Please enter the price',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );

                  return;
                }

                if (_controllerP.isAddDetails.value == true &&
                    _controllerP.descriptionProvis.value.text == "") {
                  Get.snackbar(
                    'Error!',
                    'Please enter the description',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );

                  return;
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
                            if (_controllerP.task["status"] == 'request' ||
                                _controllerP.task["status"] == 'offer') {
                              await _controllerP.registerTask(
                                  _controllerP.task["id"] ?? '',
                                  false,
                                  _controllerP.task["createType"],
                                  "offer");
                            } else {
                              await _controllerP.registerTask(
                                  _controllerP.task["id"] ?? '',
                                  false,
                                  _controllerP.task["createType"],
                                  _controllerP.task["status"]);
                            }

                            Get.snackbar("Success",
                                "The proposal was sent successfully, you will be notified when the customer accepts it or rejects it",
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM);

                            // mando al chat

                            final id = // lo saco argumento ruta
                                Get.parameters['id'] ?? '';

                            await Future.delayed(const Duration(seconds: 2));

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
              },
              child: const Text(
                'Send',
                style: TextStyle(color: Color(0xFF170591)),
              ),
            ),
          ],
        ),
        barrierDismissible: false);
  }

  dialogTaskDetail([mostrarButton = true]) {
    Get.defaultDialog(
      title: "",
      titlePadding: const EdgeInsets.all(0),
      content: SingleChildScrollView(
        child: Container(
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
                          _controller.selectedSkill.value,
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
                              : _controller.task["transportation"] ==
                                      "motorcycle"
                                  ? const Text(
                                      'Motorcycle',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    )
                                  : _controller.task["transportation"] ==
                                          "truck"
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
              // incono para status de la tarea

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 25),
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      //icono de cinta metrica inlclinada

                      Icons.new_releases,

                      color: Colors.indigo[800],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: // condicional de acuerdo a longitud de tartea elegida lengthTask

                          _controller.task["status"] == "request"
                              ? const Text(
                                  'Request',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                )
                              : _controller.task["status"] == "offer"
                                  ? const Text(
                                      'Offer',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    )
                                  : _controller.task["status"] == "accepted"
                                      ? const Text(
                                          'Accepted',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        )
                                      : const Text(
                                          'Completed',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  /*  const Text(
                    "Task Description",
                    style: TextStyle(
                      color: Color(0xff170591),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),*/
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
              ),
              const SizedBox(height: 10),
              // si la tarea tiene status distinto a request muestro el precio

              if (_controller.task["status"] != "request") ...[
                Column(
                  children: [
                    const Text(
                      "Provider Proposal",
                      style: TextStyle(
                        color: Color(0xff170591),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 25),
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.monetization_on,
                              color: Colors.indigo[800],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _controller.task['totalPrice'] != null &&
                                        _controller.task['addFinalPrice'] ==
                                            true
                                    ? "\$ ${_controller.task["brutePrice"]} - initial price"
                                    : "\$ ${_controller.task["brutePrice"]}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_controller.task['totalPrice'] != null &&
                        _controller.task['addFinalPrice'] == true) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 25),
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.monetization_on_sharp,
                                color: Colors.indigo[800],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _controller.task["totalPrice"] != null
                                      ? "\$ ${_controller.task["totalPrice"]} - final price"
                                      : "Not defined",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Text(
                      _controller.task["descriptionProvis"] ?? '',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
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
        // boton de enviar propuesta
        // boton de aceptar propuesta si el usuario no es de provider

        //
        if (_controller.task["client"] == _controller.prefs.user!["id"] &&
            _controller.task['status'] == 'offer') ...[
          TextButton(
            onPressed: () async {
              ProgressDialog pd = ProgressDialog(context: Get.context);

              pd.show(
                max: 100,
                msg: 'Please wait...',
                progressBgColor: Colors.transparent,
              );

              await _controller.acceptProposal(_controller.task["id"]);

              Future.delayed(const Duration(seconds: 5), () {
                pd.close();

                Get.dialog(
                  AlertDialog(
                    title: const Text('Success'),
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    content: const Text('El pago se realizo con exito'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            final id = Get.parameters['id'];

                            Get.offAllNamed("/chat/$id");
                          },
                          child: const Text('Aceptar'))
                    ],
                  ),
                  barrierDismissible: false,
                );
              });

              // muestro ventana de pago exitosa
            },
            child: const Text(
              'Accept proposal',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        if (_controller.task["provider"] == _controller.prefs.user!["id"] &&
            mostrarButton == true) ...[
          TextButton(
            onPressed: () {
              // muestro modal

              dialogTaskPresupuesto();
            },
            child: Text(
              _controller.task["status"] == "request"
                  ? 'Send proposal'
                  : 'Edit proposal',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ],
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
              'Proposal Details',
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
              controller: _controllerP.descriptionProvis.value,
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

  /*Widget bodyChat() {
    return SizedBox(
      height: Get.height * 1,
      width: Get.width * 1,
      child: Chat(
        messages: _controller.messages,
        onAttachmentPressed: handleAttachmentPressed,
        onMessageTap: _controller.handleMessageTap,
        onPreviewDataFetched: _controller.handlePreviewDataFetched,
        onSendPressed: _controller.handleSendPressed,
        showUserAvatars: true,
        showUserNames: true,
        user: types.User(
          id: _controller.prefs.user!["id"].toString(),
        ),
      ),
    );
  }*/

  handleAttachmentPressed() {
    showModalBottomSheet<void>(
      context: Get.context!,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 144,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _controller.handleImageSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Photo'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _controller.handleFileSelection();
                },
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('File'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget stickerMessage() {
    return Container(
      //background color

      color: Colors.amber[800],

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              "Task request : ${_controller.selectedSkill.value}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),

          // icono de flecha hacia la derecha

          IconButton(

              // icono de flecha hacia la derecha

              icon: const Icon(
                Icons.remove_red_eye,
                color: Colors.white,
              ),
              onPressed: () {
                dialogTaskDetail();
              }),
          IconButton(

              // icono de flecha hacia la derecha

              icon: const Icon(
                Icons.reply_sharp,
                color: Colors.white,
              ),
              onPressed: () {
                dialogTaskPresupuesto();
              }),
          // icono de flecha hacia la derecha
        ],
      ),
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
}

String _formatDateTime(String dateTimeString) {
  // Parsea el String de fecha y hora a un objeto DateTime
  DateTime dateTime = DateTime.parse(dateTimeString);

  // Formatea la fecha y hora en el formato "MMM dd, HH:mm"
  String formattedDateTime = DateFormat('MMM dd, HH:mm').format(dateTime);

  return formattedDateTime;
}
