import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provitask_app/controllers/auth/login_controller.dart';
import 'package:provitask_app/models/data/countries_data.dart';
import 'package:provitask_app/models/provider/skill_model.dart';
import 'package:provitask_app/services/auth_services.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/services/payment_services.dart';
import 'package:provitask_app/services/preferences.dart';
import 'package:provitask_app/services/provider_services.dart';
import 'package:provitask_app/services/upload/upload_controller.dart';
// llamo pref para obtener datos del usuario

class ProfileController extends GetxController {
  final _services = ProviderRegisterServices();
  final _auth = AuthService();
  final _upload = UploadServices();

  final logger = Logger();
  final allowNotifications = true.obs;
  final clientName = TextEditingController().obs;
  final clientLastName = TextEditingController().obs;
  final clientEmail = TextEditingController().obs;
  final clientPhone = TextEditingController().obs;
  final clientZipCode = TextEditingController().obs;
  final clientResetCode = TextEditingController().obs;
  final clientResetPassword = TextEditingController().obs;
  final clientConfirmPassword = TextEditingController().obs;
  final clientPassword = TextEditingController().obs;
  final countryPhoneCode = TextEditingController().obs;
  RxString phoneCodeRegister = ''.obs;
  RxList<CountryPhoneCode>? phoneCodes = <CountryPhoneCode>[].obs;
  final clientImage = "".obs;

  final clientNameShow = "".obs;

  final user = ''.obs;

  final isLoading = false.obs;

  final isResquestingCode = false.obs;

  final succesCode = false.obs;

  final otpCode = "".obs;

  final isProvider = false.obs;

  final isStripeConnect = false.obs;

  final car = RxBool(false);
  final truck = RxBool(false);
  final moto = RxBool(false);

  final prefs = Preferences();

  final formKey = GlobalKey<FormState>();
  final formKeyPaswword = GlobalKey<FormState>();

  final skills = RxList();

  final lat = 90.0.obs;

  final lng = 180.0.obs;

  TextEditingController textEditingController = TextEditingController();

  // ignore: non_constant_identifier_names
  final open_hour = "8:00am".obs;
  // ignore: non_constant_identifier_names
  final close_hour = "9:00pm".obs;
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

  final aboutMeController = Rx<TextEditingController>(TextEditingController());
  /*Traslado de provider controler register*/

  final _paymentServices = PaymentServices();

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

  final _prefs = Preferences();

  final meta = RxMap();

  RxList<File?> images = RxList<File?>([]);

  final minimalHours = 'hour_1'.obs;

  final mediaBySkill = [].obs;

  // ignore: must_call_super

