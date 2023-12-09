import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/models/pagination/pagination_model.dart';
import 'package:provitask_app/models/tasks/task_aproved_detaill_model.dart';
// importo task services

import 'package:provitask_app/services/task_services.dart';
import 'package:provitask_app/models/tasks/task_approced_model.dart';

class TasksController extends GetxController {
  final programmedOrCompleted = Rx<int>(1);

  ScrollController scrollController = ScrollController();

  final tasks = RxList<TaskData>([]);

  final isLoading = false.obs;

  dynamic task = "".obs;

  final pagination = Pagination().obs;

  // instancio task services

  final _task = TaskServices();

  int currentPage = 1;
  int itemsPerPage = 5;

  getTasks([bool loading = true]) async {
    if (loading) {
      isLoading.value = true;
    }

    var status = "";
    if (programmedOrCompleted.value == 1) {
      status = "acepted";
    } else if (programmedOrCompleted.value == 2) {
      status = "canceled";
    } else {
      status = "completed";
    }

    Logger().i("status: $status");

    // llamo al metodo getItems de task services

    final response = await _task.meTask(status, currentPage, itemsPerPage);

    // si el status es 500 muestro un mensaje de error

    if (response["status"] != 200) {
      // paso a json el body del erro

      // muestro el mensaje de error en un snackbar en la parte inferior de la pantalla y fondo en rojo
      //currentPage.value = 0;
      tasks.clear();
      if (loading) {
        isLoading.value = false;
      }

      return;
    }

    // lleno el listado de categorias con el resultado de la consulta

    if (loading == true) {
      tasks.clear();
    }
    // añaado los items al listado de tasks
    List<TaskData> tpm = response["data"]["data"]
        .map<TaskData>((item) => TaskData.fromJson(item))
        .toList();

    tasks.addAll(tpm);

    pagination.value =
        Pagination.fromJson(response["data"]["meta"]["pagination"]);
    currentPage = pagination.value.page;
    if (loading) {
      isLoading.value = false;
    }
  }

  getTask(int id, [provider = false]) async {
    isLoading.value = true;
    final response = await _task.taskDetail(id, provider);

    if (response["status"] != 200) {
      isLoading.value = false;

      return;
    }

    task = TaskApprovalDetail.fromJson(response["data"]);

    isLoading.value = false;
  }

  void loadMoreTasks() {
    if (currentPage == pagination.value.lastPage) {
      return;
    }

    currentPage = pagination.value.page + 1;

    getTasks(false);
  }

  @override
  void onInit() async {
    await getTasks();

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
