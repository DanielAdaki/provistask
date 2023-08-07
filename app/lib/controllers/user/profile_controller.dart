import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provitask_app/controllers/auth/login_controller.dart';
import 'package:provitask_app/models/data/countries_data.dart';
import 'package:provitask_app/services/auth_services.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/services/preferences.dart';
import 'package:provitask_app/services/provider_services.dart';

// llamo pref para obtener datos del usuario

class ProfileController extends GetxController {
  final _services = ProviderRegisterServices();
  final _auth = AuthService();
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

  /// Selections
  final skillsList = RxList<int>();

  final List<String> suggestions = [
    'sugerencia 1',
    'sugerencia 2',
    'sugerencia 3'
  ];

  TextEditingController textEditingController = TextEditingController();

  final open_hour = "8:00am".obs;
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
  @override

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

  void prepareSkills() {
    // saco las skills del usuario

    final skills = prefs.user?["skills"];

    if (skills != null) {
      // lo recoorro y añado los ["id"] a la lista de skills

      skills.forEach((element) {
        skillsList.add(element["id"]);
      });
    }
  }

  getProfileData() async {
    var user = await auth.me();

    user = user['data'];

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

    lat.value = user['lat'] ?? 90.0;

    lng.value = user['lng'] ?? 180.0;

    open_hour.value = user['open_disponibility'] != null
        ? formatTimeFromFormattedString(user['open_disponibility'])
        : "8:00am";

    close_hour.value = user['close_disponibility'] != null
        ? formatTimeFromFormattedString(user['close_disponibility'])
        : "9:00pm";

    if (user['provider_skills'] != null) {
      user['provider_skills'].forEach((element) {
        skillsList.add(element['id']);
      });
    }

    if (user['description'] != null) {
      aboutMeController.value.text = user['description'];
    }
  }

  void uploadImage(image) async {
    var response = await auth.updateAvatar(image);

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

    var response = await auth.updateProfile(
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

    var response = await auth.updatePassword(
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

    var response = await auth.requestResetPassword(clientEmail.value.text);

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

    var response = await auth.verifyOtp(value);

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
    auth.logout();

    Get.offAllNamed('/login');

    Get.lazyPut<LoginController>(() => LoginController());
  }

  void becomeProvider() {}

  createStripeAccount() async {
    try {
      var response = await auth.createStripeAccountConnet();

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

    // llamo al servicio auth.me

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

    // llamo al servicio auth.me

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

    Logger().i(data);

    dynamic response = await _auth.updateUser(data);

    // llamo al servicio auth.me

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
}
