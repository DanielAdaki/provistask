import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/controllers/notification/notification_controller.dart';

class NotificationDetailsModal extends StatelessWidget {
  final Notificaciones notification;

  NotificationDetailsModal({Key? key, required this.notification})
      : super(key: key);

  final GlobalKey<ScrollableState> _scrollableKey = GlobalKey();

  // key del scaffold

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.close,
            color: Colors.indigo,
          ),
        ),
      ),
      body: Scrollbar(
        key: _scrollableKey,
        thickness: 3,
        radius: const Radius.circular(3),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: Get.width * 1,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    width: Get.width * 0.8,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    // retorno icon de acuerdo al tipo de notificacion y texto
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      verticalDirection: VerticalDirection.down,
                      children: [
                        formatTypeNotification(notification.type),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: Get.width * 0.6,
                          child: Text(
                            notification.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // hora de la notificacion
                  Container(
                    width: Get.width * 0.8,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      notification.datetime.toLocal().toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: Get.width * 0.8,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      notification.text,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),

                  // container de informacion extra

                  if (notification.extra.isNotEmpty)
                    Container(
                      width: Get.width * 0.8,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        notification.extra,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),

                  if (notification.url != null && notification.url!.isNotEmpty)
                    Container(
                      width: Get.width * 0.8,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          Get.offAndToNamed(notification.url!);
                        },
                        child: const Text('ver más'),
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
