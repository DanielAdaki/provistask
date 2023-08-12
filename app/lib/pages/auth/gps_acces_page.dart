import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provitask_app/controllers/location/gps_controller.dart';

class GPSAccessScreen extends GetView<GpsController> {
  const GPSAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          return !controller.isGpsEnabled.value
              ? const _EnableGpsMessage()
              : const _AccesButton();
        }),
      ),
    );
  }
}

class _AccesButton extends StatelessWidget {
  const _AccesButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Access to gps is required"),
        MaterialButton(
          color: Colors.black,
          shape: const StadiumBorder(),
          elevation: 0,
          splashColor: Colors.transparent,
          onPressed: () {
            final controller = Get.find<GpsController>();
            controller.askGpsAcces();
          },
          child: const Text(
            "Request Access",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'You must enable GPS',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
    );
  }
}
