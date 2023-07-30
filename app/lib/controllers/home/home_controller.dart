import 'package:logger/logger.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:provitask_app/services/category_services.dart';
import 'package:provitask_app/services/task_services.dart';
import 'package:provitask_app/models/home/category_home_slider.dart';

final logger = Logger();

class HomeController extends GetxController {
  final _category = CategoryServices();

  final _task = TaskServices();
  Position? _currentPosition;
  final locationAddress = Rx<String>('');

  final isLoading = false.obs;

  final listCategory = <HomeCategory>[]
      .obs; // Declara listCategory como una lista vacía de objetos HomeCategory

  final listTask = [].obs;

  final popularTask = [].obs;

  final formKey = GlobalKey<FormState>();

  // saco de los widgets el widget categoryCard

  final searchController = Rx<TextEditingController>(TextEditingController());

  final categoryHomeSlider = <CategoryHomeSlider>[].obs;

  @override
  void onInit() async {
    super.onInit();
    Logger().i("HomeController");
    _getCurrentLocation();

    await Future.wait<void>([
      findCategory(),
      findTask(),
      _getPopularTask(),
      _getCategoryHomeSlider(),
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

  findCategory([int start = 0, int limit = 6, bool featured = false]) async {
    start = start * limit;

    final response = await _task.getItems(limit, start, false);

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

      listCategory.value = [];
    }

    Logger().i(response["data"]);

    final data = jsonDecode(response["data"].toString());

    listCategory.clear();

    data["data"].forEach((element) {
      listCategory.add(HomeCategory(
        id: element["id"],
        title: element["attributes"]["title"],
        image: element["attributes"]["image"],
        costaverage:
            double.parse(element["attributes"]["costaverage"].toString()),
        rating: double.parse(element["attributes"]["rating"].toString()),
      ));
    });
  }

  findTask([int start = 0, int limit = 6, bool featured = false]) async {
    start = start * limit;

    final response = await _task.getItems(limit, start, featured);

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

  _getCategoryHomeSlider() async {
    try {
      final response = await _category.getItemHomeSlider();

      if (response["status"] != 200) {
        return;
      }

      final data = response["data"]["data"];

      categoryHomeSlider.clear();

      data.forEach((element) {
        categoryHomeSlider.add(CategoryHomeSlider(
          id: element["id"].toString(),
          text: element["attributes"]["titulo"],
          image: element["attributes"]["media"] != null
              ? element["attributes"]["media"]["data"]["attributes"]["url"]
              : null,
          slug: element["attributes"]["skill"]["data"]["attributes"]["slug"],
        ));
      });
    } catch (e) {
      print(e);
    }
  }
}

class HomeCategory {
  final int id;
  final String slug;
  final String title;
  final String image;
  final double? costaverage;
  final double? rating;

  HomeCategory({
    required this.id,
    this.slug = '',
    required this.title,
    required this.image,
    this.costaverage = 0.0,
    this.rating = 0.0,
  });
}
