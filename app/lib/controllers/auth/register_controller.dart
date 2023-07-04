import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:provitask_app/services/auth_services.dart';

// creo clase de controlador de registro

class RegisterController extends GetxController {
  // creo variable de tipo Auth para poder usar los servicios de autenticacion
  final AuthService _auth = AuthService();

// los campos de mi formulario son name, email, password, password_confirmatio, surname, postal_code, phone_number

  // genero los campos de mi formulario

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController passwordConfirmationController =
      TextEditingController();

  final TextEditingController surnameController = TextEditingController();

  final TextEditingController postalCodeController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

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

  // creo variable para mostrar el mensaje de bienvenida

  final formKey = GlobalKey<FormState>();

  // creo variable para mostrar el mensaje de bienvenida

  final loginController = RxInt(0);

  // creo metodo para registrar un usuario

  void register() async {
    // valido el formulario

    if (!formKey.currentState!.validate()) return;

    // muestro el loading

    isLoading.value = true;

    // llamo al servicio de registro

    var response = await _auth.register(
        nameController.text,
        emailController.text,
        passwordController.text,
        passwordConfirmationController.text,
        surnameController.text,
        postalCodeController.text);

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
    }

    // si el status es 200 muestro un mensaje de bienvenida

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

    // oculto el loading

    isLoading.value = false;
  }
}
