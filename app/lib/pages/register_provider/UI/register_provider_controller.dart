import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
// importo el servicio de provider

import 'package:provitask_app/services/provider_services.dart';

// importo el servicio de auth

import 'package:provitask_app/services/auth_services.dart';

// importo el servicio de preferences

import 'package:provitask_app/services/preferences.dart';

// importo servicio de payment

import 'package:provitask_app/services/payment_services.dart';
import 'package:provitask_app/services/upload/upload_controller.dart';

class RegisterProviderController extends GetxController {
  final _services = ProviderRegisterServices();

  final _paymentServices = PaymentServices();

  final _auth = AuthService();

  final _upload = UploadServices();

  final formKey5 = GlobalKey<FormState>();

  final stepController = RxInt(1);
  final photoRegister = Rx<String>('');
  final checkPolicy = RxBool(false);
  final photoProvider = Rx<File>(File(''));
  final idPhoto = RxInt(0);

  /// Inputs
  ///
  final skillSelect = ''.obs;
  final costSkill = Rx<TextEditingController>(TextEditingController());
  final descriptionSkill = Rx<TextEditingController>(TextEditingController());
  final typeCost = 'per_hour'.obs;

  final socialSecNumber = Rx<TextEditingController>(TextEditingController());
  final address = Rx<TextEditingController>(TextEditingController());
  final aptSuite = Rx<TextEditingController>(TextEditingController());
  final city = Rx<TextEditingController>(TextEditingController());
  final state = Rx<TextEditingController>(TextEditingController());
  final zipCode = Rx<TextEditingController>(TextEditingController());
  final birthDate = Rx<TextEditingController>(TextEditingController());
  final firstAndLastName = Rx<TextEditingController>(TextEditingController());
  final firstNamePay = Rx<TextEditingController>(TextEditingController());
  final lastNamePay = Rx<TextEditingController>(TextEditingController());
  final accountNumberPay = Rx<TextEditingController>(TextEditingController());

  /// Selections
  final skillsList = <Skill>[].obs;

  /// Data
  // veo si el usuario tiene skills basandome en el _prefs.user

  var _prefs = Preferences();

  final skills = RxList();

  final meta = RxMap();

  final formKey = GlobalKey<FormState>();

  RxList<File?> images = RxList<File?>([]);

  final minimalHours = 'hour_1'.obs;

  final mediaBySkill = [].obs;

  @override
  void onInit() {
    super.onInit();
    getSkills();
    getMetaUser();
    prepareSkills();
  }

  Future<bool> getSkills() async {
    // llamo al servicio de provider

    final response = await _services.getSkills('');

    // si el status es 200 retorno true

    if (response['status'] == 200) {
      skills.value = response['data'].data["data"];
      return true;
    } else {
      return false;
    }
  }

  String titleController(int step) {
    switch (step) {
      case 1:
        return 'Select your skills';
      case 2:
        return 'You\'re almost done';
      case 3:
        return 'Add your profile photo';
      case 4:
        return 'You look good!';
      case 5:
        return 'Verify you information';
      case 6:
        return 'Verify you information';
      case 7:
        return 'Verify you information';
      case 8:
        return 'Registration Fee';
      case 9:
        return 'Verify you information';
      default:
        return '';
    }
  }

  String subtitleController(int step) {
    Logger().d(step);
    switch (step) {
      case 1:
        return 'Before you start giving servicesk, you\'ll be able to upgrade your expertise and set your fees.';
      case 2:
        return 'Verify your identification and background to demonstrate to clients that you are a trustworthy Provider.';
      case 3:
        return 'Upload a professional-looking photo of yourself';
      case 4:
        return 'Clients will see this photo as it willbe added to your profile';
      case 5:
        return 'Clients go ahead and validate your account! This must match banking details in order for us to verify your identification';

      default:
        return '';
    }
  }

  double stepBarController([int step = 1]) {
    switch (step) {
      // evaluo step del 1 al 9 , dividiendo  10/100

      case 1:
        return 0.1;

      case 2:

        // evaluo step del 1 al 9 , dividiendo  20/100

        return 0.2;

      case 3:

        // evaluo step del 1 al 9 , dividiendo  30/100

        return 0.3;

      case 4:

        // evaluo step del 1 al 9 , dividiendo  40/100

        return 0.4;

      case 5:

        // evaluo step del 1 al 9 , dividiendo  50/100

        return 0.5;

      case 6:

        // evaluo step del 1 al 9 , dividiendo  60/100

        return 0.6;

      case 7:

        // evaluo step del 1 al 9 , dividiendo  70/100

        return 0.7;

      case 8:

        // evaluo step del 1 al 9 , dividiendo  80/100

        return 0.8;

      case 9:

        // evaluo step del 1 al 9 , dividiendo  90/100

        return 1.0;

      default:
        return 0.1;
    }
  }

