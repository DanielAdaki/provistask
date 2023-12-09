import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provitask_app/controllers/task/task_controller.dart';
import 'package:provitask_app/widget/tasks/task_widget.dart';
import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/main_drawer.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';

class TaskPageProvider extends GetView<TaskController> {
  final _widget = TaskWidgets();

  TaskPageProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: HomeMainAppBar(),
        drawer: const HomeDrawer(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        body: SafeArea(
          child: controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _widget.titleGenerate(
                                controller.taskDetail.isNotEmpty
                                    ? controller.taskDetail["skill"]["name"]
                                    : ""),
                            _widget.imageTask(controller.taskDetail.isNotEmpty
                                ? controller.taskDetail["skill"]["image"]
                                : ""),

                            _widget.priceTask(controller
                                        .taskDetail["totalPrice"] !=
                                    null
                                ? controller.taskDetail["totalPrice"].toString()
                                : controller.taskDetail["brutePrice"] != null
                                    ? controller.taskDetail["brutePrice"]
                                        .toString()
                                    : controller.taskDetail["netoPrice"] != null
                                        ? controller.taskDetail["netoPrice"]
                                            .toString()
                                        : "500"),

                            _widget.descriptionTask(
                                controller.taskDetail.isNotEmpty
                                    ? controller.taskDetail["description"]
                                    : ""),

                            const SizedBox(
                              height: 30,
                            ),
                            // ignore: unnecessary_null_comparison
                            controller.provider != null
                                ? _widget
                                    .buttonContact(controller.provider["id"])
                                : Container(),
                            const SizedBox(
                              height: 30,
                            ),
                            // Aquí va el contenido de la página
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
