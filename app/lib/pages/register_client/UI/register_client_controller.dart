import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/models/data/countries_data.dart';
import 'package:provitask_app/services/auth_services.dart';

class RegisterCLientController extends GetxController {
  // Data
  RxString phoneCodeRegister = ''.obs;
  final AuthService _auth = AuthService();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = Rx<TextEditingController>(TextEditingController());
  final surnameController = Rx<TextEditingController>(TextEditingController());
  final emailController = Rx<TextEditingController>(TextEditingController());
  final passwordController = Rx<TextEditingController>(TextEditingController());
  final confirmPasswordController =
      Rx<TextEditingController>(TextEditingController());
  final phoneController = Rx<TextEditingController>(TextEditingController());
  final postalCodeController =
      Rx<TextEditingController>(TextEditingController());
  RxList<CountryPhoneCode>? phoneCodes = <CountryPhoneCode>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllPhoneCodes();
  }

  void getAllPhoneCodes() async {
    phoneCodes!.value = await CountryPhoneCode.getAllPhoneCodes();
    if (phoneCodes!.isNotEmpty) {
      phoneCodeRegister.value = phoneCodes!.first.dialCode!;
    }
  }

  void register() async {
    // valido el formulario
    print("register");

    print(formKey.currentState!.validate());
    if (!formKey.currentState!.validate()) {
      print("no valido");
      return;
    }

    // muestro el loading

    // llamo al servicio de registro

    final response = await _auth.register(
        nameController.value.text,
        emailController.value.text,
        passwordController.value.text,
        surnameController.value.text,
        postalCodeController.value.text,
        phoneController.value.text);

    if (response["status"] != 200) {
      // muestro el mensaje de error en un snackbar en la parte inferior de la pantalla y fondo en rojo

      Get.snackbar("Error",
          "Ha ocurrido un error al registrar el usuario, email o teléfono ya existen",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          // subo un poco el snackbar

          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20));
      await Future.delayed(const Duration(seconds: 2));

      return;
    }

    // si el status es 200 muestro un mensaje de bienvenida

    Get.snackbar("Bienvenido", "Has registrado un usuario correctamente",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        // subo un poco el snackbar

        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20));
    await Future.delayed(const Duration(seconds: 2));

    // tomo de la respuesta el token y lo guardo en las preferencias

    // final token = response["data"].data["jwt"];
  }
}
