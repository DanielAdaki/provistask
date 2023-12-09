import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:provitask_app/common/socket.dart';
import 'package:provitask_app/controllers/auth/auth_controller.dart';
import 'package:provitask_app/controllers/firebase/firebase_controller.dart';
import 'package:provitask_app/controllers/location/gps_controller.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';
import 'package:provitask_app/controllers/notification/notification_controller.dart';
import 'package:provitask_app/middlewares/auth_middleware.dart';
import 'package:provitask_app/middlewares/gps_permisses_middleware.dart';
import 'utility/fix_https.dart';
import 'package:provitask_app/services/preferences.dart';
import 'package:provitask_app/pages/pages.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  await SentryFlutter.init((options) {
    options.dsn =
        'https://215b1d8d933cdb799778dc7f7e84e93f@o4506360545411072.ingest.sentry.io/4506360550522880';
    options.tracesSampleRate = 1.0;
  },
      // Init your App.
      appRunner: (() async {
    await initializeAppAndRun();
    initializeDateFormatting('en').then((_) {
      runApp(Phoenix(child: const MyApp()));
    });
  }));
}

Future<void> initializeAppAndRun() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController(), permanent: true);

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      name: 'Provitask',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Preferences prefs = Preferences();
  await prefs.init();

  Get.put(SocketController(), permanent: true);
  Get.put(FirebaseController(), permanent: true);
  Get.put(NotificationController(), permanent: true);
  Get.put(GpsController(), permanent: true);
  await FirebaseController().initNotifications();
  Get.put(LocationController(), permanent: true);
  await LocationController().getUserLocation();
  HttpOverrides.global = MyHttpOverrides();
}

