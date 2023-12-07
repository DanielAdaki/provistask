import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provitask_app/controllers/location/gps_controller.dart';

class GpsPermisessMiddleware extends GetMiddleware {
  static bool _isRequestingPermissions = false;
  final gpsController = Get.find<GpsController>();

  @override
  RouteSettings? redirect(String? route) {
    if (!_isRequestingPermissions) {
      _requestPermissions();
    }

    // verifico el status del permiso de ubicacion
    if (!gpsController.isAllGranted) {
      // Si el usuario no está autenticado, redirige a la página de inicio de sesión
      return const RouteSettings(name: '/gps-access');
    }

    return null;
  }

  Future<bool> verifyPermissionUbication() async {
    if (await Permission.location.isDenied) {
      // Si el usuario no está autenticado, redirige a la página de inicio de sesión
      return false;
    }
    return true;
  }

  void _requestPermissions() async {
    _isRequestingPermissions = true;
    try {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.location,
        Permission.storage,
      ].request();

      // Verificar si todos los permisos fueron concedidos

      /* if (statuses[Permission.location]!.isDenied) {
        Get.snackbar(
          'Error',
          'No se concedió el permiso de ubicación',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        // lo envio a la pagina de gps
      }

      if (statuses[Permission.camera]!.isDenied) {
        Get.snackbar(
          'Error',
          'No se concedió el permiso de cámara',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      if (statuses[Permission.storage]!.isDenied) {
        Get.snackbar(
          'Error',
          'No se concedió el permiso de almacenamiento',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }*/
    } catch (e) {
      // Manejar la excepción
      print('Error al solicitar permisos: $e');

      // verifico si rechazó permiso de ubicación
    } finally {
      _isRequestingPermissions = false;
    }
  }
}
