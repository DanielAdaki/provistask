import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';
import 'package:provitask_app/models/provider/provider_model.dart';
import 'package:provitask_app/services/freelances_services.dart';
import 'package:provitask_app/services/task_services.dart';

class FreelancersController extends GetxController {
  final favoritesOrPreviously = Rx<int>(0);
  final _locationController = Get.find<LocationController>();
  final _task = TaskServices();

  final freelancers = <Provider>[].obs;

  final isLoading = false.obs;

  final conversation = ''.obs;
  dynamic perfilProvider = {}.obs;
  final _freelances = FreelancesServices();

  @override
  void onInit() async {
    super.onInit();

    await getFreelancers();
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

    final data = jsonDecode(response["data"].toString());

    freelancers.clear();

    data["data"].forEach((json) {
      freelancers.add(Provider(
        id: json['id'],
        isProvider: json['isProvider'],
        name: json['name'],
        lastname: json['lastname'],
        averageScore: json['averageScore'].toDouble(),
        averageCount: json['averageCount'],
        typeProvider: json['type_provider'],
        description: json['description'],
        motorcycle: json['motorcycle'],
        car: json['car'],
        truck: json['truck'],
        openDisponibility: json['open_disponibility'],
        closeDisponibility: json['close_disponibility'],
        avatarImage: json['avatar_image'],
        skillSelect: json['skill_select'],
        allSkills: ProviderSkill.map(json['provider_skills']),
        distanceLineal: json['distanceLineal'] != null
            ? json['distanceLineal'].toDouble()
            : 0,
        online: OnlineStatus.fromJson(json['online']),
      ));
    });

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

  getPerfilProvider(int id, [bool sendLocation = false, int? skill]) async {
    if (id == 0) {
      return;
    }
    var response = {};
    if (sendLocation) {
      response = await _task.getProvider(
          id,
          _locationController.selectedLocation?.latitude,
          _locationController.selectedLocation?.longitude,
          skill);
    } else {
      response = await _task.getProvider(id, false, false, skill);
    }

    // si el status es 500 muestro un mensaje de error

    if (response["status"] != 200) {
      // lleno el listado de categorias con el resultado de la consulta

      perfilProvider.value = {};

      return false;
    }

    perfilProvider.value = response["data"]["proveedor"];

    // lleno el listado de categorias con el resultado de la consulta
  }
}
