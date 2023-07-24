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

class MessageServices {
  Future<Map> getItems() async {
    Map<String, dynamic> respuesta;

    try {
      final response = await dio.get("/conversations");

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

  Future<Map> getPopularItems() async {
    Map respuesta;

    try {
      final response = await dio.get(
          "/tasks?sort=countPurchase:desc&pagination[pageSize]=4&fields[0]=location&fields[1]=name&fields[2]=countPurchase&fields[3]=averageScore&populate[0]=image");

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

// defino getItem como una funcion asincrona que retorna un Map

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

  Future<Map> createTask(Map<String, dynamic> task) async {
    Map respuesta;

    try {
      // hago la peticion

      final response = await dio.post("/task-assigneds", data: task);

      logger.d(response.data);

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

  Future<Map> meTask(status) async {
    Map respuesta;

    try {
      // hago la peticion

      final response =
          await dio.get('/task-assigneds?filters[status][\$eq]=$status');

      logger.d(response.data);

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

  Future<Map<String, dynamic>> getTaskChat(String? id) async {
    Map<String, dynamic> respuesta;

    try {
      // hago la peticion

      final response = await dio.get('/task-assigneds/by-conversation/$id');

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

  Future<Map> acceptProposal(int id) async {
    Map respuesta;

    try {
      // agrego a dio interceptor para errores

      final response = await dio.get("/task-assigneds/acepted/$id");

      if (response.statusCode != 200) {
        throw response.data;
      }
      // mando al modelo

      var aux = response.data;
      Logger().d(aux);

      respuesta = {"status": 200, "data": aux};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }

    return respuesta; //
  }

// importo conexion_common.dart
}

//getPopularItems

MessageServices auth = MessageServices();
