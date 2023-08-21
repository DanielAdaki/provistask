import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/common/socket.dart';
import 'package:provitask_app/models/pagination/pagination_model.dart';
import 'package:provitask_app/services/notification_services.dart';
import 'package:provitask_app/services/preferences.dart';

final _prefs = Preferences();

class NotificationController extends GetxController {
  final SocketController socket = Get.find<SocketController>();
  final _notificationService = NotificationServices();
  final isLoading = false.obs;

  RxList<Notificaciones> notificaciones = RxList<Notificaciones>.empty();

  final totalNotificaciones = 0.obs;

  final page = 1;

  final limit = 10;

  final pagination = Pagination().obs;

  final isLastPage = false.obs;

  // function InitNotificationController

  initNotificationController() async {
    socket.socket.on('notificationResponse', (data) {
      logger.i('notification');
      logger.i(data);
      notificaciones.add(Notificaciones.fromJson(data));

      final routesNoteNotification = [
        '/notificaciones',
        '/notificaciones/ver',
        '/login',
        '/register',
        '/gps-access',
        '/',
        '/chat/:id',
        '/chat/:id/crearPropusta',
        '/chat/:id/crearTareaProvider',
        '/chat/:id/crearTareaClient',
        '/welcome'
      ];

      if (routesNoteNotification.contains(Get.currentRoute)) {
        return;
      }

      RegExp regExp = RegExp(r'^/chat/\d+$');

      if (regExp.hasMatch(Get.currentRoute)) {
        return;
      }
      totalNotificaciones.value = totalNotificaciones.value + 1;
    });

    await getitems();

    // listen para escuchart el total de notificaciones

    socket.socket.on('countNotifications', (data) {
      if (data != null) {
        totalNotificaciones.value = data['count'];
      }
    });

    // funcion para obtener las notificaciones
  }

  // funcion para marcar como leida una notificacion

  Future<void> markAsRead(int id) async {
    isLoading.value = true;
    try {
      await _notificationService.markAsRead(id);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> getitems([int page = 1, int limit = 10]) async {
    try {
      final respuesta = await _notificationService.getItems(page, limit);

      if (respuesta['status'] != 200) {
        throw respuesta['data'];
      } else {
        final data = respuesta["data"];

        Logger().i(data);

        pagination.value = Pagination.fromJson(data["meta"]["pagination"]);

        if (pagination.value.lastPage == pagination.value.page) {
          isLastPage.value = true;
        } else {
          page = pagination.value.page + 1;
          isLastPage.value = false;
        }

        final List<Notificaciones> aux = [];

        for (var item in data['data']) {
          aux.add(Notificaciones.fromJson(item));
        }

        notificaciones.addAll(aux);

        totalNotificaciones.value = notificaciones.length;
      }
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  void onClose() {
    socket.socket.off('notificationResponse');
    super.onClose();
  }
}

class Notificaciones {
  int id;
  String title;
  String text;
  String type;
  bool read;
  DateTime datetime;
  String? url;
  String extra;

  Notificaciones({
    required this.id,
    required this.title,
    required this.text,
    required this.type,
    required this.read,
    required this.datetime,
    this.url,
    this.extra = '',
  });

  factory Notificaciones.fromJson(Map<String, dynamic> json) {
    return Notificaciones(
      id: json['id'],
      title: json['title'],
      text: json['text'],
      type: json['type'],
      read: json['read'],
      datetime: DateTime.parse(json['datetime']),
      url: json['url'] ?? '',
      extra: json['extra'] ?? '',
    );
  }
}
