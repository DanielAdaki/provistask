// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'package:provitask_app/services/preferences.dart';

// importo conexion_common.dart

import 'package:provitask_app/common/conexion_common.dart';

// importo modelo de usuario
final _prefs = Preferences();

final token = _prefs.token;

var logger = Logger();
BaseOptions options = BaseOptions(headers: {
  'content-type': 'application/json',
  'Authorization': 'Bearer $token',
}, baseUrl: ConexionCommon.hostApi);

Dio dio = Dio(options);

class AuthService {
  Future<Map> login(String email, String password) async {
    Map respuesta;

    try {
      Map credentials = {
        "identifier": email,
        "password": password,
      };

      final http.Response response = await http.post(
        Uri.parse("${ConexionCommon.hostApi}/auth/local"),
        headers: {"content-type": "application/json"},
        body: jsonEncode(credentials),
      );

      // reviso el status de la respuesta si es distinto a 200 lanzo error

      if (response.statusCode != 200) {
        throw jsonDecode(response.body);
      }

      logger.d(response.body);

      // mando al modelo

      var aux = jsonDecode(response.body);

      String token = aux["jwt"];

      _prefs.token = token;

      respuesta = {"status": 200, "token": token};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }
    return respuesta;
  }

  Future<Map> register(String name, String email, String password,
      String surname, String postalCode, String phoneNumber) async {
    Map respuesta;
    // uso try catch para capturar errores

    try {
      // creo un map con los datos del usuario

      Map data = {
        "username": email,
        "email": email,
        "password": password,
        "name": name,
        "lastname": surname,
        "postal_code": postalCode,
        "phone": phoneNumber,
        "confirmed": true,
        "provider": "local",
        "role": 1,
      };

      // añado   data a otro map con  nombre data

      Map credentials = {
        "data": data,
      };

      print(jsonEncode(credentials));

      // hago la peticion post a la api

      http.Response response = await http.post(
        Uri.parse("${ConexionCommon.hostApi}/auth/local/register"),
        headers: {"content-type": "application/json"},
        body: credentials,
      );

      // guardo el body de la respuesta en una variable

      var aux = jsonDecode(response.body);

      // retorno el body de la respuesta

      respuesta = aux;
    } catch (e) {
      // e es un string lo vuelvo a convertir en json y lo guardo en el map _respuesta y lo retorno con status 500

      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  Future<Map> forgotPassword(String email) async {
    Map respuesta;
    // uso try catch para capturar errores

    try {
      // creo un map con los datos del usuario

      Map credentials = {
        "email": email,
      };

      // hago la peticion post a la api

      http.Response response = await http.post(
        Uri.parse("${ConexionCommon.hostApi}/auth/forgot-password"),
        headers: {"content-type": "application/json"},
        body: jsonEncode(credentials),
      );

      // guardo el body de la respuesta en una variable

      var aux = jsonDecode(response.body);

      // retorno el body de la respuesta

      respuesta = aux;
    } catch (e) {
      // e es un string lo vuelvo a convertir en json y lo guardo en el map _respuesta y lo retorno con status 500

      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  Future<Map> resetPassword(
      String code, String password, String passwordConfirmation) async {
    Map respuesta;
    // uso try catch para capturar errores

    try {
      // creo un map con los datos del usuario

      Map credentials = {
        "code": code,
        "password": password,
        "passwordConfirmation": passwordConfirmation,
      };

      // hago la peticion post a la api

      http.Response response = await http.post(
        Uri.parse("${ConexionCommon.hostApi}/auth/reset-password"),
        headers: {"content-type": "application/json"},
        body: jsonEncode(credentials),
      );

      // guardo el body de la respuesta en una variable

      var aux = jsonDecode(response.body);

      // retorno el body de la respuesta

      respuesta = aux;
    } catch (e) {
      // e es un string lo vuelvo a convertir en json y lo guardo en el map _respuesta y lo retorno con status 500

      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  Future<Map> me() async {
    Map respuesta;

    // uso try catch para capturar errores

    try {
      //  obtengo el token del shared preferencesç

      // configuro dio para que use el token en el header

      // hago la peticion get a la api a la ruta /users/me

      final response = await dio.get("/users/me?populate=*");

      if (response.statusCode != 200) {
        throw jsonDecode(response.data);
      }

      // imprimo la respuesta

      final user = response.data;

      // mando el uyser al modelo

      _prefs.user = user;

      logger.d(_prefs.user);

      // imprimo el user del shared preferences par adebug

      // guardo la respuesta en el map _respuesta y lo retorno con status 200

      respuesta = {"status": 200, "data": response.data};

      // hago la peticion get a la api a la ruta /users/me
    } catch (e) {
      // e es un string lo vuelvo a convertir en json y lo guardo en el map _respuesta y lo retorno con status 500

      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  Future<Map> updateAvatar(image) async {
    Map respuesta;
    try {
      List<int> imageBytes = await image.readAsBytes();
      FormData formData = FormData.fromMap({
        "ref": "plugin::users-permissions.user",
        "refId": _prefs.user?["id"],
        "field": "avatar_image",
        "files": MultipartFile.fromBytes(imageBytes,
            filename: image.path.split("/").last),
      });

      final response = await dio.post("/upload", data: formData);

      if (response.statusCode != 200) {
        throw jsonDecode(response.data);
      }

      respuesta = {"status": 200, "data": response.data};
    } catch (e) {
      // e es un string lo vuelvo a convertir en json y lo guardo en el map _respuesta y lo retorno con status 500

      respuesta = {"status": 500, "error": e};
    }
    return respuesta;
  }

  Future<Map> updateProfile(String name, String surname, String email,
      String phone, String zipCode) async {
    Map respuesta;

    try {
      final id = _prefs.user?["id"];

      if (id == null) {
        throw "No se encontro el id del usuario";
      }

      final response = await dio.put("/users/$id", data: {
        "name": name,
        "lastname": surname,
        "email": email,
        "phone": phone,
        "postal_code": zipCode,
      });
      // configuro dio para que use el token en el header

      respuesta = {"status": 200, "data": response.data};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  Future<Map> updatePassword(
      String otp, String password, String confirmation) async {
    Map respuesta;

    try {
      if (password == null || confirmation == null || otp == null) {
        throw "Incomplete data, check the entered data";
      }

      if (password != confirmation) {
        print("password: $password");
        print("confirmation: $confirmation");
        throw "The passwords do not match";
      }

      final response = await dio.post("/users/otp/change-password/", data: {
        "email": _prefs.user?["email"] ?? "",
        "otp": otp,
        "password": password,
      });

      logger.i(response.headers);

      respuesta = {"status": 200, "data": response.data};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  Future<Map> requestResetPassword([String? text]) async {
    Map respuesta;

    try {
      if (text == null) {
        throw "No se encontro el email del usuario";
      }

      final response = await dio.post("/users/otp/", data: {
        "email": text,
      });

      logger.i(response.headers);

      respuesta = {"status": 200, "data": response.data};
    } catch (e) {
      logger.e(e);
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  Future<Map> verifyOtp(String value) async {
    Map respuesta;

    try {
      final response = await dio.post("/users/otp/verify", data: {
        "otp": value,
        "email": _prefs.user?["email"],
      });

      respuesta = {"status": 200, "data": response.data};
    } catch (e) {
      logger.e(e);
      logger.e(e.toString());
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  // consultar metadata del usuario logueado

  Future<Map> getMetadata() async {
    Map respuesta;

    try {
      final id = _prefs.user?["id"];

      if (id == null) {
        throw "No se encontro el id del usuario";
      }

      final response = await dio.get("/meta-users/$id");

      respuesta = {"status": 200, "data": response.data};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  // actualizar metadata del usuario logueado

  Future<Map> upMeta(Map data, int id) async {
    Map respuesta;

    try {
      if (id == null) {
        throw "No se encontro el id del usuario";
      }

      // la url es /meta-users/id USO interpolacion de strings

      // dio.interceptors.add(LogInterceptor(responseBody: true));

      final dato = {"data": data};

      final response = await dio.post("/meta/me", data: dato);

      respuesta = {"status": 200, "data": response.data};
    } catch (e) {
      Logger().e(e);
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  // crear metadata del usuario logueado

  Future<Map> createMetadata(Map data) async {
    Map respuesta;

    try {
      final id = _prefs.user?["id"];

      if (id == null) {
        throw "No se encontro el id del usuario";
      }

      // sumo el id del usuario al map data

      data["user"] = id;

      final dato = {"data": data};

      final response = await dio.post("/meta-users", data: dato);

      respuesta = {"status": 200, "data": response.data};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  Future<Map> updateUser(Map data) async {
    Map respuesta;

    try {
      final id = _prefs.user?["id"];

      if (id == null) {
        throw "No se encontro el id del usuario";
      }

      final response = await dio.put("/users/$id", data: data);
      // configuro dio para que use el token en el header

      respuesta = {"status": 200, "data": response.data};
    } catch (e) {
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }

  void logout() {
    _prefs.token = "";
    _prefs.user = {};
  }

  Future<Map> createStripeAccountConnet() async {
    Map respuesta;

    try {
      dio.interceptors.add(LogInterceptor(responseBody: true));
      final response = await dio.get("/users-permissions/connet-stripe");
      // configuro dio para que use el token en el header

      respuesta = {"status": 200, "data": response.data};
    } catch (e) {
      print(e);
      respuesta = {"status": 500, "error": e};
    }

    return respuesta;
  }
}

AuthService auth = AuthService();
