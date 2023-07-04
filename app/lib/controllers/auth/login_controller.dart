import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/common/socket.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';

// impotyo auth service

import 'package:provitask_app/services/auth_services.dart';

class LoginController extends GetxController {
  // muestro el loading

  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  final loginController = RxInt(0);

  /// inputs
  final emailController = Rx<TextEditingController>(TextEditingController());
  final passwordController = Rx<TextEditingController>(TextEditingController());

  void login() async {
    // valido el formulario

    // if (!formKey.currentState.validate()) return;

    // muestro el loading

    isLoading.value = true;

    // llamo al servicio de login

    final auth = AuthService();

    final response = await auth.login(
        emailController.value.text, passwordController.value.text);

    // si el status es 500 muestro un mensaje de error

    if (response["status"] != 200) {
      // paso a json el body del error

      logger.e(response["error"]);

      // muestro el mensaje de error en un snackbar en la parte inferior de la pantalla y fondo en rojo

      if (response["error"] == "Connection timed out") {
        Get.snackbar("Error de conexion", "No se pudo conectar con el servidor",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            // subo un poco el snackbar

            margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20));
        await Future.delayed(const Duration(seconds: 2));
        isLoading.value = false;

        return;
      } else {
        Get.snackbar(response["error"]["error"]["name"],
            response["error"]["error"]["message"],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            // subo un poco el snackbar

            margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20));
        await Future.delayed(const Duration(seconds: 2));
        isLoading.value = false;

        return;
      }
    }

    var user = await auth.me();

    Get.find<SocketController>();

    Get.find<LocationController>();

    Get.snackbar(
        "Bienvenido", "Hola ${user["data"]["name"]} bienvenido a provitask ",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        // subo un poco el snackbar

        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20));

    // navego a la pagina de inicio luego que se muestre el snackbar

    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;
    Get.offAllNamed("/home");
  }

  loginForgottPassword() {}
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
