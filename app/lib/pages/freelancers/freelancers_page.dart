import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/components/spinner.dart';
import 'package:provitask_app/pages/freelancers/UI/freelancers_controller.dart';
import 'package:provitask_app/pages/freelancers/UI/freelancers_widgets.dart';
import 'package:provitask_app/components/main_app_bar.dart';

class FreelancersPage extends GetView<FreelancersController> {
  final _widgets = FreelancersWidgets();

  FreelancersPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: const ProvitaskBottomBar(),
        appBar: const HomeMainAppBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.isLoading.value = true;
            await Future.wait<void>([controller.getFreelancers()]);
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
                          _widgets.freelancersTitleTop(),
                          const SizedBox(
                            height: 20,
                          ),
                          _widgets.freelancersSelectionType(),
                          const SizedBox(
                            height: 20,
                          ),
                          if (controller.freelancers.isNotEmpty &&
                              controller.isLoading.value == false) ...[
                            _widgets.freelancersPreviously(),
                          ] else if (controller.freelancers.isEmpty &&
                              controller.isLoading.value == false) ...[
                            _widgets.freelancersEmpty()
                          ] else ...[
                            _widgets.freelancersLoading()
                          ]
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
