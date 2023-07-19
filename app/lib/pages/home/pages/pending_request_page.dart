import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';

import 'package:provitask_app/controllers/home/pending_page_provider_controller.dart';

import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/main_drawer.dart';
import 'package:provitask_app/models/pending_request/pending_request.dart';
import 'package:provitask_app/widget/home/provider/home_provider_widget.dart';

class PendingPageProvider extends GetView<PendingPageController> {
  final _widgets = HomeWidgetsProvider();

  final calendar = MonthSlider();

  //saco listCategory de la clase HomeController

  PendingPageProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: const HomeMainAppBar(),
          drawer: const HomeDrawer(),
          bottomNavigationBar: const ProvitaskBottomBar(),
          body: Scrollbar(
            thickness: 2, // Ajusta el grosor de la barra de desplazamiento
            radius: const Radius.circular(3),

            child: SingleChildScrollView(
              child: SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.getPendingTask();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        _widgets.titleGenerate(
                            "Pending requests", "left", 170591, false),
                        //añado un spcio entre el titulo y el boton
                        const SizedBox(
                          height: 30,
                        ),

                        if (controller.pendingRequest.isEmpty) ...[
                          _widgets.franjaInformativa(
                              "You have no pending requests",
                              0xFF170591,
                              0xFFB8B0E9,
                              10,
                              13,
                              35,
                              false,
                              "left"),
                        ] else ...[
                          // devuelvo un list builder con _widgets.pendingRequestWidget

                          Container(
                            height: Get.height * 0.2,
                            width: Get.width * 1,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: ListView.builder(
                              itemCount: controller.pendingRequest.length,
                              scrollDirection: Axis.horizontal,
                              itemExtent: Get.width * 0.5,
                              addRepaintBoundaries: false,
                              addAutomaticKeepAlives: false,
                              itemBuilder: (context, index) {
                                final PendingRequest pendingRequest =
                                    controller.pendingRequest[index];

                                return _widgets
                                    .pendingRequestWidget(pendingRequest);
                              },
                            ),
                          ),
                        ],
                        const SizedBox(
                          height: 30,
                        ),

                        _widgets.titleGenerate(
                            "Task of the day", "left", 170591, false),
                        const SizedBox(
                          height: 30,
                        ),
                        calendar,

                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

// al cargar la pagina se ejecuta el metodo init para cargar las categorias
}

// class de widgets
