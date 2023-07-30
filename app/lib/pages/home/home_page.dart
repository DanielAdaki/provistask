import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';

import 'package:provitask_app/controllers/home/home_controller.dart';
import 'package:provitask_app/widget/home/home_widget.dart';

import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/main_drawer.dart';

class HomePage extends GetView<HomeController> {
  final _widgets = HomeWidgets();

  //saco listCategory de la clase HomeController

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: const HomeMainAppBar(),
        drawer: const HomeDrawer(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        body: Scrollbar(
          thickness: 2, // Ajusta el grosor de la barra de desplazamiento
          radius: const Radius.circular(3),
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.wait<void>([
                controller.findCategory(),
                controller.findTask(),
                //controller._getPopularTask(),
                //controller._getCategoryHomeSlider(),
              ]);
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
                        height: 30,
                      ),
                      _widgets.titleGenerate('Need help with...'),
                      //añado un spcio entre el titulo y el boton
                      const SizedBox(
                        height: 30,
                      ),
                      _widgets.searchTask(),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 450,
                        width: Get.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //    _widgets.listTasks(),
                          ],
                        ),
                      ),

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
                            _widgets.listCategory(controller.listCategory),
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
                      _widgets.titleGenerate('Popular tasks'),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: Get.height * 0.5,
                        width: Get.width * 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //   _widgets.listPopularTasks(),
                          ],
                        ),
                      ),
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
