import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './controllers/provistask_app_bar_controller.dart';

class HomeDrawer extends GetView<ProvitaskAppBarController>
    implements PreferredSizeWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Image.asset(
              'assets/images/logo3.png',
              width: Get.width * 0.4,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.indigo[900],
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Colors.indigo[900],
              ),
            ),
            onTap: () => Get.back(),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.indigo[900],
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: Colors.indigo[900],
              ),
            ),
            onTap: () {
              Get.toNamed('/profile_client');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.message,
              color: Colors.indigo[900],
            ),
            title: Text(
              'Chat',
              style: TextStyle(
                color: Colors.indigo[900],
              ),
            ),
            onTap: () {
              Get.toNamed('/chat_home');
            },
          ),
        ],
      ),
    );
  }
}
