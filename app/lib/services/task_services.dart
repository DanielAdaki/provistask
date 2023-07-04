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
  Future<Map> getItems(String search) async {
    Map respuesta;

    try {
      final response = await dio.get("/tasks?populate=image");

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

  Future<Map> getItem(id, [double? lat, double? lng]) async {
    Map respuesta;

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

    try {
      // saco los filtros date, time, price, provider_type

      var date = filters["date"];
      var time = filters["time"];
      var price = filters["price"];
      var providerType = filters["provider_type"];
      var sortBy = filters["sortBy"];
      var hour = filters["hour"];

      var day = filters["day"];

      // hago la peticion

      print(
          "/users-permissions/proveedores/?lat=$lat&lng=$lng&distance=$distance&date=$date&time=$time&price=$price&provider_type=$providerType&sortBy=$sortBy&hour=$hour&day=$day");

      final response = await dio.get(
          "/users-permissions/proveedores/?lat=$lat&lng=$lng&distance=$distance&date=$date&time=$time&price=$price&provider_type=$providerType&sortBy=$sortBy&hour=$hour&day=$day");

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

  Future<Map> getProvider(int id, [lat = false, lng = false]) async {
    Map respuesta;

    try {
      //
      // hago la peticion

      final response =
          await dio.get("/users-permissions/proveedores/$id?lat=$lat&lng=$lng");

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

  Future<Map> meTask(status) async {
    Map respuesta;

    try {
      // hago la peticion

      final response =
          await dio.get('/task-assigneds?filters[status][\$eq]=$status');

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

    try {
      // agrego a dio interceptor para errores

      dio.interceptors.add(
        InterceptorsWrapper(
          onError: (DioException e, errorInterceptorHandler) {
            // Mostrar el mensaje de error
            print('Error: ${e.response?.data ?? e.message}');
          },
        ),
      );

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

// importo conexion_common.dart
}

//getPopularItems

TaskServices auth = TaskServices();
