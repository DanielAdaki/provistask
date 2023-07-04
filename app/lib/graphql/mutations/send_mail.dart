import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provitask_app/graphql/mutations/update_client.dart';
import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/models/data/client_information.dart';
import 'package:provitask_app/utility/utiity_methods.dart';

class SendMail {
  // Server's call to get data
  static Future<Map<String, dynamic>> _serverCall(
      String endpointName, Map<String, dynamic> data) async {
    // Headers
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // Content
    String body = jsonEncode(data);
    // Response
    Map<String, dynamic> dataResponse = {};
    try {
      dataResponse = await http
          .post(Uri.parse(ConexionCommon.hostBase + endpointName),
              body: body, headers: headers)
          .then((data) => json.decode(utf8.decode(data.bodyBytes)));
    } catch (e) {
      Get.snackbar(
        'Error',
        'Invalid email or password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        borderColor: Colors.red,
        borderWidth: 2,
      );
    }
    return dataResponse;
  }

  // Method to send email with code
  static Future<bool> forgotPassword() async {
    String code = UtilityMethods.randomCode();

    bool updCode = await UpdateClient.run(forgotCode: code);

    if (updCode) {
      Map<String, dynamic> data = await _serverCall('forgot-password',
          {"toEmail": ClientInformation.clientEmail, "code": code});
      print(data);
    }
    return Future.value(true);
  }
}
