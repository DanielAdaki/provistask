import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/common/socket.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';
import 'package:provitask_app/models/data/countries_data.dart';

import 'package:provitask_app/services/auth_services.dart';
import 'package:provitask_app/services/preferences.dart';
// creo clase de controlador de registro

class RegisterController extends GetxController {
  // creo variable de tipo Auth para poder usar los servicios de autenticacion
  final AuthService _auth = AuthService();
  final prefs = Preferences();
// los campos de mi formulario son name, email, password, password_confirmatio, surname, postal_code, phone_number

  // genero los campos de mi formulario

  RxString phoneCodeRegister = ''.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = Rx<TextEditingController>(TextEditingController());
  final surnameController = Rx<TextEditingController>(TextEditingController());
  final emailController = Rx<TextEditingController>(TextEditingController());
  final passwordController = Rx<TextEditingController>(TextEditingController());
  final confirmPasswordController =
      Rx<TextEditingController>(TextEditingController());
  final phoneController = Rx<TextEditingController>(TextEditingController());
  final postalCodeController =
      Rx<TextEditingController>(TextEditingController());
  RxList<CountryPhoneCode>? phoneCodes = <CountryPhoneCode>[].obs;

  // creo variable para mostrar el loading

  final isLoading = false.obs;

  // creo variable para mostrar el error

  final error = false.obs;

  // creo variable para mostrar el mensaje de error

  final message = "".obs;

  // creo variable para mostrar el mensaje de bienvenida

  final welcome = "".obs;

  // creo variable para mostrar el mensaje de bienvenida

  final success = false.obs;

  final loginController = RxInt(0);

  // creo metodo para registrar un usuario

  register() async {
    // valido el formulario

    if (!formKey.currentState!.validate()) return;

    // muestro el loading

    isLoading.value = true;

    // llamo al servicio de registro

    final response = await _auth.register(
        nameController.value.text,
        emailController.value.text,
        passwordController.value.text,
        surnameController.value.text,
        postalCodeController.value.text,
        phoneController.value.text);

    // si el status es 500 muestro un mensaje de error

    if (response["status"] == 500) {
      // muestro el mensaje de error en un snackbar en la parte inferior de la pantalla y fondo en rojo

      Get.snackbar("Error", response["message"],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          // subo un poco el snackbar

          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20));
      await Future.delayed(const Duration(seconds: 2));

      return;
    }

    isLoading.value = false;

    if (response["status"] == 200) {
      // muestro el mensaje de bienvenida en un snackbar en la parte inferior de la pantalla y fondo en verde

      Get.snackbar("Bienvenido", "Has registrado un usuario correctamente",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          // subo un poco el snackbar

          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20));
      await Future.delayed(const Duration(seconds: 2));
    }
  }
}
