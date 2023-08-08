import 'package:flutter/material.dart';
import 'package:get/get.dart';
// importo task services

import 'package:provitask_app/services/task_services.dart';

class TasksController extends GetxController {
  final programmedOrCompleted = Rx<int>(1);

  // array de tareas

  final tasks = [].obs;

  final isLoading = false.obs;

  // instancio task services

  final _task = TaskServices();

  getTasks() async {
    isLoading.value = true;
    var status = "";
    if (programmedOrCompleted.value == 1) {
      status = "acepted";
    } else {
      status = "completed";
    }

    // llamo al metodo getItems de task services

    final response = await _task.meTask(status);

    // si el status es 500 muestro un mensaje de error

    if (response["status"] != 200) {
      // paso a json el body del erro

      // muestro el mensaje de error en un snackbar en la parte inferior de la pantalla y fondo en rojo
      isLoading.value = false;

      tasks.value = [];
      isLoading.value = false;

      return;
    }

    tasks.value = response["data"]["data"];

    isLoading.value = false;
  }

  @override
  void onInit() async {
    isLoading.value = true;
    await getTasks();
    isLoading.value = false;
    super.onInit();
  }

  finishTask(item) async {
    // llamo el metodo finishTask de task services usando async await

    final response = await _task.finishTask(item);

    // si el status es 500 muestro un mensaje de error

    if (response["status"] != 200) {
      // paso a json el body del erro

      Get.snackbar(
        "Error",
        "Error al finalizar la tarea",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      // lleno el listado de categorias con el resultado de la consulta

      return;
    }
  }
}
