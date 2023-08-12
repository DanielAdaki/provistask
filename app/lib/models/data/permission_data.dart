import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class PermissionData {
  static Future<void> getPermissionUbication() async {
    LocationPermission permission = await Geolocator.checkPermission();
    Logger().i('Location permissions are denied', permission);
    if (permission == LocationPermission.denied) {
      Logger().i('Location permissions are denied');
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
  }
}
