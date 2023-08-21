import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class GpsController extends GetxController {
  var isGpsEnabled = false.obs;
  var isGpsPermissionGranted = false.obs;

  bool get isAllGranted => isGpsEnabled.value && isGpsPermissionGranted.value;

  GpsController() {
    _init();
  }
  setGpsEnableAndPermission({bool? gpsEnable, bool? gpsPermission}) {
    isGpsEnabled.value = gpsEnable ?? isGpsEnabled.value;
    isGpsPermissionGranted.value =
        gpsPermission ?? isGpsPermissionGranted.value;

    if (isAllGranted) {
      // si el usuario es de tipo cliente lo envio a la pantalla de home

      Get.offNamed('/home');
    }
  }

  Future<void> _init() async {
    final gpsInitStatus =
        await Future.wait([_checkGpsStatus(), _isPermissionGrantes()]);

    isGpsEnabled.value = gpsInitStatus[0];
    isGpsPermissionGranted.value = gpsInitStatus[1];
    //setGpsEnableAndPermission(gpsEnable: isEnable);
  }

  Future<bool> _isPermissionGrantes() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();

    Geolocator.getServiceStatusStream().listen((event) async {
      final isEnable = (event.index == 1) ? true : false;
      setGpsEnableAndPermission(gpsEnable: isEnable);
      isGpsPermissionGranted.value = await _isPermissionGrantes();
    });
    return isEnable;
  }

  Future<void> askGpsAcces() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        setGpsEnableAndPermission(gpsPermission: true);
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        setGpsEnableAndPermission(gpsPermission: false);
        openAppSettings();
        break;
      case PermissionStatus.provisional:
        break;
    }
  }

  // todo investigar cierre de getcontroller para optimizar memoria
}
