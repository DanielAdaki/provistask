import 'package:get/get.dart';
import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/services/preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final _prefs = Preferences();

class SocketController extends GetxController {
  late IO.Socket socket;

  @override
  void onInit() {
    // Inicializar socket en el método onInit()
    socket = IO.io(ConexionCommon.hostBase, <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
      'query': {'token': _prefs.token}
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
}

Function getToken = () {
  return _prefs.token;
};
