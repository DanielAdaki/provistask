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

class ProviderRegisterServices {
  Future<Map> getSkills(String search) async {
    Map respuesta;

    try {
      final response = await dio.get("/skills");

      // reviso el status de la respuesta si es distinto a 200 lanzo error

      if (response.statusCode != 200) {
        throw response.data;
      }

      respuesta = {"status": 200, "data": response};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  Future<Map> getComments(
      int provider, int skill, int currentPage, int limit) async {
    Map respuesta;

    try {
      final response = await dio.get(
          "/users-permissions/proveedores/reviews/$provider?page=$currentPage&limit=$limit&skill=$skill");

      // reviso el status de la respuesta si es distinto a 200 lanzo error

      if (response.statusCode != 200) {
        throw response.data;
      }

      respuesta = {"status": 200, "data": response};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  Future<Map> getItem(int id) async {
    Map respuesta;

    try {
      final response = await dio.get("/categories/$id");

      // reviso el status de la respuesta si es distinto a 200 lanzo error

      if (response.statusCode != 200) {
        throw response.data;
      }

      logger.d(response.data);

      // mando al modelo

      var aux = response.data;

      respuesta = {"status": 200, "data": aux};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }
}

// defino getItem como una funcion asincrona que retorna un Map

// importo conexion_common.dart

ProviderRegisterServices providerRegisterServices = ProviderRegisterServices();
// TODO Implement this library.