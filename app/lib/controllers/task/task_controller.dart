import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';

import 'package:provitask_app/services/task_services.dart';

class TaskController extends GetxController {
  final _task = TaskServices();
  //LocationController locationController;

  final locationController = Get.find<LocationController>();

  final formKey = GlobalKey<FormState>();

  final taskController = RxInt(0);

  final listTask = [].obs;

  final taskDetail = {}.obs;

  final provider = {}.obs;

  final idTask = "".obs;

  final isLoading = false.obs;

  _getTask() async {
    final response = await _task.getItem(
      idTask.value,
      locationController.currentLocartion.value?.latitude,
      locationController.currentLocartion.value?.longitude,
    );

    if (response["status"] != 200) {
      // paso a json el body del erro

      // muestro el mensaje de error en un snackbar en la parte inferior de la pantalla y fondo en rojo
      // isLoading.value = false;

      Get.snackbar(
        "Error",
        response["error"]["message"],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      taskDetail.value = {};
    }

    // imprimo el tipo de dato que devuelve la consulta

    // chago cast a json el body de la respuesta

    final data = response["data"];

    //imprimo tipo de dato de data

    taskDetail.value = data["data"];

    provider.value = taskDetail["attributes"]["provider"];
  }

  @override
  onInit() async {
    super.onInit();

    isLoading.value = true;

    // tomo el id de la categoria que viene por parametro

    idTask.value = Get.parameters['id'] ?? "";

    // si es vacio redirecciono a la pagina del home

    if (idTask.value == "") {
      Get.offNamed("/home");
    }

    await _getTask();
    logger.i(provider);
    isLoading.value = false;
  }

  generarChat(id) async {
    final response = await _task.generarChat(id);

    if (response["status"] != 200) {
      // paso a json el body del erro

      // muestro el mensaje de error en un snackbar en la parte inferior de la pantalla y fondo en rojo
      // isLoading.value = false;

      Get.snackbar(
        "Error",
        response["error"]["message"],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }

    // imprimo el tipo de dato que devuelve la consulta

    final data = response["data"];

    Get.toNamed("/chat/$data");

    //imprimo tipo de dato de data
  }
}
