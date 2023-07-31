import 'dart:io';

import 'package:flutter/material.dart' hide DatePickerTheme;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/common/constans.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';
import 'package:provitask_app/models/provider/provider_model.dart';
import 'package:provitask_app/services/task_services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:provitask_app/services/provider_services.dart';
import 'package:provitask_app/services/payment_services.dart';

class RegisterTaskController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    await getSkills();

    final datetime = DateTime.now().add(const Duration(days: 7));

    // añado en filters["day"].value solo el dia y no la hora

    filters["day"].value = datetime.toString().substring(0, 10);
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

  RxList<File?> images = RxList<File?>([]);

  final isLoading = false.obs;

  final selectedSkill = "1".obs;
  List<Provider> listProviders = RxList<Provider>();
  final lengthTask = RxString('');

  // calculo el día actual en la seman que viene

  RxMap<String, dynamic> filters = {
    "time_of_day": "morning".obs,
    "type_price": "".obs,
    "provider_type": "not_provider".obs,
    "sortBy": "Distance".obs,
    "hour": "I'm Flexible".obs,
    "day": "".obs,
    "long_task": "small".obs,
    "skill": "1".obs,
    "transportation": "not_necessary".obs,
    "typeDate": "next_week".obs,
    "limit": 10.obs,
    "start": 0.obs
  }.obs;

  // asigno nextWeek  a filters["day"]

  final idProvider = RxInt(0);

  dynamic infoProvider = {}.obs;

  dynamic perfilProvider = {}.obs;

  RxList events = [].obs;

  Rx<DateTime> selectedDay = Rx<DateTime>(DateTime.now());

  var selectedHour = "8:00am".obs;

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

  final disponibilityHour = [
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
  ].obs;

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

  final keyDialogSelect = GlobalKey<ScaffoldState>();

  registerTask([paymentId, monto]) async {
    /* creo un objeto con los datos de la tarea, pero previamente reviso estén llenos.*/

    final provider = perfilProvider.value["id"];

    final location = _locationController.selectedLocation;

    final locationGeo = _locationController.selectedAddress;

    final length = filters['long_task'].value;

    final car = filters['transportation'].value;

    final date = selectedDay.value;

    final time = selectedHour.value;

    final description = descriptionTask.value.text;

    final locationMap = {
      "lat": location!.latitude,
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
      "paymentIntentId": paymentId,
      "status": "acepted",
      "skill": filters["skill"].value,
      "netoPrice": monto,
    };

    //añado task a un objeto data

    final data = {"data": task};

    final response = await _task.createTask(data);

    // subo las imagenes

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

    //
  }

  String dateResume([String? datex = "", String? hourx = ""]) {
    if (datex == "") {
      datex = filters["day"].value;
    }

    if (hourx == "") {
      hourx = filters["hour"].value;
    }

    final datetime = DateTime.parse(datex!);

    // le añado la hora seleccionada

    String date = DateFormat('MMM dd,').format(datetime);

    String hour = hourx!;

    return '$date - $hour';
  }

  void continueForm1() async {
    if (Get.currentRoute != '/register_task') {
      return;
    }

    //Get.toNamed('/register_task/step2');

    if (_locationController.selectedLocation == null) {
      Get.snackbar(
        'Error!',
        'Please select a location',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20),
        maxWidth: Get.width * 0.9,
      );

      return;
    } else if (filters["long_task"].value == "") {
      Get.snackbar(
        'Error!',
        'Please select a task length',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        maxWidth: Get.width * 0.9,
        margin: const EdgeInsets.only(bottom: 20),
      );

      return;
    } else if (filters["time_of_day"].value == "") {
      Get.snackbar(
        'Error!',
        'Please select a time of day',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        maxWidth: Get.width * 0.9,
        margin: const EdgeInsets.only(bottom: 20),
      );

      return;
    } else if (filters["transportation"].value == "") {
      Get.snackbar(
        'Error!',
        'Please select a transportation',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        maxWidth: Get.width * 0.9,
        margin: const EdgeInsets.only(bottom: 20),
      );

      return;
    } else if (descriptionTask.value.text == "") {
      Get.snackbar(
        'Error!',
        'Please enter a description',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        maxWidth: Get.width * 0.9,
        margin: const EdgeInsets.only(bottom: 20),
      );

      return;
    }

    Get.toNamed('/register_task/step2');
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
        Constants.distance,
        filters);

    // si el status es 500 muestro un mensaje de error
    listProviders.clear();
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
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.only(bottom: 20),
      );

      // lleno el listado de categorias con el resultado de la consulta

      //  isLoading.value = false;

      return;
    }

    final List<dynamic> data =
        response['data']['data']; // Obtener la lista de proveedores

    for (var json in data) {
      listProviders.add(Provider(
        id: json['id'],
        isProvider: json['isProvider'],
        name: json['name'],
        lastname: json['lastname'],
        averageScore: json['averageScore'].toDouble(),
        averageCount: json['averageCount'],
        typeProvider: json['type_provider'],
        description: json['description'],
        motorcycle: json['motorcycle'],
        car: json['car'],
        truck: json['truck'],
        openDisponibility: json['open_disponibility'],
        closeDisponibility: json['close_disponibility'],
        avatarImage: json['avatar_image'],
        skillSelect: json['skill_select'],
        allSkills: ProviderSkill.map(json['provider_skills']),
        distanceLineal: json['distanceLineal'].toDouble(),
        online: OnlineStatus.fromJson(json['online']),
      ));
    }

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

    isLoading.value = false;
  }

  getPerfilProvider(int id, [bool sendLocation = false, int? skill]) async {
    if (id == 0) {
      return;
    }
    var response = {};
    if (sendLocation) {
      response = await _task.getProvider(
          id,
          _locationController.selectedLocation?.latitude,
          _locationController.selectedLocation?.longitude,
          skill);
    } else {
      response = await _task.getProvider(id, false, false, skill);
    }

    // si el status es 500 muestro un mensaje de error

    if (response["status"] != 200) {
      // lleno el listado de categorias con el resultado de la consulta

      perfilProvider.value = {};

      return false;
    }

    perfilProvider.value = response["data"]["proveedor"];

    // lleno el listado de categorias con el resultado de la consulta
  }

  void clearFilters() {
    filters["time_of_day"].value = "morning";
    filters["type_price"].value = "";
    filters["provider_type"].value = "not_provider";
    filters["sortBy"].value = "Distance";
    filters["hour"].value = "I'm Flexible";
    filters["day"].value = "";
    filters["long_task"].value = "small";
    filters["typeDate"].value = "next_week";
  }

  void verifySelectedDate(day) {
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
      final args = Get.arguments;

      if (args != null) {
        if (args["id"] != null) {
          filters["skill"].value = args["id"].toString();
        }
      }
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
      final provider = perfilProvider.value["id"];

      final location = _locationController.selectedLocation;

      final locationGeo = _locationController.selectedAddress;

      final length = filters['long_task'].value;

      final car = filters['transportation'].value;

      final date = selectedDay.value;

      final time = selectedHour.value;

      final description = descriptionTask.value.text;

      final category = filters['skill'].value;

      // verifico que los campos no esten vacios

      if (location != null &&
          locationGeo != "" &&
          length != "" &&
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
          "skill": category,
          "netoPrice":
              formatFinalMount(perfilProvider.value["skill_select"], length),
          "brutePrice":
              formatFinalMount(perfilProvider.value["skill_select"], length, 0),
          "createType": "client"
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

  formatFinalMount(Map skillSelect, String longTask, [int tax = 12]) {
    final double cost = skillSelect["cost"].toDouble();

    final String minimalHour =
        skillSelect["hourMinimum"].replaceAll("hour_", "");
    int hour = 1;
    if (longTask == "small") {
      hour = 1;
    } else if (longTask == "medium") {
      hour = 4;
    } else {
      hour = 8;
    }

    if (int.parse(minimalHour) > hour) {
      hour = int.parse(minimalHour);
    }

    final String type = skillSelect["type_price"];

    // los tipos son by_project_flat_rate , per_hour y free_trading

    if (type == "by_project_flat_rate") {
      // si es por proyecto el precio es el mismo - el 12% de impuestos x la horas
      return (cost) + ((cost * hour) * tax / 100);
    } else if (type == "per_hour") {
      // si es por hora el precio es el costo por la cantidad de horas mas el 12% de impuestos

      return (cost * hour) + ((cost * hour) * tax / 100);
    } else {
      // si es free trading el precio es el costo por la cantidad de horas mas el 12% de impuestos

      return (cost) + ((cost * hour) * tax / 100);
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
        merchantDisplayName: 'Provitask',
        paymentIntentClientSecret: info['paymentIntent'],
        customerEphemeralKeySecret: info['ephemeralKey'],
        customerId: info['customer'],
        style: ThemeMode.dark,
      ));

      await Stripe.instance.presentPaymentSheet();

      // busco tarea por paymentIntentId

      final response =
          await _task.getTaskByPaymentIntentId(info['paymentIntentId']);

      final conversartion = response["data"]["data"];

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

                  //Get.back();
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
