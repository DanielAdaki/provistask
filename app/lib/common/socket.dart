import 'dart:async';

import 'package:get/get.dart';
import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/services/preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  late IO.Socket socket;

  @override
  void onInit() {
    // Inicializar socket en el método onInit()
    socket = IO.io(ConexionCommon.hostBase, <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
      'query': {'token': Preferences().token}
    });
    socket.connect();
    socket.emit('connection', 'data');
    socket.onConnect((_) {
      print('Connection established');
    });

    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
    super.onInit();
  }

  Future<Map<String, dynamic>> sendMessage(data) {
    Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    // Emitir el evento 'getChat' con el ID del chat
    socket.emit('sendMessage', data);

    // Escuchar el evento 'getChat' y obtener los mensajes
    socket.on('sendMessageResponse', (data) {
      Map<String, dynamic> chatData = data;
      if (!completer.isCompleted) {
        completer.complete(chatData);
      }
    });

    return completer.future;
  }

  Future<Map<String, dynamic>> getChat(id) async {
    // Crear Completer para esperar a que se obtengan los mensajes
    Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    // Emitir el evento 'getChat' con el ID del chat
    socket.emit('getChat', id);

    // Escuchar el evento 'getChat' y obtener los mensajes
    socket.on('getChat', (data) {
      Map<String, dynamic> chatData = data;
      if (!completer.isCompleted) {
        completer.complete(chatData);
      }
    });

    return completer.future;
  }
}
