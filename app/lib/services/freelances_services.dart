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
  'connetTimeout': 5000,
  'receiveTimeout': 5000
}, baseUrl: ConexionCommon.hostApi);

Dio dio = Dio(options);

// añado inteceptadores

class FreelancesServices {
  Future<Map> getItems(String status) async {
    Map respuesta;

    try {
      final response = await dio
          .get("/users-permissions/proveedores/fav-or-book?status=$status");

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

  Future<Map> getItem(id) async {
    Map respuesta;

    try {
      final response = await dio.get("/tasks/$id?populate=*");

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

  Future<Map> getProviders(double? lat, double? lng, int? distance,
      [filters]) async {
    Map respuesta;

    try {
      // saco los filtros date, time, price, provider_type

      var date = filters["date"];
      var time = filters["time"];
      var price = filters["price"];
      var providerType = filters["provider_type"];
      var sortBy = filters["sortBy"];

      // hago la peticion

      final response = await dio.get(
          "/users-permissions/proveedores/?lat=$lat&lng=$lng&distance=$distance&date=$date&time=$time&price=$price&provider_type=$providerType&sortBy=$sortBy");

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

  Future<Map> getProvider(int id) async {
    Map respuesta;

    try {
      // hago la peticion

      final response = await dio.get("/users-permissions/proveedores/$id");

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

    return respuesta; //
  }

  Future<Map> getConversation(int id) async {
    Map respuesta;

    try {
      // añado interceptadores de dio para saber el error

      final response = await dio
          .get("/users-permissions//proveedores/conversation/$id?isNew=true");

      // reviso el status de la respuesta si es distinto a 200 lanzo error

      if (response.statusCode != 200) {
        throw response.data;
      }

      // mando al modelo

      var aux = response.data;

      respuesta = {"status": 200, "data": aux};
    } on DioException catch (e) {
      Logger().i(e);
      respuesta = {"status": 500, "error": e};
    }

    return respuesta; //
  }

// importo conexion_common.dart
}

//getPopularItems

FreelancesServices auth = FreelancesServices();
