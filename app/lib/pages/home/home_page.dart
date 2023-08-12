import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/components/spinner.dart';

import 'package:provitask_app/controllers/home/home_controller.dart';
import 'package:provitask_app/pages/freelancers/UI/freelancers_controller.dart';
import 'package:provitask_app/widget/home/home_widget.dart';

import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/main_drawer.dart';
import 'package:provitask_app/widget/home/search_task_widget.dart';
import 'package:provitask_app/widget/provider/provider_card_widget.dart';
import 'package:provitask_app/widget/provider/provider_perfil_dialog.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class HomePage extends GetView<HomeController> {
  final _widgets = HomeWidgets();

  final _controller = Get.put(FreelancersController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: const HomeMainAppBar(),
        drawer: const HomeDrawer(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        body: controller.isLoading.value == true
            ? const SpinnerWidget()
            : Scrollbar(
                thickness: 3, // Ajusta el grosor de la barra de desplazamiento
                radius: const Radius.circular(3),
                scrollbarOrientation: ScrollbarOrientation.right,
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.isLoading.value = true;
                    await controller.getCurrentLocation();
                    await Future.wait<void>([
                      controller.findCategory(),
                      controller.findTask(),
                      controller.getPopularProvider(),
                      //controller._getCategoryHomeSlider(),
                    ]);

                    controller.isLoading.value = false;
                  },
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            _widgets.titleGenerate('Need help with...'),
                            //añado un spcio entre el titulo y el boton
                            const SizedBox(
                              height: 10,
                            ),
                            // añado el widget searchTask SearchTask
                            SearchTask(),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                height: Get.height * 0.5,
                                width: Get.width * 0.9,
                                child: Row(
                                  children: [
                                    _widgets.listTasks(controller.listTask),
                                  ],
                                )),

                            const SizedBox(
                              height: 30,
                            ),
                            _widgets.titleGenerate('What else do you need?'),
                            const SizedBox(
                              height: 30,
                            ),
                            // Agregar Expanded para solucionar el error de overflow
                            SizedBox(
                              height: 250,
                              width: Get.width * 0.9,
                              child: Row(
                                children: [
                                  _widgets
                                      .listCategory(controller.listCategory),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    // le añado color 170591
                                    color: Color(0xFF170591),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),

                            if (controller.categoryHomeSlider.isNotEmpty) ...[
                              // recorro y gebero _widgets.homePublicityCarrousel(controller.categoryHomeSlider)

                              _widgets.homePublicityCarrousel(
                                  controller.categoryHomeSlider)
                            ] else ...[
                              Container()
                            ],

                            const SizedBox(
                              height: 30,
                            ),

                            // añado las
                            _widgets
                                .titleGenerate('Popular providers near you'),
                            const SizedBox(
                              height: 30,
                            ),
                            if (controller.popularProvider.isEmpty) ...[
                              // mensaje indicando que no hay proveedores cercanos
                              const Text('No providers near you'),
                            ] else ...[
                              SizedBox(
                                height: Get.height * 0.4,
                                width: Get.width * 0.9,
                                child: ListView.builder(
                                  // scrollDirection: Axis.horizontal,
                                  itemCount: controller.popularProvider.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        ProgressDialog pd = ProgressDialog(
                                            context: Get.context);
                                        try {
                                          controller.isLoading.value = true;

                                          List<Future> futures = [
                                            _controller.getPerfilProvider(
                                                controller
                                                    .popularProvider[index].id,
                                                true,
                                                null),
                                            // controller.getComments(item.id),
                                          ];

                                          // Ejecutar las funciones en paralelo
                                          await Future.wait(futures);

                                          Get.dialog(
                                            Dialog(
                                              insetPadding:
                                                  const EdgeInsets.all(0),
                                              child: ProfileDialog(
                                                perfilProvider: _controller
                                                    .perfilProvider.value,
                                                idSkill: null,
                                                general: true,
                                              ),
                                            ),
                                          );
                                          controller.isLoading.value = false;
                                        } catch (e) {
                                          controller.isLoading.value = false;
                                        }
                                      },
                                      child: ProviderCard(
                                        provider:
                                            controller.popularProvider[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

// al cargar la pagina se ejecuta el metodo init para cargar las categorias
}
