// ceo la clase NotificacionConfigPage extendiendo GetView

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/components/spinner.dart';
import 'package:provitask_app/controllers/firebase/firebase_controller.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';
import 'package:provitask_app/pages/profile_client/UI/profile_client_widgets.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:provitask_app/pages/tasks/UI/tasks_widgets.dart';

class NotificacionConfigPage extends GetView<ProfileController> {
  NotificacionConfigPage({Key? key}) : super(key: key);

  final _widgets = ProfileClientWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _widgets.profileAppBar(context, ""),
      backgroundColor: Colors.white,
      drawer: _widgets.homeDrawer(),
      bottomNavigationBar: const ProvitaskBottomBar(),
      body: controller.isLoading.value == true
          ? const SpinnerWidget()
          : Scrollbar(
              thickness: 3, // Ajusta el grosor de la barra de desplazamiento
              radius: const Radius.circular(3),
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Notifications Settings',
                          style: TextStyle(
                            color: Color(0xff170591),
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Select the notifications you want to receive',
                          style:
                              TextStyle(color: Color(0xff868686), fontSize: 13),
                        ),
                        const SizedBox(height: 15),
                        // lista de switches con el nombre de la notificacion a la izquierda y el switch a la derecha

                        ListTile(
                          title: const Text('All notifications'),
                          trailing: ElevatedButton(
                            onPressed: () async {
                              final FirebaseController firebaseController =
                                  Get.find();
                              final status = await firebaseController
                                  .requestNotificationPermission();

                              if (status == AuthorizationStatus.authorized ||
                                  status == AuthorizationStatus.provisional) {
                                Get.bottomSheet(
                                  Container(
                                    height: 100,
                                    color: Colors.white,
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Notifications are enabled',
                                          style: TextStyle(
                                            color: Color(0xff170591),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'You can disable them in your device settings',
                                          style: TextStyle(
                                              color: Color(0xff868686),
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                await NotificationPermissions
                                    .requestNotificationPermissions(
                                  iosSettings: const NotificationSettingsIos(
                                    sound: true,
                                    badge: true,
                                    alert: true,
                                  ),
                                );

                                // verifico si se acepto el permiso

                                final status = await NotificationPermissions
                                    .getNotificationPermissionStatus();

                                if (status == PermissionStatus.granted) {
                                  prefs.allowNotifications = true;

                                  controller.allowNotifications.value = true;

                                  // muestro un mensaje de que se acepto el permiso

                                  Get.bottomSheet(
                                    Container(
                                      height: 100,
                                      color: Colors.white,
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Notifications are enabled',
                                            style: TextStyle(
                                              color: Color(0xff170591),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'You can disable them in your device settings',
                                            style: TextStyle(
                                                color: Color(0xff868686),
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  Get.bottomSheet(
                                    Container(
                                      height: 100,
                                      color: Colors.white,
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Notifications are disabled',
                                            style: TextStyle(
                                              color: Color(0xff170591),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'You can enable them in your device settings',
                                            style: TextStyle(
                                                color: Color(0xff868686),
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );

                                  prefs.allowNotifications = false;

                                  controller.allowNotifications.value = false;
                                }
                              }
                            },
                            child: controller.allowNotifications.value == true
                                ? const Text('Disable')
                                : const Text('Enable'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
