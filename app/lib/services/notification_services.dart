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
}, baseUrl: ConexionCommon.hostApi);

Dio dio = Dio(options);

class NotificationServices {
  Future<Map> getItems(int page, int limit) async {
    Map<String, dynamic> respuesta;

    // configuro dio

    configDio();

    try {
      final response = await dio.get("/notifications?page=$page&limit=$limit");

      // Reviso el status de la respuesta, si es diferente a 200 lanzo error
      if (response.statusCode != 200) {
        throw response.data;
      }

      respuesta = {"status": 200, "data": response.data};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  Future<Map> getItem(id) async {
    Map respuesta;
    configDio();
    try {
      final response = await dio.get("/notifications/$id");

      // reviso el status de la respuesta si es distinto a 200 lanzo error

      if (response.statusCode != 200) {
        throw response.data;
      }

      // mando al modelo

      var aux = response.data;

      respuesta = {"status": 200, "data": aux};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  Future<Map> markAsRead(int id) async {
    Map respuesta;
    configDio();
    try {
      final response = await dio.get("/notifications/marked-as-read/$id");

      // reviso el status de la respuesta si es distinto a 200 lanzo error

      if (response.statusCode != 200) {
        throw response.data;
      }

      // mando al modelo

      var aux = response.data;

      respuesta = {"status": 200, "data": aux};
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
};
