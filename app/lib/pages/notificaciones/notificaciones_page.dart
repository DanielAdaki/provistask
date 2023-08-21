import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/main_drawer.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/controllers/notification/notification_controller.dart';
import 'package:provitask_app/widget/notificaciones/notifiaciones_modal_widget.dart';

class NotificacionesPage extends GetView<NotificationController> {
  const NotificacionesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: HomeMainAppBar(),
        drawer: const HomeDrawer(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        body: Scrollbar(
          thickness: 2,
          radius: const Radius.circular(3),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: Get.width * 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.notificaciones.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: formatTypeNotification(
                              controller.notificaciones[index].type),
                          title: Text(controller.notificaciones[index].title),
                          subtitle: Text(controller.notificaciones[index].text),
                          trailing: controller.notificaciones[index].read ==
                                  true
                              ? const Icon(Icons.check_circle,
                                  color: Colors.green)
                              : const Icon(Icons.circle, color: Colors.grey),
                          onTap: () async {
                            // busco en el array de notificaciones la que tiene el id

                            final notification = controller.notificaciones
                                .firstWhere((element) =>
                                    element.id ==
                                    controller.notificaciones[index].id);

                            // si la notificacion no esta leida la marco como leida

                            if (notification.read == false) {
                              await controller.markAsRead(notification.id);

                              // marco como leida la notificacion en el array

                              notification.read = true;

                              // actualizo el controlador

                              controller.notificaciones.refresh();
                            }

                            Get.dialog(Dialog(
                              insetPadding: const EdgeInsets.all(0),
                              child: NotificationDetailsModal(
                                notification: controller.notificaciones[index],
                              ),
                            ));
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  formatTypeNotification(String type) {
    switch (type) {
      case 'message':
        return const Icon(Icons.chat);
      case 'task':
        return const Icon(Icons.task);
      case 'proposal':
        return const Icon(Icons.assignment);
      default:
        return const Icon(Icons.notifications);
    }
  }
}
