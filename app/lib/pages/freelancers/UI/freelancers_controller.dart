import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/services/freelances_services.dart';

class FreelancersController extends GetxController {
  final favoritesOrPreviously = Rx<int>(0);

  final freelancers = [].obs;

  final isLoading = false.obs;

  final conversation = ''.obs;

  final _freelances = FreelancesServices();

  @override
  void onInit() async {
    super.onInit();

    await getFreelancers();

    logger.i("FreelancersController onInit", freelancers);
  }

  getFreelancers() async {
    isLoading.value = true;
    var status = "";
    if (favoritesOrPreviously.value == 1) {
      status = "favorite";
    } else {
      status = "booked";
    }

    // llamo al metodo getItems de task services

    Map response = await _freelances.getItems(status);

    // si el status es 500 muestro un mensaje de error

    if (response["status"] != 200) {
      // paso a json el body del erro

      // muestro el mensaje de error en un snackbar en la parte inferior de la pantalla y fondo en rojo
      isLoading.value = false;

      Get.snackbar(
        "Error",
        response["error"]["message"],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      // lleno el listado de categorias con el resultado de la consulta

      freelancers.value = [];
      isLoading.value = false;

      return;
    }
    Logger().i(response);
    Logger().i(response["data"].data["data"]);

    freelancers.value = response["data"].data["data"];

    isLoading.value = false;
  }

  getConversation(freelancer) async {
    Map response = await _freelances.getConversation(freelancer);

    if (response["status"] != 200) {
      // paso a json el body del erro

      // muestro el mensaje de error en un snackbar en la parte inferior de la pantalla y fondo en rojo
      isLoading.value = false;

      Get.snackbar(
        "Error",
        response["error"]["message"],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      // lleno el listado de categorias con el resultado de la consulta

      freelancers.value = [];
      isLoading.value = false;

      return;
    }
    Logger().i(response["data"]);
    Logger().i(response["data"]["data"]);

    conversation.value = response["data"]["data"]['id'].toString();

    return conversation.value;
  }
}
