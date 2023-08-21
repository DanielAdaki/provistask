import 'package:logger/logger.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provitask_app/common/constans.dart';
import 'package:provitask_app/models/home/home_category_model.dart';
import 'package:provitask_app/models/provider/provider_model.dart';
import 'package:provitask_app/models/user/provider_skill.dart';

import 'package:provitask_app/services/category_services.dart';
import 'package:provitask_app/services/task_services.dart';
import 'package:provitask_app/models/home/category_home_slider.dart';

final logger = Logger();

class HomeController extends GetxController {
  // busco el controlador de localizacion

  final _category = CategoryServices();

  final _task = TaskServices();
  Position? currentPosition;
  final locationAddress = Rx<String>('');

  final isLoading = false.obs;

  final listCategory = <HomeCategory>[]
      .obs; // Declara listCategory como una lista vacía de objetos HomeCategory
  final listTask = <HomeCategory>[].obs;

  final popularProvider = <Provider>[].obs;

  final formKey = GlobalKey<FormState>();

  final loadingSearch = false.obs;

  final searchController = Rx<TextEditingController>(TextEditingController());

  final categoryHomeSlider = <CategoryHomeSlider>[].obs;

  var searchText = ''.obs;
  final suggestions = <Map>[].obs;
  void onTextChanged(String text) async {
    await getSuggestions(text);
  }

  Future getSuggestions(String text) async {
    loadingSearch.value = true;
    final response = await _category.getItems(text);

    // si el status es 500 muestro un mensaje de error

    if (response["status"] != 200) {
      // paso a json el body del erro

      // muestro el mensaje de error en un snackbar en la parte inferior de la pantalla y fondo en rojo
      isLoading.value = false;

      print(
          "error en la consulta de categorias en la funcion findCategory del controlador home_controller.dart");

      suggestions.clear();

      loadingSearch.value = false;

      return;
    }

    final data = jsonDecode(response["data"].toString());

    suggestions.clear();

    data["data"].forEach((element) {
      // añado nombre y id a la lista de sugerencias como un map

      suggestions
          .add({"name": element["attributes"]["name"], "id": element["id"]});
    });

    loadingSearch.value = false;
  }

  @override
  void onInit() async {
    isLoading.value = true;
    await getCurrentLocation();

    await Future.wait<void>([
      findCategory(),
      findTask(),
      _getCategoryHomeSlider(),
    ]);

    await getPopularProvider();

    // await listaCategorias();
    isLoading.value = false;
    super.onInit();
  }

  getCurrentLocation() {
    Logger().i("getCurrentLocation");
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      Logger().i(position);
      currentPosition = position;
      _getAddressFromLatLng();
    }).catchError((e) {
      Logger().e(e, "aui");
      // mando a la pantalla de permiso de localizacion

      Get.toNamed("/gps-access");
    });
  }

  findCategory([int start = 0, int limit = 10, bool featured = false]) async {
    start = start * limit;

    final response = await _task.getItems(limit, start, false);

    // si el status es 500 muestro un mensaje de error

    if (response["status"] != 200) {
      // paso a json el body del erro

      // muestro el mensaje de error en un snackbar en la parte inferior de la pantalla y fondo en rojo
      isLoading.value = false;

      print(
          "error en la consulta de categorias en la funcion findCategory del controlador home_controller.dart");

      listCategory.value = [];
    }

    final data = jsonDecode(response["data"].toString());

    listCategory.clear();

    data["data"].forEach((element) {
      listCategory.add(HomeCategory(
          id: element["id"],
          title: element["attributes"]["title"],
          image: element["attributes"]["image"],
          costAverage: element["attributes"]["costAverage"].toDouble(),
          rating: element["attributes"]["rating"].toDouble(),
          countPurchase: element["attributes"]["countPurchase"],
          description: element["attributes"]["description"],
          categoryId: element["attributes"]["categoria"]["id"]));
    });
  }

  findTask([int start = 0, int limit = 20, bool featured = true]) async {
    start = start * limit;

    final response = await _task.getItems(limit, start, featured);

    // si el status es 500 muestro un mensaje de error

    if (response["status"] != 200) {
      // paso a json el body del erro

      // muestro el mensaje de error en un snackbar en la parte inferior de la pantalla y fondo en rojo
      // isLoading.value = false;
      print(
          "error en la consulta de tareas en la funcion findTask del controlador home_controller.dart");
      // lleno el listado de categorias con el resultado de la consulta

      listTask.value = [];
    }

    final data = jsonDecode(response["data"].toString());

    listTask.clear();

    data["data"].forEach((element) {
      listTask.add(HomeCategory(
          id: element["id"],
          title: element["attributes"]["title"],
          image: element["attributes"]["image"],
          costAverage: element["attributes"]["costAverage"].toDouble(),
          rating: element["attributes"]["rating"].toDouble(),
          countPurchase: element["attributes"]["countPurchase"],
          description: element["attributes"]["description"],
          categoryId: element["attributes"]["categoria"]["id"]));
    });
  }

  getPopularProvider() async {
    if (currentPosition == null) {
      popularProvider.clear();
      return;
    }
    final response = await _task.getPopularItems(currentPosition!.latitude,
        currentPosition!.longitude, Constants.distance);

    // si el status es 500 muestro un mensaje de error

    if (response["status"] != 200) {
      Logger().e(
          "error en la consulta de proveedores en la funcion getPopularProvider del controlador home_controller.dart");

      popularProvider.clear();
    }

    final data = jsonDecode(response["data"].toString());

    popularProvider.clear();

    data["data"].forEach((json) {
      popularProvider.add(Provider(
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
        distanceLineal: json['distanceLineal'].toDouble(),
        online: OnlineStatus.fromJson(json['online']),
      ));
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition!.latitude, currentPosition!.longitude);

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
