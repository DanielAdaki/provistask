// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// importo conexion common para poder usar la url base de la api

import 'package:provitask_app/common/conexion_common.dart';

// importo el controlador de categoria para poder usarlo en el widget

import 'package:provitask_app/controllers/category/category_controller.dart';
import 'package:provitask_app/services/auth_services.dart';

class Categories {
  // instancio el controlador de categoria con getx
  //
  final _categoryController = Get.put(CategoryController());

  RxList<Widget> listCategory = (List<Widget>.of([])).obs;

  // de controler saco la lista de categorias

  Widget categoryCard(String title, String image) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: const Color(0xFF170591),
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //añado un espacio entre la imagen y el texto

          children: [
            Image.network(
              image,
              width: 50,
              height: 50,
            ),

            // añado un espacio entre la imagen y el texto

            const SizedBox(height: 10),

            Text(
              title,
              //centro el texto
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF170591),
              ),
            ),
            // una imagen de prueba y un texto
          ],
        ),
      ),
    );
  }

  Widget textCategories() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Text(
        'What else do you need?',
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.amber[800]),
      ),
    );
  }

  // consulto las categorias y las muestro en el widget

  listaCategorias() {
    final List<Widget> lista = [];

    for (final element in _categoryController.listCategory) {
      final dato = element["attributes"];
      var imagen = dato["image"]["data"]["attributes"]["url"];
      final title = dato["title"];

      imagen = ConexionCommon.hostBase + imagen;

      logger.i(imagen);

      lista.add(categoryCard(title, imagen));
    }

    // uso el controlador para obtener la lista de categorias usando getx

    // retorno ucategoriesList

    // añado a listCategory

    listCategory.value = lista;

    logger.i(listCategory);
  }
}
