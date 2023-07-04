import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:provitask_app/services/category_services.dart';

final _category = CategoryServices();

class CategoryController extends GetxController {
  // muestro el loading

  final isLoading = false.obs;

  final listCategory = [].obs;

  final formKey = GlobalKey<FormState>();

  final categoryController = RxInt(0);

  /// inputs de query search

  final searchController = Rx<TextEditingController>(TextEditingController());

  findCategory() async {
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

  @override
  onInit() async {
    super.onInit();
    await findCategory();
  }
}
