import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';
import 'package:open_filex/open_filex.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provitask_app/models/pagination/pagination_model.dart';
import 'package:provitask_app/services/message_services.dart';

//llamo las preferencias

// instancio las preferencias

//importo socket de lib common socket

import 'package:provitask_app/common/socket.dart';
import 'package:provitask_app/services/preferences.dart';
import 'package:uuid/uuid.dart';

class ChatConversationController extends GetxController {
  final prefs = Preferences();

  final _services = MessageServices();

  // global kay para el chat

  final GlobalKey<ChatState> chatKey = GlobalKey();

  final id = "".obs;

  final isLoading = false.obs;
  // uso get find para obtener el socket
  final _socketController = Get.find<SocketController>();

  // declaro la variable messages como observable epro de tipo de dato List<types.Message>

  //final messages = <types.Message>[].obs;

  final messages = <types.Message>[].obs;

  final user = {}.obs;

  final task = {}.obs;

  final page = 1.obs;

  final limit = 10.obs;
  final pagination = Pagination().obs;

  final isLastPage = false.obs;

  final selectedSkill = "Bookshelf Assembly".obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;

    // tomo el id de la conversacion que viene en la ruta como parametros

    id.value = Get.parameters['id'] ?? '';
    //await getTaskConversation();
    _socketController.socket.emit('join', {
      "id": id.value
    }); // me uno a la sala de chat con el id de la conversacion

    _socketController.socket.emit(
        'getChat', {"id": id.value, "limit": 10, "page": 1, "init": true});

    // espero dos segundos

    _socketController.socket.once('getChatResponse', (datos) async {
      final data = datos["data"];
      user.value = data["otherUser"];

      pagination.value = Pagination.fromJson(datos["meta"]["pagination"]);

      // es la ultima pagina ???

      isLastPage.value = pagination.value.lastPage == pagination.value.page;

      for (var i = 0; i < data["mensajes"].length; i++) {
        final mess = types.Message.fromJson(data["mensajes"][i]);

        messages.add(mess);
      }
      isLoading.value = false;
    });
    _socketController.socket.on('sendMessageResponse', (data) async {
      final mess = types.Message.fromJson(data as Map<String, dynamic>);

      // busco el mensaje en la lista de mensajes y lo actualizo como enviado

      if (mess.author.id != prefs.user!["id"].toString()) {
        // añaado el mensaje a la lista de mensajes

        messages.insert(0, mess);

        _socketController.socket.emit('messageReceived', {
          "messageId": mess.id,
          "roomId": mess.roomId,
          "userId": prefs.user!["id"].toString()
        });
      } else {
        final index = messages.indexWhere((element) => element.id == mess.id);

        if (index != -1) {
          final updatedMessage = messages[index].copyWith(
            status: types.Status.sent,
          );

          messages[index] = updatedMessage;
        }
      }
    });

    _socketController.socket.on('messageRead', (data) async {
      final index = messages.indexWhere((element) => element.id == data["id"]);

      // si lo encuentro actualizo el estado del mensaje a leido

      if (index != -1) {
        final updatedMessage = messages[index].copyWith(
          status: types.Status.seen,
        );

        messages[index] = updatedMessage;
      }
    });

