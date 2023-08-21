import 'package:get/get.dart';

class AuthController extends GetxController {
  var isAuthenticated = false.obs;

  void checkAuthStatus() {
    // Lógica para verificar si el usuario está autenticado
    // Actualiza el valor de isAuthenticated basado en el estado de autenticación
  }

  void login() {
    // Lógica para iniciar sesión
    isAuthenticated.value = true;
  }

  void logout() {
    // Lógica para cerrar sesión
    isAuthenticated.value = false;
  }
}
