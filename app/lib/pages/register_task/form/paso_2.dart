import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_controller.dart';

import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_widgets.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class RegisterTaskPage2 extends GetView<RegisterTaskController> {
  final _widgets = RegisterTaskWidget();
  final _controller = Get.find<RegisterTaskController>();

  RegisterTaskPage2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: const HomeMainAppBar(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        drawerEnableOpenDragGesture: false,
        backgroundColor: Colors.white,
        body: Scrollbar(
          thickness: 3, // Ajusta el grosor de la barra de desplazamiento
          radius: const Radius.circular(3),
          child: SafeArea(
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
                              _widgets.registerTaskTopBar(2),
                              const SizedBox(
                                height: 30,
                              ),
                              Obx(
                                () => Column(
                                  children: [
                                    _widgets.franjaInformativa(
                                        "Choose your task date and start time",
                                        0xFFFFFFFF,
                                        0xFF3828a8,
                                        15,
                                        18,
                                        30,
                                        false,
                                        "center"),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    _widgets.selectData(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    _widgets.selectDataRangeTime(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // boton que ocupe toda la pantalla y que diga Or select a specific time y al pinchar
                                    _widgets.franjaInformativaFlecha(
                                        "Or select a specific time",
                                        0xFFFFFFFF,
                                        0xFF3828a8,
                                        15,
                                        18,
                                        30,
                                        false,
                                        "center",
                                        20,
                                        0xFFFFFFFF,
                                        Icons.watch_later_sharp,
                                        null),

                                    Row(
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.only(
                                                left: 20, top: 20),
                                            width: Get.width * 0.4,
                                            child: Align(
                                              alignment: Alignment
                                                  .centerLeft, // Alineación a la izquierda del DropdownButtonFormField
                                              child: DropdownButtonFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(50),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFDD7813),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFDD7813),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(50),
                                                    ),
                                                  ),
                                                  filled: true,
                                                  fillColor: Color(0xFFDD7813),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 15,
                                                  ),
                                                ),
                                                dropdownColor:
                                                    const Color(0xFFDD7813),
                                                value: _controller
                                                    .filters['hour'].value,
                                                items: _controller.arrayHours
                                                    .map(
                                                      (hour) =>
                                                          DropdownMenuItem(
                                                        value: hour,
                                                        child: Text(
                                                          hour,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (value) {
                                                  _controller.filters['hour']
                                                      .value = value.toString();

                                                  _controller
                                                      .filters['time_of_day']
                                                      .value = '';

                                                  _controller.formStepThree
                                                      .value = 0.5;
                                                },
                                              ),
                                            )
                                            // Agrega un Container vacío si _controller.disponibility está vacío
                                            ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, top: 20),
                                      width: Get.width * 0.9,
                                      child: const Text(
                                        'You can chat with your Provider, adjust task details or change task time after booking',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 20),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          width: Get.width * 0.9,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 5,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Request for:',
                                                  style: TextStyle(
                                                    color: Colors.indigo[800],
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                margin: const EdgeInsets.only(
                                                    top: 5),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      _controller.dateResume(),
                                                      style: const TextStyle(
                                                        fontSize: 28,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color:
                                                            Color(0XFF2B1B99),
                                                      ),
                                                    ),

                                                    // This provider requieres 1 hour min

                                                    // boton Select & continue
                                                  ],
                                                ),
                                              ),
                                              /*Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                alignment: Alignment.centerLeft,
                                                child: const Text(
                                                  'This provider requieres 1 hour min',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),*/
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 10),
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xFFDD7813),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        ProgressDialog pd =
                                                            ProgressDialog(
                                                                context: Get
                                                                    .context);

                                                        try {
                                                          pd.show(
                                                            max: 100,
                                                            msg:
                                                                'Please wait...',
                                                            progressBgColor:
                                                                Colors
                                                                    .transparent,
                                                          );

                                                          await _controller
                                                              .findProviders();

                                                          pd.close();

                                                          if (_controller
                                                              .listProviders
                                                              .isEmpty) {
                                                            // muestro un snackbar con el mensaje de que no hay providers disponibles en ese horario en l aparte de abajo

                                                            Get.snackbar(
                                                              'No providers available',
                                                              'Please try another time',
                                                              backgroundColor:
                                                                  Colors.white,
                                                              colorText:
                                                                  Colors.black,
                                                              snackPosition:
                                                                  SnackPosition
                                                                      .BOTTOM,
                                                            );
                                                          } else {
                                                            Get.toNamed(
                                                                '/register_task/step3');
                                                          }

                                                          /*  Get.toNamed(
                                                            '/register_task/step4');*/
                                                        } catch (e) {
                                                          Logger().e(e);
                                                          pd.close();
                                                        }
                                                      },
                                                      child: const Text(
                                                        'Continue',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .library_add_check_rounded,
                                                      color: Color(0XFF2B1B99),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'Next confirm your details to get connected with your provider',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
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
      ),
    );
  }
}
