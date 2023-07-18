import 'package:logger/logger.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provitask_app/services/preferences.dart';
import 'package:provitask_app/services/task_services.dart';
import 'package:provitask_app/models/pending_request/pending_request.dart';

final logger = Logger();
final _prefs = Preferences();

class PendingPageController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    // _getCurrentLocation();
    await getPendingTask();
  }

  final _task = TaskServices();
  Position? _currentPosition;
  final locationAddress = Rx<String>('');

  final isLoading = false.obs;
  final user = _prefs.user;

  final pendingRequest = <PendingRequest>[].obs;

  final mensualEarning = '556.60'.obs;

  final rateReliability = '90'.obs;

  final todayEarning = '12.50'.obs;

  // saco de los widgets el widget categoryCard

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

  // consulto las pending request

  getPendingTask() async {
    final response = await _task.getPendingTask();

    if (response["status"] != 200) {
      return;
    }

    // imprimo el tipo de dato que devuelve la consulta

    final data = response["data"];

    Logger().i(data);

    // recorro el array de datos y los convierto en objetos de tipo PendingRequest

    data.forEach((element) {
      pendingRequest.add(PendingRequest(
        id: element["id"],
        monto: element["monto"],
        fecha: DateTime.parse(element["datetime"]),
        categoria: element["categoria"],
        cliente: element["cliente"],
        nombre: element["nombre"],
        description: element["description"] ?? "",
      ));
    });

    //imprimo tipo de dato de data
  }
}
