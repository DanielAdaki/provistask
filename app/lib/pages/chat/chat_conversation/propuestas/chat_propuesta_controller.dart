import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';

import 'package:provitask_app/services/message_services.dart';
import 'package:provitask_app/services/payment_services.dart';
import 'package:provitask_app/services/task_services.dart';

class ChatPropuestaController extends GetxController {
  /// Inputs
  final messageController = Rx<TextEditingController>(TextEditingController());

  final _services = MessageServices();

  final id = "".obs;

  final typePage = "".obs;

  final isLoading = false.obs;

  final _locationController = Get.put(LocationController());

  final _paymentServices = PaymentServices();
  final _task = TaskServices();

  final selectedSkill = "Bookshelf Assembly".obs;
  Rx<DateTime> selectedDay = Rx<DateTime>(DateTime.now());

  var selectedHour = "".obs;

  final arrayHours = [
    "I'm Flexible",
    "8:00am",
    "8:30am",
    "9:00am",
    "9:30am",
    "10:00am",
    "10:30am",
    "11:00am",
    "11:30am",
    "12:00pm",
    "12:30pm",
    "1:00pm",
    "1:30pm",
    "2:00pm",
    "2:30pm",
    "3:00pm",
    "3:30pm",
    "4:00pm",
    "4:30pm",
    "5:00pm",
    "5:30pm",
    "6:00pm",
    "6:30pm",
    "7:00pm",
    "7:30pm",
    "8:00pm",
    "8:30pm",
    "9:00pm",
    "9:30pm"
  ];

  var totalMount = RxDouble(0);

  final isFinalPrice = false.obs;

  final isAddDetails = false.obs;

  final carTask = RxInt(4);
  final dateTask = RxInt(1);
  final timeTask = RxInt(1);
  final hourTask = RxInt(1);

  final listSkills = [].obs;

  final locationTask = Rx<TextEditingController>(TextEditingController());
  final descriptionTask = Rx<TextEditingController>(TextEditingController());
  final reviewCardTask = Rx<TextEditingController>(TextEditingController());

  final lengthTask = RxString('');

  final user = {}.obs;

  final task = {}.obs;

  final netoPrice = Rx<TextEditingController>(TextEditingController());

  final brutePrice = Rx<TextEditingController>(TextEditingController());

  final descriptionProvis = Rx<TextEditingController>(TextEditingController());

  final finalPrice = Rx<TextEditingController>(TextEditingController());

  @override
  void onInit() async {
    // destruyo el controlador ChatPropuestaController si existe uno

    isLoading.value = true;

    // tomo el id de la conversacion que viene en la ruta como parametros

    id.value = Get.parameters['id'] ?? '';

    // obtengo la query de nombre type

    typePage.value = Get.parameters['type'] ?? '';

    await getTaskConversation();

    isLoading.value = false;
    super.onInit();
  }

  getTaskConversation() async {
    Map<String, dynamic> datos =
        await _services.getTaskChat(Get.parameters['id']);

    if (datos["status"] != 200) {
      // muestro un snackbar con el error en la parte de abajo

      Get.snackbar("Error",
          "Hubo un error al recuperar la tarea asociada a la conversación",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);

      return;
    }

    task.value = datos["data"];

    if (task.isEmpty) {
      return;
    }

    Logger().i(task);

    //  locationTask.value.text = task["location"]["address"];
    descriptionTask.value.text = task["description"] ?? '';

    if (task["transportation"] == "motorcycle") {
      carTask.value = 1;
    } else if (task["transportation"] == "car") {
      carTask.value = 2;
    } else if (task["transportation"] == "truck") {
      carTask.value = 3;
    } else {
      carTask.value = 4;
    }

    final time = task["time"];

    // está en formato 11:30:00.000 lo llevo a 11:30am o 11:30pm

    if (time == "I'm Flexible") {
      selectedHour.value = time;
    } else {
      final hour = time.substring(0, 2);
      final minutes = time.substring(3, 5);

      final hourInt = int.parse(hour);

      if (hourInt > 12) {
        selectedHour.value = "${hourInt - 12}:$minutes" "pm";
      } else {
        selectedHour.value = "$hour:$minutes" "am";
      }
    }

// selectedHour.value = time;

    final fecha = task["datetime"];

    // convierto de string a datetime

    final date = DateTime.parse(fecha);

    selectedDay.value = date;

    lengthTask.value = task["taskLength"];

    descriptionProvis.value.text = task["descriptionProvis"] ?? '';

    /* creo un LatLng  */

    LatLng location =
        LatLng(task["location"]["latitud"], task["location"]["longitud"]);

    _locationController.updateSelectedLocation(location);

    _locationController.getAddressFromLatLng();

    brutePrice.value.text = task["brutePrice"] ?? '';

    netoPrice.value.text = task["netoPrice"] ?? '';

    selectedSkill.value = task["skill"]["name"];

    finalPrice.value.text = task["totalPrice"] ?? '';

    isAddDetails.value = task["addDetails"];

    isFinalPrice.value = task["addFinalPrice"];

    // obtengo las skills
  }

  registerTask(
      [id, newTask = false, createType = 'client', status = "request"]) async {
    /* creo un objeto con los datos de la tarea, pero previamente reviso estén llenos.*/

    final location = _locationController.selectedLocation;

    final locationGeo = _locationController.selectedAddress;

    final length = lengthTask.value;

    final car = carTask.value;

    final date = selectedDay.value;

    final time = selectedHour.value;

    final description = descriptionTask.value.text;

    if (location != null &&
        locationGeo != "" &&
        length != "" &&
        date != "" &&
        time != "") {
      // si estan llenos, creo el objeto

      //  convierto location en un map de lat y lng

      final locationMap = {
        "lat": location.latitude,
        "lng": location.longitude,
      };

      Logger().i(Get.parameters['id']);

      final task = {
        "location": locationMap,
        "location_geo": locationGeo,
        "length": length,
        "date": date.toString(),
        "time": time.toString(),
        "car": car,
        "description": description,
        //"paymentIntentId": paymentId,
        "status": status,
        "descriptionProvis": descriptionProvis.value.text,
        "brutePrice": brutePrice.value.text,
        "netoPrice": netoPrice.value.text,
        "conversation": Get.parameters['id'],
        "addDetails": isAddDetails.value,
        "addFinalPrice": isFinalPrice.value,
        "finalPrice": finalPrice.value.text,
        "skill": selectedSkill.value,
        "createType": createType
      };

      //añado task a un objeto data

      final data = {"data": task};
      dynamic response = "";
      if (newTask == true) {
        response = await _task.createTask(data);
      } else {
        response = await _task.editTask(id.toInt(), data);
      }

      if (response["status"] == 200) {
        return response["data"];
      } else {
        Get.snackbar(
          'Error!',
          'Error creating task',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'Error!',
        'Please fill all the fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    //
  }
}
