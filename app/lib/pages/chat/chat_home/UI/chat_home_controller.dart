import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/common/socket.dart';
import 'package:provitask_app/pages/chat/chat_conversation/UI/chat_conversation_controller.dart';
//importo el servicio message

import 'package:provitask_app/services/message_services.dart';

final _message = MessageServices();

class ChatHomeController extends GetxController {
  /// INPUTS
  //llamo el socket
  final socket = Get.find<SocketController>();
  final searchChat = Rx<TextEditingController>(TextEditingController());

  final conversation = [].obs;

  final isLoading = false.obs;

  final pagination = {}.obs;

  Future<void> goConversation() async {
    Get.put<ChatConversationController>(ChatConversationController());
    Get.toNamed('/chat_conversation');
  }

  // fuincion para obtener las conversaciones

  getConversation() async {
    final response = await _message.getItems();

    if (response["status"] != 200) {
      // paso a json el body del erro

      // muestro el mensaje de error en un snackbar en la parte inferior de la pantalla y fondo en rojo
      // isLoading.value = false;

      Get.snackbar(
        "Error",
        "Error al obtener las conversaciones",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      // lleno el listado de categorias con el resultado de la consulta

      conversation.value = [];
    }

    // imprimo el tipo de dato que devuelve la consulta

    conversation.value = response["data"]["data"];

    // pagination.value = response["data"]["data"]["meta"]["pagination"];
  }

  @override
  void onInit() async {
    await getConversation();

    super.onInit();
  }
}
