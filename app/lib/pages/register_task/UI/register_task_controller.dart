import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';
import 'package:provitask_app/services/task_services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:provitask_app/services/provider_services.dart';
import 'package:provitask_app/services/payment_services.dart';

class RegisterTaskController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await getSkills();
    Logger().d(listSkills);
  }

  final currentState = GlobalKey<FormState>();

  final _locationController = Get.find<LocationController>();
  final _services = ProviderRegisterServices();
  final _paymentServices = PaymentServices();
  final _task = TaskServices();

  final form1Controller = RxInt(1);
  // usada por daniel
  final formStepOne = RxDouble(0.25);
  final formStepTwo = RxDouble(1);
  final formStepThree = RxDouble(1);
  final formStepFour = RxDouble(1);

  final isLoading = false.obs;

  final selectedSkill = "1".obs;
  final listProviders = RxList([]);
  final lengthTask = RxString('');

  RxMap<String, dynamic> filters = {
    "date": "".obs,
    "time": "".obs,
    "price": "".obs,
    "provider_type": "".obs,
    "sortBy": "Distance".obs,
    "hour": "".obs,
    "day": "".obs,
    "skill": "1".obs,
  }.obs;

  final idProvider = RxInt(0);

  dynamic infoProvider = {}.obs;

  dynamic perfilProvider = {}.obs;

  RxList events = [].obs;

  Rx<DateTime> selectedDay = Rx<DateTime>(DateTime.now());

  var selectedHour = "".obs;

  final disponibility = [].obs;

  final arrayHours = [
    "I'm Flexible",
    "8:00am",
    "8:30am",
    "9:00am",
    "9:30am",
    "10:00am",
    "10:30am",
    "11:00am",
    "11:30am",
    "12:00pm",
    "12:30pm",
    "1:00pm",
    "1:30pm",
    "2:00pm",
    "2:30pm",
    "3:00pm",
    "3:30pm",
    "4:00pm",
    "4:30pm",
    "5:00pm",
    "5:30pm",
    "6:00pm",
    "6:30pm",
    "7:00pm",
    "7:30pm",
    "8:00pm",
    "8:30pm",
    "9:00pm",
    "9:30pm"
  ];

  List<int> disabledHours = [1, 3, 5];

  //declaro totalMount como un double observable

  var totalMount = RxDouble(0);

  //fin

  final form2Controller = RxInt(1);
  final formController = RxInt(1);
  final select = RxInt(0);
  final certainDateTask = Rx<DateTime?>(null);
  final hourSelected = RxString('3:00 pm');
  final key = GlobalKey<ScaffoldState>();
  final scroll = ScrollController();

  /// Inputs
  final locationTask = Rx<TextEditingController>(TextEditingController());
  final descriptionTask = Rx<TextEditingController>(TextEditingController());
  final reviewCardTask = Rx<TextEditingController>(TextEditingController());

  /// Selects
  // declaro lengthTask como observable con valores posibles "small", "medium" y "large" (RxString)

  final carTask = RxInt(0);
  final dateTask = RxInt(1);
  final timeTask = RxInt(1);
  final hourTask = RxInt(1);
  final filterTask = RxInt(1);

  final listSkills = [].obs;

  registerTask([paymentId]) async {
    /* creo un objeto con los datos de la tarea, pero previamente reviso estén llenos.*/

    final provider = infoProvider.value["id"];

    final location = _locationController.selectedLocation;

    final locationGeo = _locationController.selectedAddress;

    final length = lengthTask.value;

    final car = carTask.value;

    final date = selectedDay.value;

    final time = selectedHour.value;

    final description = descriptionTask.value.text;

    // verifico que los campos no esten vacios

    if (location != null &&
        locationGeo != "" &&
        length != "" &&
        date != "" &&
        time != "" &&
        description != "") {
      // si estan llenos, creo el objeto

      //  convierto location en un map de lat y lng

      final locationMap = {
        "lat": location.latitude,
        "lng": location.longitude,
      };

      final task = {
        "provider": provider,
        "location": locationMap,
        "location_geo": locationGeo,
        "length": length,
        "date": date.toString(),
        "time": time.toString(),
        "car": car,
        "description": description,
        //"paymentIntentId": paymentId,
        "status": "request"
      };

      //añado task a un objeto data

      final data = {"data": task};

      final response = await _task.createTask(data);

      if (response["status"] == 200) {
        return response["data"];
      } else {
        Get.snackbar(
          'Error!',
          'Error creating task',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      // si los campos estan vacios, muestro un snackbar con el error

      Get.snackbar(
        'Error!',
        'Please fill all the fields',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    //
  }

  String dateResume() {
    // me baso en el valor de selectedDay y selectedHour para construir el string que se muestra en el resumen de la fecha, el formato es Mar 12, 2021 - 3:00 pm

    String date = DateFormat('MMM dd,').format(selectedDay.value);

    String hour = selectedHour.value;

    return '$date - $hour';
  }

  void continueForm1() async {
    // determino la pagina actual del formulario

    if (Get.currentRoute != '/register_task') {
      return;
    }

    if (formStepOne.value == 0.25) {
      if (_locationController.selectedLocation != null &&
          lengthTask.value.isNotEmpty &&
          lengthTask.value != 'null') {
        formStepOne.value = 0.5;
      } else {
        Get.snackbar(
          'Error!',
          'Please select a location and a length task',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else if (formStepOne.value == 0.5) {
      if (carTask.value != 0 &&
          descriptionTask.value.text.isNotEmpty &&
          descriptionTask.value.text != 'null' &&
          _locationController.selectedLocation != null &&
          lengthTask.value.isNotEmpty &&
          lengthTask.value != 'null') {
        Get.toNamed('/register_task/step2');
      } else {
        Get.snackbar(
          'Error!',
          'Please select a car and a description task',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void prepareSkills(skills) {
    // recorro skills y añado a  stSkills.value  solo los nombres que estan en skills["attibutes"]["name"]

    listSkills.clear();

    for (var i = 0; i < skills.length; i++) {
      if (skills[i]["attributes"]["name"] != null) {
        final object = {
          "id": skills[i]["id"],
          "name": skills[i]["attributes"]["name"].toString(),
          "slug": skills[i]["attributes"]["slug"].toString(),
        };
        listSkills.add(object);
      }
    }
  }

  void restartTask() {
    form1Controller.value = 1;
    form2Controller.value = 1;
    formController.value = 1;
    locationTask.value.clear();
    descriptionTask.value.clear();
    reviewCardTask.value.clear();
    lengthTask.value = 'small';
    carTask.value = 0;
    dateTask.value = 1;
    timeTask.value = 1;
    hourTask.value = 1;
    filterTask.value = 1;
    certainDateTask.value = null;
    hourSelected.value = '3:00 pm';
  }

  // traer a todos los usuarios de tipo proveedor usando async await

  findProviders() async {
    // isLoading.value = true;
    Logger().d(filters);
    final response = await _task.getProviders(
        _locationController.selectedLocation?.latitude,
        _locationController.selectedLocation?.longitude,
        5000,
        filters);

    // si el status es 500 muestro un mensaje de error

    if (response["status"] != 200) {
      // paso a json el body del erro

      // muestro el mensaje de error en un snackbar en la parte inferior de la pantalla y fondo en rojo
      isLoading.value = false;
      Logger().e(response["error"]);
      Get.snackbar(
        "Error",
        "Error get providers",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      // lleno el listado de categorias con el resultado de la consulta

      listProviders.value = [];
      //  isLoading.value = false;
      Logger().e(listProviders);

      return;
    }

    listProviders.value = response["data"]["data"];

    // isLoading.value = false;
    // lleno el listado de categorias con el resultado de la consulta
  }

  findProvider() async {
    if (idProvider.value == 0) {
      return;
    }

    isLoading.value = true;
    final response = await _task.getProvider(idProvider.value);

    // si el status es 500 muestro un mensaje de error

    if (response["status"] != 200) {
      Logger().e(response);
      isLoading.value = false;

      Get.snackbar(
        "Error",
        "Error al obtener el proveedor",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      // lleno el listado de categorias con el resultado de la consulta

      infoProvider.value = {};
      isLoading.value = false;

      return;
    }

    infoProvider.value = response["data"]["proveedor"];

    disponibility.value = response["data"]["proveedor"]["horasDisponibles"];

    var total = response["data"]["proveedor"]["cost_per_houers"];

    //convierto total a double

    total = double.parse(total);

    totalMount.value = total;

    // en base a lengthTask.value y totalMount calculo el monto total

    if (lengthTask.value == 'small') {
      totalMount.value = totalMount.value * 1;
    } else if (lengthTask.value == 'medium') {
      totalMount.value = totalMount.value * 2;
    } else if (lengthTask.value == 'large') {
      totalMount.value = totalMount.value * 3;
    }

    totalMount.value = totalMount.value + 12.45;

    // saco las horas de disponibilidad del proveedor

    final tareas = response["data"]["tareas"];

    if (tareas.length > 0) {
      for (var data in tareas) {
        final dateTime = DateTime.parse(data['datetime']);
        final id = data['id'];
        final status = data['status'];
        final time = TimeOfDay.fromDateTime(DateTime.parse(data['datetime']));
        final event =
            Event(dateTime: dateTime, id: id, status: status, time: time);
        events.add(event);
      }
    }

    isLoading.value = false;
    // lleno el listado de categorias con el resultado de la consulta
  }

  getPerfilProvider(int id, [bool sendLocation = false]) async {
    if (id == 0) {
      return;
    }
    var response = {};
    if (sendLocation) {
      response = await _task.getProvider(
          id,
          _locationController.selectedLocation?.latitude,
          _locationController.selectedLocation?.longitude);
    } else {
      response = await _task.getProvider(id);
    }

    // si el status es 500 muestro un mensaje de error

    if (response["status"] != 200) {
      Get.snackbar(
        "Error",
        response["error"]["message"],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      // lleno el listado de categorias con el resultado de la consulta

      perfilProvider.value = {};

      return;
    }

    perfilProvider.value = response["data"]["proveedor"];

    Logger().d(perfilProvider.value);

    // lleno el listado de categorias con el resultado de la consulta
  }

  void clearFilters() {
    filters["date"].value = "";
    filters["time"].value = "";
    filters["price"].value = "";
    filters["provider_type"].value = "";
    filters["sortBy"].value = "Distance";
  }

  void verifySelectedDate(day) {
    Logger().d(day);
    if (events.isNotEmpty) {
      for (var event in events) {
        if (event.getDateTime == day) {
          Get.snackbar(
            'Error!',
            'The provider has a task scheduled for this date',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          // selectedDay.value = DateTime.now();
          return;
        } else {
          selectedDay.value = day;
          return;
        }
      }
    }

    selectedDay.value = day;
  }

  Future<bool> getSkills() async {
    // llamo al servicio de provider

    final response = await _services.getSkills('');

    // si el status es 200 retorno true

    if (response['status'] == 200) {
      prepareSkills(response['data'].data["data"]);
      return true;
    } else {
      return false;
    }
  }

  void showTimePicker(BuildContext context) {
    // convierto el string de la hora seleccionada en un objeto dateTime

    var hours = DateTime.parse('2021-01-01 ${selectedHour.value}');

    DatePicker.showTimePicker(
      context,
      showSecondsColumn: false,
      currentTime: hours,
      onConfirm: (dateTime) {
        // Verificar si la hora seleccionada está habilitada
        if (!disabledHours.contains(dateTime.hour)) {
          hours = dateTime;
          print('Hora seleccionada: ${dateTime.hour}:${dateTime.minute}');
        } else {
          print('Hora deshabilitada');
        }
      },
    );
  }

  Future<Map> _generateIntentPayment() async {
    dynamic response = "";

    try {
      final provider = infoProvider.value["id"];

      final location = _locationController.selectedLocation;

      final locationGeo = _locationController.selectedAddress;

      final length = lengthTask.value;

      final car = carTask.value;

      final date = selectedDay.value;

      final time = selectedHour.value;

      final description = descriptionTask.value.text;

      final category = selectedSkill.value;

      // verifico que los campos no esten vacios

      if (location != null &&
          locationGeo != "" &&
          length != "" &&
          date != "" &&
          time != "" &&
          description != "") {
        final locationMap = {
          "lat": location.latitude,
          "lng": location.longitude,
        };

        final task = {
          "provider": provider,
          "location": locationMap,
          "location_geo": locationGeo,
          "length": length,
          "date": date.toString(),
          "time": time.toString(),
          "car": car,
          "description": description,
          "category": category,
          "price": totalMount.value,
        };

        //añado task a un objeto data

        final data = {"data": task};

        response = await _paymentServices.createIntentPaymentTask(data);

        Logger().d(response);

        return response;
      } else {
        Get.snackbar(
          'Error!',
          'Please fill in all the fields',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return response;
      }
    } catch (e) {
      Logger().e(e);

      return response;
    }
  }

  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      final data = await _generateIntentPayment();

      final info = data["data"].data["data"];

      Stripe.publishableKey = info['publishableKey'];

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        merchantDisplayName: 'Provistask',
        paymentIntentClientSecret: info['paymentIntent'],
        customerEphemeralKeySecret: info['ephemeralKey'],
        customerId: info['customer'],
        style: ThemeMode.dark,
      ));

      await Stripe.instance.presentPaymentSheet();

      final conversartion = await registerTask(info['paymentIntentId']);

      Get.dialog(
        AlertDialog(
          title: const Text('Exito'),
          icon: const Icon(
            Icons.check,
            color: Colors.green,
          ),
          content: const Text('El pago se realizo con exito'),
          actions: [
            TextButton(
                onPressed: () {
                  Get.offAllNamed(
                    '/chat/$conversartion',
                  );
                },
                child: const Text('Aceptar'))
          ],
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      // muestro  un error en un dialog usando Getx

      Get.dialog(AlertDialog(
        title: const Text('Error'),
        content: const Text('Ocurrio un error al procesar el pago'),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        actions: [
          TextButton(
              onPressed: () {
                // cierro el dialog
                Get.back();
              },
              child: const Text('Aceptar'))
        ],
      ));

      Logger().e("ERROR DE PAGO", e);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print('$e');
    }
  }
}

class Event {
  final DateTime dateTime;
  final int id;
  final String status;
  final TimeOfDay time;

  Event(
      {required this.dateTime,
      required this.id,
      required this.status,
      required this.time});

  // getters

  DateTime get getDateTime => dateTime;

  int get getId => id;

  String get getStatus => status;

  TimeOfDay get getTime => time;
}
