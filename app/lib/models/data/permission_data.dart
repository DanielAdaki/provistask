import 'package:geolocator/geolocator.dart';

class PermissionData {
  static LocationPermission? permission;
  // Get permission Location status
  static void getPermissionUbication() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
  }
}
