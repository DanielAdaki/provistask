import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationsWidgets {
  AppBar locationsAppBar() {
    return AppBar(
      title: Text(
        'Locations',
        style: TextStyle(
          color: Colors.amber[800],
          fontSize: 28,
        ),
      ),
      leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.amber[800],
          )),
      backgroundColor: Colors.white,
      foregroundColor: Colors.amber[800],
      elevation: 8,
      toolbarHeight: Get.height * 0.15,
    );
  }
}