    _socketController.socket.on('joinResponse', (data) async {
      // si el usuario que se unio es el mismo que el usuario logueado

      if (data["otherUser"] == prefs.user!["id"].toString()) {
        return;
      }

      // marco los mensajes como leidos

      for (var i = 0; i < messages.length; i++) {
        final updatedMessage = messages[i].copyWith(
          status: types.Status.seen,
        );

        messages[i] = updatedMessage;
      }
    });
  }

  getTaskConversation() async {
    Map<String, dynamic> datos =
        await _services.getTaskChat(Get.parameters['id']);

    if (datos["status"] != 200) {
      // muestro un snackbar con el error en la parte de abajo

      Get.snackbar("Error",
          "Hubo un error al recuperar la tarea asociada a la conversación",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);

      return;
    }

    task.value = datos["data"];

    if (datos["data"].isNotEmpty) {
      if (datos["data"]["skill"] != null) {
        selectedSkill.value = datos["data"]["skill"]["name"];
      }
    }
  }

  handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    // verifico el tamaño de la imagen no sea mayor a 10mb

    if (result != null) {
      final bytes = await result.readAsBytes();

      if (bytes.length > 20971520) {
        Get.snackbar("Error", "La imagen no puede ser mayor a 20mb",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);

        return;
      }

      /// mando al servidor la imagen en base64

      final idImage = const Uuid().v4();

      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
          author: types.User(id: prefs.user!["id"].toString()),
          createdAt: DateTime.now().millisecondsSinceEpoch,
          height: image.height.toDouble(),
          id: idImage,
          name: result.name,
          size: bytes.length,
          uri: result.path,
          status: types.Status.sending,
          width: image.width.toDouble(),
          roomId: id.value);

      // file Data

      final fileData = {
        "id": idImage,
        "width": image.width.toDouble(),
        "size": bytes.length,
        "height": image.height.toDouble(),
        "name": result.name,
        "bytes": bytes,
        "mimeType": lookupMimeType(result.path),
      };

      _addMessage(message, fileData);
    }
  }

  _addMessage(types.Message message, [Map fileData = const {}]) {
    messages.insert(0, message);

    _socketController.socket
        .emit('sendMessage', {"message": message, "fileData": fileData});
  }

  handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    // verifico el tamaño de la imagen no sea mayor a 10mb

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);

      final bytes = await file.readAsBytes();

      if (result.files.single.size > 52428800) {
        Get.snackbar("Error", "The file cannot be larger than 50mb",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);

        return;
      }

      /// mando al servidor la imagen en base64

      final idImage = const Uuid().v4();

      final message = types.FileMessage(
          author: types.User(id: prefs.user!["id"].toString()),
          createdAt: DateTime.now().millisecondsSinceEpoch,
          name: result.files.single.name,
          id: idImage,
          uri: result.files.single.path!,
          size: result.files.single.size,
          status: types.Status.sending,
          roomId: id.value);

      final fileData = {
        "id": idImage,
        "size": result.files.single.size,
        "name": result.files.single.name,
        "bytes": bytes,
        "mimeType": lookupMimeType(result.files.single.path!),
      };

      _addMessage(message, fileData);
    }
  }

  handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        try {
          final index =
              messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          messages[index] = updatedMessage;

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          final index =
              messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
              (messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          messages[index] = updatedMessage;
        }
      }

      await OpenFilex.open(localPath);
    }
  }

  void handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    messages[index] = updatedMessage;
  }

  handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: types.User(id: prefs.user!["id"].toString()),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
      roomId: id.value,
      status: types.Status.sending,
    );

    _addMessage(textMessage);
  }

  Future acceptProposal(id) async {
    await _services.acceptProposal(id);

    // muestro un snackbar con el error en la parte de abajo
  }

  Future<void> handleEndReached() async {
    // si el total de mensajes es menor al total de mensajes de la paginacion
    if (page.value == pagination.value.lastPage) {
      return;
    }
    final respuesta =
        await _services.getMessagesChat(id.value, page.value + 1, limit.value);

    if (respuesta["status"] != 200) {
      return;
    }

    final data = respuesta["data"];

    // es la ultima pagina ???

    pagination.value = Pagination.fromJson(data["meta"]["pagination"]);

    // si es la ultima pagina

    if (pagination.value.lastPage == pagination.value.page) {
      isLastPage.value = true;
    } else {
      page.value = pagination.value.page + 1;
      isLastPage.value = false;
    }

    for (var i = 0; i < data["data"]["mensajes"].length; i++) {
      final mess = types.Message.fromJson(data["data"]["mensajes"][i]);

      messages.add(mess);
    }
  }

// dispose del controlador

  @override
  void onClose() {
    super.onClose();
    _socketController.socket.off('sendMessageResponse');
    _socketController.socket.off('getChatResponse');
    _socketController.socket.off('messageRead');
    _socketController.socket.off('joinResponse');
  }
}
