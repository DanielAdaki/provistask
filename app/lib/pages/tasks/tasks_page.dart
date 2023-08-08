import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/components/spinner.dart';
import 'package:provitask_app/pages/tasks/UI/tasks_controller.dart';
import 'package:provitask_app/pages/tasks/UI/tasks_widgets.dart';
import 'package:provitask_app/components/main_app_bar.dart';

class TasksPage extends GetView<TasksController> {
  final _widgets = TasksWidgets();

  TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButton: _widgets.tasksFloatingButton(),
        appBar: const HomeMainAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: const ProvitaskBottomBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.isLoading.value = true;
            await Future.wait<void>([
              controller.getTasks(),
            ]);
            controller.isLoading.value = false;
          },
          child: controller.isLoading.value == true
              ? const SpinnerWidget()
              : SingleChildScrollView(
                  child: SafeArea(
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          _widgets.tasksTitleTop(),
                          const SizedBox(
                            height: 20,
                          ),
                          _widgets.tasksSelectionType(),

                          if (controller.tasks.isEmpty)
                            _widgets.tasksNoCompleted(),

                          // caso contrario else

                          if (controller.tasks.isNotEmpty)
                            SizedBox(
                              height: Get.height * 0.6,
                              child: Center(
                                child: ListView(
                                  children: List.generate(
                                    controller.tasks.length,
                                    (index) => _widgets
                                        .taskProCard(controller.tasks[index]),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
