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

  final selectedSkill = "Bookshelf Assembly".obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;

    // tomo el id de la conversacion que viene en la ruta como parametros

    id.value = Get.parameters['id'] ?? '';
    await getTaskConversation();
    _socketController.socket.emit('join', {
      "id": id.value
    }); // me uno a la sala de chat con el id de la conversacion

    _socketController.socket.emit(
        'getChat', {"id": id.value, "limit": 10, "page": 1, "init": true});

    // espero dos segundos

    _socketController.socket.once('getChatResponse', (data) async {
      user.value = data["otherUser"];

      // recorro los mensajes y voy asignaod una a una

      for (var i = 0; i < data["mensajes"].length; i++) {
        final mess = types.Message.fromJson(data["mensajes"][i]);

        messages.add(mess);
      }
      isLoading.value = false;
    });
    _socketController.socket.on('sendMessageResponse', (data) async {
      final mess = types.Message.fromJson(data as Map<String, dynamic>);

      messages.insert(0, mess);
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

      // verifico el tamaño de la imagen no sea mayor a 20 mb

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

      Logger().i("TAMAÑO IMAGEN", image);

      final message = types.ImageMessage(
          author: types.User(id: prefs.user!["id"].toString()),
          createdAt: DateTime.now().millisecondsSinceEpoch,
          height: image.height.toDouble(),
          id: idImage,
          name: result.name,
          size: bytes.length,
          uri: result.path,
          width: image.width.toDouble(),
          roomId: id.value);

      messages.insert(0, message);

      _addMessage(message);
    }
  }

  _addMessage(types.Message message) {
    // messages.insert(0, message);

    _socketController.socket.emit('sendMessage', message);
  }

  handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: types.User(id: prefs.user!["id"].toString()),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
        roomId: id.value,
      );

      _addMessage(message);
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
    );

    _addMessage(textMessage);
  }

  Future acceptProposal(id) async {
    await _services.acceptProposal(id);

    // muestro un snackbar con el error en la parte de abajo
  }

  Future<void> handleEndReached() {
    // si el total de mensajes es menor al total de mensajes de la paginacion

    _socketController.socket.emit('getChat',
        {"id": id.value, "limit": limit, "page": page, "init": true});

    _socketController.socket.once('getChatResponse', (data) async {
      messages.clear();

      for (var i = 0; i < data["mensajes"].length; i++) {
        final mess = types.Message.fromJson(data["mensajes"][i]);

        messages.add(mess);
      }
    });

    return Future.value();
  }
}
