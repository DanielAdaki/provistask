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
        appBar: const HomeMainAppBar(),
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
                        _widget.titleGenerate(_controller
                                .taskDetail.value.isNotEmpty
                            ? _controller.taskDetail.value["attributes"]["name"]
                            : ""),
                        _widget.imageTask(
                            _controller.taskDetail.value.isNotEmpty
                                ? _controller.taskDetail.value["attributes"]
                                    ["image"]["data"]["attributes"]["url"]
                                : ""),
                        _widget.priceTask(
                            _controller.taskDetail.value.isNotEmpty
                                ? _controller
                                    .taskDetail.value["attributes"]["price"]
                                    .toString()
                                : ""),
                        _controller.provider.value["name"] != null
                            ? _widget.proviData(
                                _controller.provider.value["name"] +
                                        " " +
                                        _controller
                                            .provider.value["lastname"] ??
                                    "",
                                _controller.provider.value["type_provider"],
                                _controller.provider.value["cost_per_houers"],
                                _controller.provider.value["distanceGoogle"]
                                    .toString(),
                                _controller.provider.value["scoreAverage"]
                                    .toString(),
                                _controller.provider.value["open_disponibility"]
                                    .toString(),
                                _controller
                                    .provider.value["close_disponibility"]
                                    .toString(),
                                _controller.provider.value["skills"],
                                _controller.provider.value["car"],
                                _controller.provider.value["truck"],
                                _controller.provider.value["motorcycle"],
                                Random().nextInt(100).toString())
                            : Container(),
                        _widget.descriptionTask(
                            _controller.taskDetail.value.isNotEmpty
                                ? _controller.taskDetail.value["attributes"]
                                    ["description"]
                                : ""),

                        const SizedBox(
                          height: 30,
                        ),
                        _controller.provider.value != null
                            ? _widget
                                .buttonContact(_controller.provider.value["id"])
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
