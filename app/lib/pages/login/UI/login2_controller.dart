import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provitask_app/graphql/mutations/auth/auth.dart';
import 'package:provitask_app/models/data/client_information.dart';
import 'package:provitask_app/pages/profile_provider/UI/profile_provider_controller.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_controller.dart';

class LoginController2 extends GetxController {
  // imprimo un ""hola mundo"

  final formKey = GlobalKey<FormState>();

  final loginController = RxInt(0);

  /// inputs
  final emailController = Rx<TextEditingController>(TextEditingController());
  final passwordController = Rx<TextEditingController>(TextEditingController());

  void login() async {
    if (kDebugMode) {
      print("login");
    }
    QueryResult response = await Auth.run(
        emailController.value.text, passwordController.value.text);

    if (response.hasException) {
      if (kDebugMode) {
        print(response.exception.toString());
      }
      Get.snackbar(
        'ERROR!',
        "Ha ocurrido un error, por favor intente de nuevo",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    // extraigo data de response

    final data = response.data!['login'];
    if (kDebugMode) {
      print(data as List);
    }

    if ((data).isNotEmpty) {
      ClientInformation.clientId = data[0]['id'];
      ClientInformation.clientName = data[0]['attributes']['name'];
      ClientInformation.clientSurname = data[0]['attributes']['last_name'];
      ClientInformation.clientEmail = data[0]['attributes']['email'];
      ClientInformation.clientPostalCode = data[0]['attributes']['postal_code'];
      ClientInformation.clientImage =
          data[0]['attributes']['avatar_image']['data']['attributes']['url'];
      ClientInformation.clientPhone = data[0]['attributes']['phone'];
      ClientInformation.clientIsProvider = data[0]['attributes']['isProvider'];
      ClientInformation.forgotCode = data[0]['attributes']['forgot_code'];
      ClientInformation.setLoggedIn(true);
      Get.snackbar(
        'SUCCESS',
        "Login Successful",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
      if (loginController.value != 1) {
        if (ClientInformation.clientIsProvider!) {
          Get.put<ProfileProviderController>(ProfileProviderController());
          Get.offNamed('/profile_provider');
        } else {
          final rePro =
              Get.put<RegisterProviderController>(RegisterProviderController());
          await rePro.getSkills().then((data) {
            if (data) {
              Get.offNamed('/register_provider');
            }
          });
        }
      } else {
        Get.offNamed('/home');
      }
    } else {
      Get.snackbar(
        'ERROR!',
        "Error email o password incorrect",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  loginForgottPassword() {}
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