  Future<File?> selectPhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'bmp'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      File arch = File(file.path!);
      return arch;
    } else {
      return null;
    }
  }

  bool validateFields() {
    if (socialSecNumber.value.text.isEmpty ||
        address.value.text.isEmpty ||
        aptSuite.value.text.isEmpty ||
        city.value.text.isEmpty ||
        state.value.text.isEmpty ||
        zipCode.value.text.isEmpty ||
        birthDate.value.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool validatePay() {
    if (firstNamePay.value.text.isEmpty ||
        lastNamePay.value.text.isEmpty ||
        accountNumberPay.value.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> getMetaUser() async {
    // llamo al servicio de provider

    final response = await _auth.getMetadata();

    // si el status es 200 retorno true

    if (response['status'] == 200) {
      meta.value = response['data']['data'];

      socialSecNumber.value.text = meta['attributes']['security_number'] ?? '';
      address.value.text = meta['attributes']['address'] ?? '';
      aptSuite.value.text = meta['attributes']['apt_suite'] ?? '';
      city.value.text = meta['attributes']['city'] ?? '';
      state.value.text = meta['attributes']['state'] ?? '';
      birthDate.value.text = meta['attributes']['birthday'] ?? '';
      zipCode.value.text = meta['attributes']['postal_code'] ?? '';
      firstAndLastName.value.text = meta['attributes']['signature'] ?? '';

      // guardo  el id del usuario

      return true;
    } else {
      return false;
    }
  }

  // guardar metadata

  Future<bool> saveMetaUser() async {
    // llamo al servicio de provider

    if (!validateFields()) {
      return false;
    }

    final data = {
      'security_number': socialSecNumber.value.text,
      'address': address.value.text,
      'apt_suite': aptSuite.value.text,
      'city': city.value.text,
      'state': state.value.text,
      'birthday': birthDate.value.text,
      'postal_code': zipCode.value.text,
      'signature': firstAndLastName.value.text,
    };
    dynamic response = "";
    if (meta.isEmpty) {
      response = await _auth.createMetadata(data);
    } else {
      response = await _auth.upMeta(data, meta['id']);
    }

    await getMetaUser();

    // si el status es 200 retorno true

    if (response['status'] == 200) {
      return true;
    } else {
      Logger().e(response);

      return false;
    }
  }

  // guardar skils

  Future<bool> saveSkills() async {
    // llamo al servicio de provider

    final data = {
      'skills': skillsList,
    };

    dynamic response = await _auth.updateUser(data);

    // llamo al servicio auth.me

    await _auth.me();

    // si el status es 200 retorno true

    if (response['status'] == 200) {
      return true;
    } else {
      Logger().e(response);

      return false;
    }
  }

  prepareSkills() {
    // saco las skills del usuario

    final skills = _prefs.user?["provider_skills"];

    if (skills != null) {
      // las recorro y añado a list skills skillsList

      skills.forEach((skill) {
        // recorro element['media'] las urls de las imagenes

        List<String> media = [];
        skill['media']?.forEach((element) {
          media.add(element['url']);
        });

        skillsList.add(Skill(
          id: skill['id'],
          idCategory: skill['categorias_skill']['id'],
          cost: skill['cost'].toDouble(),
          typePrice: skill['type_price'],
          description: skill['description'],
          media: media,
          minimalHour: skill['hourMinimum'],
        ));
      });
    }
  }

  Future<Map> _generateIntentPayment() async {
    dynamic response = "";

    try {
      response = await _paymentServices.createIntentPaymentFeeRegister();

      Logger().i(response);

      return response;
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

      await _auth.updateUser({"isProvider": true, "type_provider": "normal"});

      await _auth.me();

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
                  Get.toNamed('/register_provider/step9');
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

  createSkill(idSkill, String cost, String typeCost, String descripcion) async {
    try {
      // creo la data

      // llamo al servicio de auth

      final response = await _auth.postSkill({
        "skill_id": idSkill,
        "cost": cost,
        "type_cost": typeCost,
        "description": descripcion
      });

      if (response['status'] == 500) {
        throw response['error'];
      }

      // verifico si hay imagenes para subir

      if (images.isNotEmpty) {
        Logger().i(response['data']['id']);

        for (var i = 0; i < images.length; i++) {
          final responseUpload = await _upload.upload(
              'api::provider-skill.provider-skill',
              response['data']['id'],
              'media',
              images[i]!);

          if (responseUpload['status'] == 500) {
            throw responseUpload['error'];
          }
        }
      }
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  deleteImage(imageToDelete, id) async {
    try {
      final skill = skillsList.firstWhere((skill) => skill.idCategory == id);

      await _upload.deleteByPath(
          imageToDelete, 'api::provider-skill.provider-skill', skill.id);

      skill.media!.remove(imageToDelete);

      skillsList.refresh();
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  deleteSkill(id) async {
    try {
      await _auth.deleteSkill(id);
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  // funcion auxiliar para refrescar lo campos del usuario

  auxRefreshUser() {}
}

class Skill {
  int id;
  int idCategory;
  double cost;
  String? typePrice;
  String? description;
  String? minimalHour = 'hour_1';
  List? media = [];

  Skill({
    required this.id,
    required this.idCategory,
    required this.cost,
    this.typePrice = 'per_hour',
    this.description = '',
    this.minimalHour,
    this.media,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      idCategory: json['id'],
      cost: double.parse(json['cost']),
      typePrice: json['type_price'],
      description: json['description'],
      media: json['images'],
    );
  }
}
