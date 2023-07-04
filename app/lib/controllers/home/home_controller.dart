import 'package:logger/logger.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:provitask_app/services/category_services.dart';
import 'package:provitask_app/services/task_services.dart';

final logger = Logger();
final _category = CategoryServices();

final _task = TaskServices();

class HomeController extends GetxController {
  Position? _currentPosition;
  final locationAddress = Rx<String>('');

  final isLoading = false.obs;

  final listCategory = [].obs;

  final listTask = [].obs;

  final popularTask = [].obs;

  final formKey = GlobalKey<FormState>();

  // saco de los widgets el widget categoryCard

  final searchController = Rx<TextEditingController>(TextEditingController());

  @override
  void onInit() async {
    super.onInit();
    _getCurrentLocation();
    await Future.wait<void>([
      _findCategory(),
      _findTask(),
      _getPopularTask(),
    ]);

    // await listaCategorias();
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      _currentPosition = position;
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _findCategory() async {
    final response = await _category.getItems(searchController.value.text);

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

      listCategory.value = [];
    }

    // imprimo el tipo de dato que devuelve la consulta

    // chago cast a json el body de la respuesta

    final data = jsonDecode(response["data"].toString());

    //imprimo tipo de dato de data

    listCategory.value = data["data"];
  }

  _findTask() async {
    final response = await _task.getItems(searchController.value.text);

    // si el status es 500 muestro un mensaje de error

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

      // lleno el listado de categorias con el resultado de la consulta

      listTask.value = [];
    }

    // imprimo el tipo de dato que devuelve la consulta

    // chago cast a json el body de la respuesta

    final data = jsonDecode(response["data"].toString());

    //imprimo tipo de dato de data

    listTask.value = data["data"];
  }

  _getPopularTask() async {
    final response = await _task.getPopularItems();

    // si el status es 500 muestro un mensaje de error

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

      // lleno el listado de categorias con el resultado de la consulta

      popularTask.value = [];
    }

    // imprimo el tipo de dato que devuelve la consulta

    // chago cast a json el body de la respuesta

    final data = jsonDecode(response["data"].toString());

    //imprimo tipo de dato de data

    popularTask.value = data["data"];
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      locationAddress.value = place.locality!;
    } catch (e) {
      print(e);
    }
  }
}
