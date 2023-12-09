import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:provitask_app/models/pending_request/pending_request.dart';
import 'package:provitask_app/services/preferences.dart';
import 'package:provitask_app/services/task_services.dart';

final logger = Logger();
final _prefs = Preferences();

class HomeProviderController extends GetxController {
  Position? _currentPosition;
  final _task = TaskServices();
  final locationAddress = Rx<String>('');

  final isLoading = false.obs;
  final user = _prefs.user;

  final mensualEarning = '556.60'.obs;

  final rateReliability = '90'.obs;

  final todayEarning = '12.50'.obs;
  final pendingRequest = <PendingRequest>[].obs;

  final PageController monthPageController = PageController(
    viewportFraction: 0.4,
    keepPage: true,
    initialPage: DateTime.now().month - 1,
  );
  final PageController dayPageController = PageController(
    viewportFraction: 0.2,
    keepPage: true,
    initialPage: (DateTime.now().day - 1),
  );

  final selectedMonth = DateTime.now().month.obs;
  final selectedDay = DateTime.now().day.obs;

  final filteredPendingRequests = <PendingRequest>[].obs;

  void onPageChanged(int index) {
    selectedMonth.value = (index + 1);
    filterPendingRequests(); // Filtrar las tareas al cambiar de mes
  }

  void onDayPageChanged(int index) {
    selectedDay.value = index + 1;

    filterPendingRequests(); // Filtrar las tareas al cambiar de día
  }

  void jumpToCurrentMonth() {
    monthPageController.jumpToPage(DateTime.now().month - 1);
    dayPageController.jumpToPage((DateTime.now().day - 1));
  }

  @override
  void onInit() async {
    super.onInit();
    _getCurrentLocation();
    getPendingTask();
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

  void filterPendingRequests() {
    filteredPendingRequests.value = pendingRequest.where((request) {
      final requestDate = DateTime.parse(request.fecha.toString());
      if (requestDate.day == selectedDay.value &&
          requestDate.month == selectedMonth.value &&
          requestDate.year == DateTime.now().year) {
        return true;
      } else {
        return false;
      }
    }).toList();
    // ordeno task por hora de menor a mayor
    filteredPendingRequests.sort((a, b) {
      final aDate = DateTime.parse(a.fecha.toString());
      final bDate = DateTime.parse(b.fecha.toString());
      return aDate.hour.compareTo(bDate.hour);
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

  getPendingTask() async {
    final response = await _task.getPendingTask();

    if (response["status"] != 200) {
      return;
    }

    // imprimo el tipo de dato que devuelve la consulta

    final data = response["data"];

    // vacio la lista de pendingRequest

    pendingRequest.clear();

    // ordeno por fecha y hora

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

    // ordeno por fecha y hora, ordennado hora de menor a mayor

    pendingRequest.sort((a, b) => a.fecha.compareTo(b.fecha));

    //imprimo tipo de dato de data
  }
}
