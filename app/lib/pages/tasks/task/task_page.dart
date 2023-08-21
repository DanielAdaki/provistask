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
  final _controller = Get.put(TaskController());

  TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: HomeMainAppBar(),
        drawer: const HomeDrawer(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        body: SafeArea(
          child: Column(
            children: [
              Visibility(
                visible: _controller.isLoading.value,
                child: const CircularProgressIndicator(),
              ),
              Expanded(
                child: Visibility(
                  visible: !_controller.isLoading.value,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _widget.titleGenerate(_controller.taskDetail.isNotEmpty
                            ? _controller.taskDetail["attributes"]["name"]
                            : ""),
                        _widget.imageTask(_controller.taskDetail.isNotEmpty
                            ? _controller.taskDetail["attributes"]["image"]
                                ["data"]["attributes"]["url"]
                            : ""),
                        _widget.priceTask(_controller.taskDetail.isNotEmpty
                            ? _controller.taskDetail["attributes"]["price"]
                                .toString()
                            : ""),
                        _controller.provider["name"] != null
                            ? _widget.proviData(
                                _controller.provider["name"] +
                                        " " +
                                        _controller.provider["lastname"] ??
                                    "",
                                _controller.provider["type_provider"],
                                _controller.provider["cost_per_houers"] != null
                                    ? _controller.provider["cost_per_houers"]
                                        .toString()
                                    : "",
                                _controller.provider["distanceGoogle"]
                                    .toString(),
                                _controller.provider["scoreAverage"].toString(),
                                _controller.provider["open_disponibility"]
                                    .toString(),
                                _controller.provider["close_disponibility"]
                                    .toString(),
                                _controller.provider["skills"],
                                _controller.provider["car"],
                                _controller.provider["truck"],
                                _controller.provider["motorcycle"],
                                Random().nextInt(100).toString())
                            : Container(),
                        _widget.descriptionTask(
                            _controller.taskDetail.isNotEmpty
                                ? _controller.taskDetail["attributes"]
                                    ["description"]
                                : ""),

                        const SizedBox(
                          height: 30,
                        ),
                        // ignore: unnecessary_null_comparison
                        _controller.provider != null
                            ? _widget.buttonContact(_controller.provider["id"])
                            : Container(),
                        const SizedBox(
                          height: 30,
                        ),
                        // Aquí va el contenido de la página
                      ],
                    ),
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
