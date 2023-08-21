import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/controllers/auth/auth_controller.dart';

class AuthMiddleware extends GetMiddleware {
  final AuthController authController = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (!authController.isAuthenticated.value) {
      // Si el usuario no está autenticado, redirige a la página de inicio de sesión
      return const RouteSettings(name: '/login');
    }
    // Deja que el usuario acceda a la ruta solicitada
    return null;
  }
}
