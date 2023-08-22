import 'package:get/get_state_manager/src/simple/get_controllers.dart';
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

// confiuguro dio para que muestre los logs de las peticiones

class TaskServices extends GetxController {
  Future<Map> getItems(
      [int limit = 6, int start = 0, bool featured = true]) async {
    Map respuesta;
    configDio();
    try {
      final response =
          await dio.get("/tasks?featured=$featured&start=$start&limit=$limit");

      // reviso el status de la respuesta si es distinto a 200 lanzo error

      if (response.statusCode != 200) {
        throw response.data;
      }

      Logger().d(response.data);

      respuesta = {"status": 200, "data": response.data};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  Future<Map> getPopularItems(
      [double lat = 0, double lng = 0, int distance = 0]) async {
    Map respuesta;
    configDio();
    try {
      final response = await dio.get(
          "/users-permissions/proveedores/destacados?lat=$lat&lng=$lng&distance=$distance");

      // reviso el status de la respuesta si es distinto a 200 lanzo error

      if (response.statusCode != 200) {
        throw response.data;
      }

      respuesta = {"status": 200, "data": response.data};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

// defino getItem como una funcion asincrona que retorna un Map

  Future<Map> getItem(id, [double? lat, double? lng]) async {
    Map respuesta;
    configDio();
    try {
      if (lat == null || lng == null) {
        lat = 0;
        lng = 0;
      }

      final response = await dio.get("/tasks/$id?populate=*&lat=$lat&lng=$lng");

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
    configDio();
    try {
      Logger().d(
          "/users-permissions/proveedores/?lat=$lat&lng=$lng&distance=$distance&time_of_day=${filters["time_of_day"]}&long_task=${filters["long_task"]}&type_price=${filters["type_price"]}&provider_type=${filters["provider_type"]}&sortBy=${filters["sortBy"]}&hour=${filters["hour"]}&day=${filters["day"]}&skill=${filters["skill"]}&transportation=${filters["transportation"]}&start=${filters["start"]}&limit=${filters["limit"]}");

      final response = await dio.get(
          "/users-permissions/proveedores?lat=$lat&lng=$lng&distance=$distance&time_of_day=${filters["time_of_day"]}&long_task=${filters["long_task"]}&type_price=${filters["type_price"]}&provider_type=${filters["provider_type"]}&sortBy=${filters["sortBy"]}&hour=${filters["hour"]}&day=${filters["day"]}&skill=${filters["skill"]}&transportation=${filters["transportation"]}&start=${filters["start"]}&limit=${filters["limit"]}");

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

  Future<Map> getProvider(int id,
      [lat = false, lng = false, int? idSkill]) async {
    Map respuesta;
    configDio();
    try {
      //
      // hago la peticion

      final response = await dio.get(
          "/users-permissions/proveedores/$id?lat=$lat&lng=$lng&idSkill=$idSkill");

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

  Future<Map> createTask(Map<String, dynamic> task,
      [status = 'request']) async {
    Map respuesta;
    configDio();
    try {
      task = {...task, status: status};

      final response = await dio.post("/task-assigneds", data: task);

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

  Future<Map> meTask(status, [int page = 1, int limit = 5]) async {
    Map respuesta;
    configDio();
    try {
      final response = await dio
          .get('/task-assigneds?status=$status&page=$page&limit=$limit');

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

  Future<Map> taskDetail(int id) async {
    Map respuesta;
    configDio();
    try {
      final response = await dio.get('/task-assigneds/$id');

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

  Future<Map> finishTask(item) async {
    Map respuesta;

    try {
      // hago la peticion

      final response = await dio.get('/task-assigneds/completed/$item');

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

  Future<Map> generarChat(id) async {
    Map respuesta;
    configDio();
    try {
      // hago la peticion

      final response = await dio.get('/conversation/create/$id');

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

  Future<Map> editTask(int id, Map<String, dynamic> task) async {
    Map respuesta;
    configDio();
    try {
      // agrego a dio interceptor para errores

      /* dio.interceptors.add(
        InterceptorsWrapper(
          onError: (DioException e, errorInterceptorHandler) {
            // Mostrar el mensaje de error
            print('Error: ${e.response?.data ?? e.message}');
          },
        ),
      );*/

      final response = await dio.put("/task-assigneds/$id", data: task);

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

  Future<Map> getPendingTask() async {
    Map respuesta;

    try {
      final response = await dio.get("/task-assigneds/pending-task");

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

  Future<Map> getTaskByPaymentIntentId(String paimentInt) async {
    Map respuesta;
    configDio();
    try {
      final response =
          await dio.get("/task-assigneds/by-payment-intent/$paimentInt");

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

  Future<Map> sendCalificacion(
      int iDProvider, int iDTask, double calificacion, String rewiew) async {
    Map respuesta;
    configDio();

    try {
      final response = await dio.post("/valorations", data: {
        "provider": iDProvider,
        "task": iDTask,
        "rating": calificacion,
        "description": rewiew
      });

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

  Future<Map> canceledTask(int id, String reason) async {
    Map respuesta;
    configDio();

    try {
      final response = await dio.post("/task-assigneds/canceled-task", data: {
        "id": id,
        "reason": reason,
      });

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
}

Function getToken = () {
  return prefs.token;
};

// funcion para configurar Dio

Function configDio = () {
  dio.options.headers["content-type"] = "application/json";
  dio.options.headers["Authorization"] = "Bearer ${getToken()}";
};

TaskServices auth = TaskServices();
