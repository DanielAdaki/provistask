import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'package:provitask_app/services/preferences.dart';

// importo conexion_common.dart

import 'package:provitask_app/common/conexion_common.dart';
import 'package:dio/dio.dart';

var logger = Logger();
final prefs = Preferences();
final token = prefs.token;

BaseOptions options = BaseOptions(headers: {
  'content-type': 'application/json',
  'Authorization': 'Bearer $token',
}, baseUrl: ConexionCommon.hostApi);

Dio dio = Dio(options);

class PaymentServices extends GetxController {
  Future<Map> createIntentPaymentFeeRegister() async {
    Map respuesta;
    configDio();
    try {
      final response =
          await dio.get("/users-permissions/create-payment-intent-register");

      Logger().d(response.data);

      if (response.statusCode != 200) {
        throw response.data;
      }

      respuesta = {"status": 200, "data": response};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  Future<Map> createIntentPaymentTask(data) async {
    Map respuesta;
    configDio();
    try {
      final response =
          await dio.post("/users-permissions/create-payment-task", data: data);

      if (response.statusCode != 200) {
        throw response.data;
      }

      respuesta = {"status": 200, "data": response};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }
}

Function getToken = () {
  return prefs.token;
};

// funcion para configurar Dio

Function configDio = () {
  dio.options.headers["content-type"] = "application/json";
  dio.options.headers["Authorization"] = "Bearer ${getToken()}";
  Logger().d(dio.options.headers);
};
PaymentServices auth = PaymentServices();