// Agrega esta función para reiniciar la aplicación después del cierre de sesión
Future<void> restartApp() async {
  await Get.deleteAll(force: true);
  await Get.delete<Preferences>(force: true);
  await Get.delete<AuthController>(force: true);
  await Get.delete<SocketController>(force: true);
  await Get.delete<FirebaseController>(force: true);
  await Get.delete<NotificationController>(force: true);
  await Get.delete<GpsController>(force: true);
  await Get.delete<LocationController>(force: true);
  Phoenix.rebirth(Get.context!);
  Get.reset();

  await initializeAppAndRun();
  // Get.offAllNamed('/login');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      theme: ThemeData(
          primaryColor: const Color(0xFF170591),
          primaryColorDark: const Color(0xFF170591),
          scrollbarTheme: ScrollbarThemeData(
              thumbVisibility: MaterialStateProperty.all(true),
              thickness: MaterialStateProperty.all(10),
              thumbColor: MaterialStateProperty.all(const Color(0xFF170591)),
              radius: const Radius.circular(10),
              minThumbLength: 100)),
      defaultTransition: Transition.fade,
      initialBinding: SplashBinding(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashPage()),
        GetPage(
          name: '/welcome',
          page: () => WelcomePage(),
          middlewares: [GpsPermisessMiddleware()],
        ),
        GetPage(
          name: '/gps-access',
          page: () => const GPSAccessScreen(),
        ),
        GetPage(
            name: '/home',
            page: () => HomePage(),
            transition: Transition.rightToLeftWithFade,
            middlewares: [GpsPermisessMiddleware(), AuthMiddleware()]),
        GetPage(
            name: '/login',
            page: () => LoginPage(),
            transition: Transition.rightToLeftWithFade,
            middlewares: [GpsPermisessMiddleware()]),
        GetPage(
            name: '/profile_client',
            page: () => ProfileClientPage(),
            middlewares: [
              GpsPermisessMiddleware(),
              AuthMiddleware()
            ],
            children: [
              GetPage(
                  name: '/notifications',
                  page: () => NotificacionConfigPage(),
                  middlewares: [AuthMiddleware()]),
              GetPage(
                  name: '/payments_methods',
                  page: () => PaymentPerfil(),
                  middlewares: [AuthMiddleware()]),
              GetPage(
                  name: '/edit-skills',
                  page: () => EditSkills(),
                  middlewares: [AuthMiddleware()]),
              GetPage(
                  name: '/edit-vehicles',
                  page: () => VehiclesProvider(),
                  middlewares: [AuthMiddleware()]),
              GetPage(
                  name: '/edit-about',
                  page: () => AboutProvider(),
                  middlewares: [AuthMiddleware()]),
              GetPage(
                  name: '/edit-services-location',
                  page: () => MapServices(),
                  middlewares: [AuthMiddleware()]),
            ]),
        GetPage(
            name: '/edit-perfil',
            page: () => EditPerfil(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/notificaciones',
            page: () => const NotificacionesPage(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/edit-password',
            page: () => ChangePassword(),
            middlewares: [AuthMiddleware()]),
        GetPage(
          name: '/register_client',
          page: () => RegisterClientPage(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
            name: '/register_provider',
            page: () => RegisterProviderPage(),
            middlewares: [
              AuthMiddleware()
            ],
            children: [
              GetPage(
                  name: '/step2',
                  page: () => RegisterProviderPage2(),
                  middlewares: [AuthMiddleware()]),
              GetPage(
                  name: '/step3',
                  page: () => RegisterProviderPage3(),
                  middlewares: [AuthMiddleware()]),
              GetPage(
                  name: '/step4',
                  page: () => RegisterProviderPage4(),
                  middlewares: [AuthMiddleware()]),
              GetPage(
                  name: '/step5',
                  page: () => RegisterProviderPage5(),
                  middlewares: [AuthMiddleware()]),
              GetPage(
                  name: '/step6',
                  page: () => RegisterProviderPage6(),
                  middlewares: [AuthMiddleware()]),
              GetPage(
                  name: '/step7',
                  page: () => RegisterProviderPage7(),
                  middlewares: [AuthMiddleware()]),
              GetPage(
                  name: '/step8',
                  page: () => RegisterProviderPage8(),
                  middlewares: [AuthMiddleware()]),
              GetPage(
                  name: '/step9',
                  page: () => RegisterProviderPage9(),
                  middlewares: [AuthMiddleware()]),
            ]),
        GetPage(
            name: '/payment-methods',
            page: () => PaymentMethodsPage(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/verification_provider',
            page: () => VerificationProviderPage(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/profile_provider',
            page: () => ProfileProviderPage(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/register_task',
            page: () => RegisterTaskPage(),
            middlewares: [
              AuthMiddleware()
            ],
            children: [
              GetPage(
                  name: '/step2',
                  page: () => RegisterTaskPage2(),
                  middlewares: [AuthMiddleware()]),
              GetPage(
                  name: '/step3',
                  page: () => RegisterTaskPage3(),
                  middlewares: [AuthMiddleware()]),
              GetPage(
                  name: '/step4',
                  page: () => RegisterTaskPage4(),
                  middlewares: [AuthMiddleware()])
            ]),
        GetPage(
            name: '/calendar_provider',
            page: () => CalendarPage(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/statistics',
            page: () => StatisticsPageProvider(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/tasks',
            page: () => TasksPage(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/task/:id',
            page: () => TaskPage(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/locations',
            page: () => LocationsPage(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/freelancers',
            page: () => FreelancersPage(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/chat_home',
            page: () => ChatHomePage(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/home-proveedor',
            page: () => HomePageProvider(),
            middlewares: [
              GpsPermisessMiddleware(),
              AuthMiddleware()
            ],
            children: [
              GetPage(
                  name: '/tareas-pendientes',
                  page: () => PendingPageProvider(),
                  middlewares: [AuthMiddleware()]),

              /*GetPage(
                  name: '/crearTareaProvider/',
                  page: () => CrearTaskProvider()),
              GetPage(
                  name: '/crearTareaClient/', page: () => CrearTaskClient())*/
            ]),
        GetPage(
            name: '/task-assing-detail/:id',
            page: () => TaskPage(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/task-assing-detail-provider/:id',
            page: () => TaskPageProvider(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/chat/:id',
            page: () => ChatConversationPage(),
            middlewares: [
              AuthMiddleware()
            ],
            children: [
              GetPage(
                  name: '/crearPropusta/',
                  page: () => CrearPropuestaChat(),
                  middlewares: [AuthMiddleware()]),
              GetPage(
                  name: '/crearTareaProvider/',
                  page: () => CrearTaskProvider()),
              GetPage(
                  name: '/crearTareaClient/',
                  page: () => CrearTaskClient(),
                  middlewares: [AuthMiddleware()])
            ]),
        GetPage(
            name: '/register-payment-success',
            page: () => const RegisterSuccesPage(),
            middlewares: [AuthMiddleware()]),
      ],
    );
  }
}

/*FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
AndroidInitializationSettings android =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
DarwinInitializationSettings iOS = const DarwinInitializationSettings();
InitializationSettings initSetttings =
    InitializationSettings(android: android, iOS: iOS);*/

/*void _showNotification(String titulo, String? contenido,
    FlutterLocalNotificationsPlugin localNotificationsPlugin) async {
  BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
    contenido!,
    htmlFormatBigText: true,
    contentTitle: titulo,
    htmlFormatContentTitle: true,
    summaryText: titulo,
    htmlFormatSummaryText: true,
  );
  AndroidNotificationDetails android = AndroidNotificationDetails('ID', 'NAME',
      priority: Priority.high,
      importance: Importance.max,
      showWhen: false,
      enableVibration: true,
      styleInformation: bigTextStyleInformation);
  DarwinNotificationDetails iOS = const DarwinNotificationDetails();
  NotificationDetails platform =
      NotificationDetails(android: android, iOS: iOS);

  await localNotificationsPlugin.show(1, titulo, contenido, platform);
}*/

