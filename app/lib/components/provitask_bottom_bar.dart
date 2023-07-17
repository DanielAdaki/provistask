import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/controllers/provitask_bottom_bar_controller.dart';

// importo pref para obtener el id del usuario

import 'package:provitask_app/services/preferences.dart';

// importo conexion_common.dart

// importo modelo de usuario
final _prefs = Preferences();

final user = _prefs.user;

class ProvitaskBottomBar extends GetView<ProvitaskBottomBarController> {
  const ProvitaskBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: user?["isProvider"] == false
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Get.offNamed('/home');
                    },
                    child: Image.asset(
                      'assets/images/BOTTOM BAR/home.png',
                      height: Get.height * 0.035,
                      color: Get.currentRoute.contains('/home')
                          ? Colors.amber[800]
                          : Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/tasks');
                    },
                    child: Image.asset(
                      'assets/images/BOTTOM BAR/task.png',
                      height: Get.height * 0.035,
                      color: Get.currentRoute.contains('/tasks')
                          ? Colors.amber[800]
                          : Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/freelancers');
                    },
                    child: Icon(
                      Icons.handyman_outlined,
                      color: Get.currentRoute.contains('/freelancers')
                          ? Colors.amber[800]
                          : Colors.grey,
                      size: Get.height * 0.035,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAllNamed('/chat_home');
                    },
                    child: Icon(
                      Icons.chat_outlined,
                      color: Colors.grey,
                      size: Get.height * 0.035,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed('/home-proveedor');
                    },
                    child: Image.asset(
                      'assets/images/BOTTOM BAR/home.png',
                      height: Get.height * 0.035,
                      color: Get.currentRoute.contains('/home-proveedor')
                          ? Colors.amber[800]
                          : Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/calendar_provider');
                    },
                    child: Icon(
                      Icons.calendar_today,
                      size: Get.height * 0.035,
                      color: Get.currentRoute.contains('/calendar_provider')
                          ? Colors.amber[800]
                          : Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/tasks');
                    },
                    child: Icon(
                      Icons.bookmark_outline_rounded,
                      size: Get.height * 0.035,
                      color: Get.currentRoute.contains('/tasks')
                          ? Colors.amber[800]
                          : Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/chat_home');
                    },
                    child: Icon(
                      Icons.chat,
                      size: Get.height * 0.035,
                      color: Get.currentRoute.contains('/chat_home')
                          ? Colors.amber[800]
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
