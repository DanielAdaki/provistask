import 'dart:convert';

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

class UploadServices {
  Future<Map> upload(String ref, String refId, String field, file) async {
    Map respuesta;
    try {
      List<int> imageBytes = await file.readAsBytes();
      FormData formData = FormData.fromMap({
        "ref": ref,
        "refId": refId,
        "field": field,
        "files": MultipartFile.fromBytes(imageBytes,
            filename: file.path.split("/").last),
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
}

// defino getItem como una funcion asincrona que retorna un Map

// importo conexion_common.dart

UploadServices upload = UploadServices();
