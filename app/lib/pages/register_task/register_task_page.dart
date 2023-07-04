import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_controller.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_widgets.dart';
import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/components/main_drawer.dart';

class RegisterTaskPage extends GetView<RegisterTaskController> {
  final _widgets = RegisterTaskWidget();

  final _controller = Get.find<RegisterTaskController>();

  final _controllerLocation = Get.put(LocationController());

  RegisterTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controllerLocation.onInit();
    return Obx(
      () => Scaffold(
        appBar: const HomeMainAppBar(),
        backgroundColor: Colors.white,
        drawer: const HomeDrawer(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        drawerEnableOpenDragGesture: false,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/REGISTER TASK/bg_degraded.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                children: [
                  Visibility(
                    visible: _controller.isLoading.value,
                    child: const Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Visibility(
                      visible: !_controller.isLoading.value,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _widgets.registerTaskTopBar(1),
                            const SizedBox(
                              height: 30,
                            ),
                            Obx(
                              () => Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: DropdownButton<String>(
                                      value: _controller.selectedSkill.value,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: const TextStyle(
                                        color: Color(0xFFDD7813),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                      ),
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          _controller.selectedSkill.value =
                                              newValue;
                                        } else {
                                          _controller.selectedSkill.value =
                                              "No Skill Selected";
                                        }
                                      },
                                      items: <String>{
                                        "Celling Fan Instalation",
                                        "Appliance Removal",
                                        "Baby Food Delivery",
                                        "Accounting Services",
                                        "Bartending",
                                        "Baby Prep",
                                        "Cleaning",
                                        "Bookshelf Assembly"
                                      }.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  _widgets.registerTaskSelectLocation(),
                                  const SizedBox(width: 50),
                                  _controller.formStepOne.value == 0.25 &&
                                          _controllerLocation.selectedAddress ==
                                              ""
                                      ? Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          alignment: Alignment.topLeft,
                                          width: Get.width * 0.9,
                                          padding: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                            color: Color(0xff170591),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                            ),
                                          ),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(width: 10),
                                              Text(
                                                'How long is your task?',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  //fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  _controller.formStepOne.value == 0.25 &&
                                          _controllerLocation.selectedAddress !=
                                              "" &&
                                          _controller.listProviders.isNotEmpty
                                      ? _widgets.registerTaskSelectTimeLong()
                                      : Container(),
                                  _controller.formStepOne.value >= 0.50
                                      ? _widgets.timeLongSelected()
                                      : Container(),
                                  _controller.formStepOne.value >= 0.50
                                      ? _widgets.registerTaskSelectTransport()
                                      : Container(),
                                  _controller.formStepOne.value >= 0.50
                                      ? _widgets.registerTaskTellDetails()
                                      : Container(),
                                  _controller.listProviders.isNotEmpty
                                      ? _widgets.registerContinueButton(
                                          'Continue',
                                          5,
                                          () => _controller.continueForm1(),
                                          bgColor: Colors.indigo[800]!)
                                      : Container(),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
