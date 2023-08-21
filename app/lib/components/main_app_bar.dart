import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/controllers/notification/notification_controller.dart';

import './controllers/provistask_app_bar_controller.dart';
import 'package:provitask_app/services/preferences.dart';

Preferences _preferences = Preferences();

class HomeMainAppBar extends GetView<ProvitaskAppBarController>
    implements PreferredSizeWidget {
  HomeMainAppBar({Key? key}) : super(key: key);

  final NotificationController notificationController =
      Get.find<NotificationController>();

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.indigo[900]),
      toolbarHeight: 80,
      title: Image.asset(
        'assets/images/letras_new.png',
        width: Get.width * 0.2,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // icono de notificaciones con cantidad de notificaciones
            ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.indigo[800]),
                minimumSize: MaterialStateProperty.all(const Size(35, 35)),
                shape: MaterialStateProperty.all<CircleBorder>(
                  const CircleBorder(),
                ),
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              ),
              onPressed: () {
                // limmpio total de notificaciones
                notificationController.totalNotificaciones.value = 0;
                Get.toNamed('/notificaciones');
              },
              child: Obx(
                () => Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    if (notificationController.totalNotificaciones.value > 0)
                      Positioned(
                        top: -2,
                        right: -2,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            notificationController.totalNotificaciones.value
                                .toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.indigo[800]),
                minimumSize: MaterialStateProperty.all(const Size(35, 35)),
                shape: MaterialStateProperty.all<CircleBorder>(
                  const CircleBorder(),
                ),
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              ),
              child: Obx(() {
                // busco el controlador de perfil y obtengo la imagen de perfil

                final imageUrl = _preferences.imageProfile.value;

                if (imageUrl.isNotEmpty) {
                  return CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                  );
                } else {
                  return const Icon(
                    Icons.person,
                    color: Colors.white,
                  );
                }
              }),
              onPressed: () => Get.toNamed('/profile_client'),
            ),
          ],
        )
      ],
    );
  }
}
