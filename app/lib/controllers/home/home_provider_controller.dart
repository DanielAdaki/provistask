import 'package:logger/logger.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provitask_app/services/preferences.dart';

final logger = Logger();
final _prefs = Preferences();

class HomeProviderController extends GetxController {
  Position? _currentPosition;
  final locationAddress = Rx<String>('');

  final isLoading = false.obs;
  final user = _prefs.user;

  final mensualEarning = '556.60'.obs;

  final rateReliability = '90'.obs;

  final todayEarning = '12.50'.obs;

  // saco de los widgets el widget categoryCard

  @override
  void onInit() async {
    super.onInit();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      _currentPosition = position;
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      locationAddress.value = place.locality!;
    } catch (e) {
      logger.e(e);
    }
  }
}
