import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provitask_app/controllers/task/task_controller.dart';
import 'package:provitask_app/widget/tasks/task_widget.dart';
import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/main_drawer.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';

class TaskPage extends GetView<TaskController> {
  final _widget = TaskWidgets();

  TaskPage({Key? key}) : super(key: key);

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
                            _widget.titleGenerate(controller
                                    .taskDetail.isNotEmpty
                                ? controller.taskDetail["attributes"]["name"]
                                : ""),
                            _widget.imageTask(controller.taskDetail.isNotEmpty
                                ? controller.taskDetail["attributes"]["image"]
                                    ["data"]["attributes"]["url"]
                                : ""),
                            _widget.priceTask(controller.taskDetail.isNotEmpty
                                ? controller.taskDetail["attributes"]["price"]
                                    .toString()
                                : ""),
                            controller.provider["name"] != null
                                ? _widget.proviData(
                                    controller.provider["name"] +
                                            " " +
                                            controller.provider["lastname"] ??
                                        "",
                                    controller.provider["type_provider"],
                                    controller.provider["cost_per_houers"] !=
                                            null
                                        ? controller.provider["cost_per_houers"]
                                            .toString()
                                        : "",
                                    controller.provider["distanceGoogle"]
                                        .toString(),
                                    controller.provider["scoreAverage"]
                                        .toString(),
                                    controller.provider["open_disponibility"]
                                        .toString(),
                                    controller.provider["close_disponibility"]
                                        .toString(),
                                    controller.provider["skills"],
                                    controller.provider["car"],
                                    controller.provider["truck"],
                                    controller.provider["motorcycle"],
                                    Random().nextInt(100).toString())
                                : Container(),
                            _widget.descriptionTask(
                                controller.taskDetail.isNotEmpty
                                    ? controller.taskDetail["attributes"]
                                        ["description"]
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
