import 'package:get/get.dart';
import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/services/preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final _prefs = Preferences();

class SocketController extends GetxController {
  late IO.Socket socket;

  void initSocket() {
    socket = IO.io(ConexionCommon.hostBase, <String, dynamic>{
      'autoConnect': true, // Desactivar la conexión automática
      'transports': ['websocket'],
      'reconnection': true,
      'query': {'token': '${_prefs.token}'},
    });

    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
    });
  }

  void connectSocket() {
    if (_prefs.token != null) {
      socket.io.options ??= {};
      socket.io.options['query'] = {
        'token': '${_prefs.token}',
      };
    }

    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
    });

    socket.on('disconnect', (_) => print('disconnect'));
  }

  void disconnectSocket() {
    socket.disconnect();
    socket.onDisconnect((_) => print('disconnect'));
  }

  @override
  void onClose() {
    disconnectSocket();
    super.onClose();
  }
}

Function getToken = () {
  return _prefs.token;
};
