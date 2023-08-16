// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'utility/fix_https.dart';
import 'package:provitask_app/services/preferences.dart';
import 'package:provitask_app/pages/pages.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // var path = Directory.current.path;

  // Hive
  //   ..init(path)
  //   ..registerAdapter();

  localNotificationsPlugin.initialize(initSetttings);

  //await initHiveForFlutter();

  Preferences prefs = Preferences();

  await prefs.init();

  HttpOverrides.global = MyHttpOverrides();
  initializeDateFormatting('en').then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
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
        GetPage(name: '/welcome', page: () => WelcomePage()),
        GetPage(
            name: '/home',
            page: () => HomePage(),
            transition: Transition.rightToLeftWithFade),
        GetPage(
            name: '/login',
            page: () => LoginPage(),
            transition: Transition.rightToLeftWithFade),
        GetPage(
            name: '/profile_client',
            page: () => ProfileClientPage(),
            children: [
              GetPage(name: '/payments_methods', page: () => PaymentPerfil()),
              GetPage(name: '/edit-skills', page: () => EditSkills()),
              GetPage(name: '/edit-vehicles', page: () => VehiclesProvider()),
              GetPage(name: '/edit-about', page: () => AboutProvider()),
              GetPage(
                  name: '/edit-services-location', page: () => MapServices()),
            ]),
        GetPage(
          name: '/edit-perfil',
          page: () => EditPerfil(),
        ),
        GetPage(name: '/edit-password', page: () => ChangePassword()),
        GetPage(
            name: '/register_client',
            page: () => RegisterClientPage(),
            transition: Transition.rightToLeftWithFade),
        GetPage(
            name: '/register_provider',
            page: () => RegisterProviderPage(),
            children: [
              GetPage(name: '/step2', page: () => RegisterProviderPage2()),
              GetPage(name: '/step3', page: () => RegisterProviderPage3()),
              GetPage(name: '/step4', page: () => RegisterProviderPage4()),
              GetPage(name: '/step5', page: () => RegisterProviderPage5()),
              GetPage(name: '/step6', page: () => RegisterProviderPage6()),
              GetPage(name: '/step7', page: () => RegisterProviderPage7()),
              GetPage(name: '/step8', page: () => RegisterProviderPage8()),
              GetPage(name: '/step9', page: () => RegisterProviderPage9()),
            ]),
        GetPage(name: '/payment-methods', page: () => PaymentMethodsPage()),
        GetPage(
            name: '/verification_provider',
            page: () => VerificationProviderPage()),
        GetPage(name: '/profile_provider', page: () => ProfileProviderPage()),
        GetPage(
            name: '/register_task',
            page: () => RegisterTaskPage(),
            children: [
              GetPage(name: '/step2', page: () => RegisterTaskPage2()),
              GetPage(name: '/step3', page: () => RegisterTaskPage3()),
              GetPage(name: '/step4', page: () => RegisterTaskPage4())
            ]),
        GetPage(name: '/calendar_provider', page: () => CalendarPage()),
        GetPage(name: '/statistics', page: () => StatisticsPageProvider()),
        GetPage(name: '/tasks', page: () => TasksPage()),
        GetPage(name: '/task/:id', page: () => TaskPage()),
        GetPage(name: '/locations', page: () => LocationsPage()),
        GetPage(name: '/freelancers', page: () => FreelancersPage()),
        GetPage(name: '/chat_home', page: () => ChatHomePage()),
        GetPage(
            name: '/home-proveedor',
            page: () => HomePageProvider(),
            children: [
              GetPage(
                  name: '/tareas-pendientes',
                  page: () => PendingPageProvider()),
              /*GetPage(
                  name: '/crearTareaProvider/',
                  page: () => CrearTaskProvider()),
              GetPage(
                  name: '/crearTareaClient/', page: () => CrearTaskClient())*/
            ]),
        GetPage(name: '/task-assing-detail/:id', page: () => TaskPage()),
        GetPage(
            name: '/chat/:id',
            page: () => ChatConversationPage(),
            children: [
              GetPage(
                  name: '/crearPropusta/', page: () => CrearPropuestaChat()),
              GetPage(
                  name: '/crearTareaProvider/',
                  page: () => CrearTaskProvider()),
              GetPage(name: '/crearTareaClient/', page: () => CrearTaskClient())
            ]),
        GetPage(
            name: '/register-payment-success',
            page: () => const RegisterSuccesPage()),
      ],
    );
  }
}

FlutterLocalNotificationsPlugin localNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
AndroidInitializationSettings android =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
DarwinInitializationSettings iOS = const DarwinInitializationSettings();
InitializationSettings initSetttings =
    InitializationSettings(android: android, iOS: iOS);

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