  void passwordVerification() {
    // SendMail.forgotPassword();
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

  prepareSkills() {
    // saco las skills del usuario

    final skills = _prefs.user?["provider_skills"];

    Logger().i(skills);

    if (skills != null) {
      // las recorro y añado a list skills skillsList

      skills.forEach((skill) {
        // recorro element['media'] las urls de las imagenes

        List<String> media = [];
        skill['media']?.forEach((element) {
          final url = element is Map ? element['url'] : element;
          media.add(url);
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

  getProfileData() async {
    var user = await _auth.me();

    user = user['data'];

    Logger().i(user);

    clientNameShow.value = (user['name'] ?? "") +
        (user['lastname'] != null ? " " + user['lastname'] : "");

    clientName.value.text = user['name'] ?? "";

    clientLastName.value.text = user['lastname'] ?? "";

    clientEmail.value.text = user['email'] ?? "";

    clientPhone.value.text = user['phone'] ?? "";

    clientZipCode.value.text = user['postal_code'] ?? "";

    clientImage.value = user['avatar_image'] != null
        ? user['avatar_image']["url"]
        : "/uploads/user_147dd8408e.png";

    isProvider.value = user['isProvider'] ?? false;

    isStripeConnect.value = user['is_stripe_connect'] ?? false;

    car.value = user['car'] ?? false;

    truck.value = user['truck'] ?? false;

    moto.value = user['motorcycle'] ?? false;

    lat.value = user['lat'] != null ? user['lat'].toDouble() : 90.0;

    lng.value = user['lng'] != null ? user['lng'].toDouble() : 180.0;

    open_hour.value = user['open_disponibility'] != null
        ? formatTimeFromFormattedString(user['open_disponibility'])
        : "8:00am";

    close_hour.value = user['close_disponibility'] != null
        ? formatTimeFromFormattedString(user['close_disponibility'])
        : "9:00pm";

    if (user['provider_skills'] != null) {
      user['provider_skills'].forEach((skill) {
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

    if (user['description'] != null) {
      aboutMeController.value.text = user['description'];
    }
  }

  void uploadImage(image) async {
    var response = await _auth.updateAvatar(image);

    if (response['status'] == 500) {
      Get.snackbar(
        'Error!',
        'Error uploading image',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    getProfileData();

    /*  Get.snackbar(
      'Success!',
      'Image uploaded successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );*/
  }

  void getAllPhoneCodes() async {
    phoneCodes!.value = await CountryPhoneCode.getAllPhoneCodes();
    if (phoneCodes!.isNotEmpty) {
      phoneCodeRegister.value = phoneCodes!.first.dialCode!;
    }
  }

  void updateProfile() async {
    isLoading.value = true;

    var response = await _auth.updateProfile(
      clientName.value.text,
      clientLastName.value.text,
      clientEmail.value.text,
      clientPhone.value.text,
      clientZipCode.value.text,
    );

    if (response['status'] == 500) {
      Get.snackbar(
        'Error!',
        'Error updating profile',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    getProfileData();

    Get.snackbar(
      'Success!',
      'Profile updated successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );

    isLoading.value = false;
  }

  void updatePassword() async {
    isLoading.value = true;

    var response = await _auth.updatePassword(
      otpCode.value,
      clientPassword.value.text,
      clientConfirmPassword.value.text,
    );

    if (response['status'] == 500) {
      logger.e(response);
      Get.snackbar(
        'Error!',
        'Error updating password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
      return;
    }

    //_getProfileData();

    Get.snackbar(
      'Success!',
      'Password updated successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );

    // reset all fields

    clientResetCode.value.text = "";
    clientResetPassword.value.text = "";
    clientConfirmPassword.value.text = "";

    isResquestingCode.value = false;

    succesCode.value = false;

    otpCode.value = "";

    // rediriect to login

    Get.toNamed('/profile_client');

    isLoading.value = false;
  }

  // funcion para solicitar el codigo de verificacion para cambiar la contraseña

  void requestResetPassword() async {
    isLoading.value = true;
    isResquestingCode.value = true;

    var response = await _auth.requestResetPassword(clientEmail.value.text);

    logger.i(response);

    if (response['status'] == 500) {
      Get.snackbar(
        'Error!',
        'Error requesting reset password',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    getProfileData();

    Get.snackbar(
      'Success!',
      'Reset password requested successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );

    isLoading.value = false;
  }

  createSkill(idSkill, String cost, String typeCost, String descripcion) async {
    try {
      // creo la data

      // llamo al servicio de _auth

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

      // elimino de skillsList

      skillsList.removeWhere((skill) => skill.idCategory == id);

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

  @override
  onInit() async {
    super.onInit();

    isLoading.value = true;

    await getProfileData();

    // logger.i(clientNameShow);

    isLoading.value = false;
  }

  Future<void> verifyOtp(String value) async {
    if (value.length != 6) {
      return;
    }

    isLoading.value = true;

    var response = await _auth.verifyOtp(value);

    if (response['status'] == 500) {
      Get.snackbar(
        'Error!',
        'Error verifying otp',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
      return;
    }

    //_getProfileData();

    isLoading.value = false;

    //  guardo el otp en la variable

    otpCode.value = value;

    succesCode.value = true;
  }

  void stateClear() {
    clientResetCode.value.text = "";
    clientResetPassword.value.text = "";
    clientConfirmPassword.value.text = "";

    isResquestingCode.value = false;

    succesCode.value = false;

    otpCode.value = "";
  }

  void logout() {
    _auth.logout();

    Get.offAllNamed('/login');

    //  Get.lazyPut<LoginController>(() => LoginController());
  }

  void becomeProvider() {}

  createStripeAccount() async {
    try {
      var response = await _auth.createStripeAccountConnet();

      logger.i(response);

      if (response['status'] != 200) {
        Get.snackbar(
          'Error!',
          'Error creating stripe account',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      return response['data'];
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<bool> saveVehicles() async {
    // llamo al servicio de provider

    final data = {
      'car': car.value,
      'motorcycle': moto.value,
      'truck': truck.value,
    };

    dynamic response = await _auth.updateUser(data);

    // llamo al servicio _auth.me

    await _auth.me();

    // si el status es 200 retorno true

    if (response['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> saveAboutMe() async {
    // llamo al servicio de provider

    final data = {
      'description': aboutMeController.value.text,
    };

    dynamic response = await _auth.updateUser(data);

    // llamo al servicio _auth.me

    await _auth.me();

    // si el status es 200 retorno true

    if (response['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> saveUbicationServices(LatLng? location) async {
    // preparo la hora de apertura y cierre

    final data = {
      'lat': location!.latitude,
      'lng': location.longitude,
      'open_disponibility': parseTimeToFormattedString(open_hour.value),
      'close_disponibility': parseTimeToFormattedString(close_hour.value),
    };

    dynamic response = await _auth.updateUser(data);

    // llamo al servicio _auth.me

    await _auth.me();

    // si el status es 200 retorno true

    if (response['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }

  String parseTimeToFormattedString(String timeString) {
    final regex = RegExp(r'(\d+):(\d+)([ap]m)', caseSensitive: false);
    final match = regex.firstMatch(timeString);

    if (match == null) {
      throw ArgumentError("Invalid time format: $timeString");
    }

    var hours = int.parse(match.group(1)!);
    final minutes = int.parse(match.group(2)!);
    final isAM = match.group(3)!.toLowerCase() == 'am';

    if (!isAM && hours < 12) {
      hours += 12;
    }

    final formattedTime =
        "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:00.000";
    return formattedTime;
  }

  String formatTimeFromFormattedString(String formattedTimeString) {
    final components = formattedTimeString.split(':');

    if (components.length != 3) {
      throw ArgumentError(
          "Invalid formatted time format: $formattedTimeString");
    }

    var hours = int.parse(components[0]);
    final minutes = int.parse(components[1]);

    String period = hours >= 12 ? 'pm' : 'am';
    if (hours > 12) {
      hours -= 12;
    } else if (hours == 0) {
      hours = 12;
    }

    final formattedTime = '$hours:${minutes.toString().padLeft(2, '0')}$period';
    return formattedTime;
  }

  auxRefreshUser() {}
}
