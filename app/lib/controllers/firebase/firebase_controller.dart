// importo el paquete de firebase mensajeria
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:provitask_app/pages/notificaciones/notificaciones_page.dart';
import 'package:provitask_app/services/preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseController extends GetxController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  final Preferences prefs = Preferences();

  final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();

  final notificationCount = 0.obs;

  Future<void> initNotifications() async {
    // pido permiso para recibir notificaciones

    final token = await _firebaseMessaging.getToken();
    if (token != null) {
      prefs.fcmToken = token;
      // imprimo
      print('FCM Token: $token');
    }

    initPushNotifications();
    initLocalNotifications();
  }

  Future<int> getUnreadNotificationCount() async {
    final notifications = await getNotifications();

    if (notifications == null) return 0;

    int unreadCount = 0;

    for (final notification in notifications) {
      if (notification.channelId == 'high_importance_channel') {
        unreadCount++;
      }
    }

    return unreadCount;
  }

  Future initPushNotifications() async {
    // pido permiso para recibir notificaciones
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    final status = await requestNotificationPermission();

    // si no se acepto el permiso, no hago nada

    if (status != AuthorizationStatus.authorized &&
        status != AuthorizationStatus.provisional) {
      return;
    }

    FirebaseMessaging.instance.getInitialMessage().then(handleMessages);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // aplico es listener para cuando la app esta abierta
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        if (message.notification == null) return;

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
        notificationCount.value = await getUnreadNotificationCount();

        _localNotification.show(
          message.notification.hashCode,
          message.notification!.title,
          message.notification!.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_stat_logo',
            ),
          ),
        );
      },
    );
  }

  Future<AuthorizationStatus> requestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // imprimo
      print('User granted permission');

      // Marcar en las preferencias que se permiten notificaciones

      prefs.allowNotifications = true;
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // imprimo
      print('User granted provisional permission');

      // Marcar en las preferencias que se permiten notificaciones

      prefs.allowNotifications = true;
    } else {
      // imprimo
      print('User declined or has not accepted permission');

      // Marcar en las preferencias que no se permiten notificaciones

      prefs.allowNotifications = false;
    }

    return settings.authorizationStatus;
  }

  Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings android =
        AndroidInitializationSettings('@drawable/ic_stat_logo');

    const DarwinInitializationSettings iOS = DarwinInitializationSettings();

    const InitializationSettings initSetttings =
        InitializationSettings(android: android, iOS: iOS);

    await _localNotification.initialize(initSetttings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notification) async {
      if (notification.payload == null || notification.payload == "") return;
      final message = RemoteMessage.fromMap(jsonDecode(notification.payload!));

      handleMessages(message);
    });

    if (Platform.isAndroid) {
      final platform = _localNotification.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await platform?.createNotificationChannel(_androidChannel);
    } else if (Platform.isIOS) {
      final platform = _localNotification.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
    }
  }

  void cancelAllNotifications() {
    _localNotification.cancelAll();
  }

  // obtengo todas las notificaciones

  Future<List<ActiveNotification>?> getNotifications() async {
    final notifications = await _localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();
    return notifications;
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) {
  Get.to(
    const NotificacionesPage(),
    arguments: message,
  );
  return Future<void>.value();
}

void handleMessages(RemoteMessage? message) {
  if (message == null) return;

  // manod a la pagina de notificaciones con el mensaje como argumento

  Get.toNamed('/notificaciones', arguments: message);
}
