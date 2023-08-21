import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/pages/chat/chat_conversation/propuestas/chat_propuesta_controller.dart';
import 'package:provitask_app/pages/chat/chat_conversation/propuestas/chat_propuesta_widgets.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/components/main_app_bar.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class CrearTaskClient extends GetView<ChatPropuestaController> {
  final _widgets = ChatConversationWidgets();

  final _controller = Get.put(ChatPropuestaController());

  CrearTaskClient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeMainAppBar(),
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
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    _controller.selectedSkill.value = newValue;
                                  } else {
                                    _controller.selectedSkill.value =
                                        "No Skill Selected";
                                  }
                                },
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
                          ],
                        ),
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
                                child: TextField(
                                  controller: _controller.descriptionTask.value,
                                  maxLines: 5,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter a description',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        _widgets.registerContinueButton('Send', 40, () async {
                          try {
                            ProgressDialog pd =
                                ProgressDialog(context: Get.context);

                            pd.show(
                              max: 100,
                              msg: 'Please wait...',
                              progressBgColor: Colors.transparent,
                            );

                            Logger().i(_controller.task);

                            if (_controller.task.isEmpty) {
                              await _controller.registerTask(
                                  "", true, "client");
                            } else {
                              await _controller.registerTask(
                                  _controller.task["id"], false, "client");
                            }

                            pd.close();
                            final id = Get.parameters['id'];
                            Get.offAllNamed("/chat/$id");
                          } catch (e) {
                            Logger().e(e);
                          }

                          Get.back();
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
