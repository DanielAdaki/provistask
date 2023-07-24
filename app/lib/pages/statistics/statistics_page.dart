import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';

import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/main_drawer.dart';
import 'package:provitask_app/controllers/statistics/statistics_controller.dart';

import 'package:provitask_app/widget/statistics/statistics_widget.dart';

class StatisticsPageProvider extends GetView<StatisticsController> {
  final _widgets = StatisticsWidgetsProvider();

  //saco listCategory de la clase HomeController

  StatisticsPageProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeMainAppBar(),
      drawer: const HomeDrawer(),
      bottomNavigationBar: const ProvitaskBottomBar(),
      body: Scrollbar(
        thickness: 2, // Ajusta el grosor de la barra de desplazamiento
        radius: const Radius.circular(3),

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
                  _widgets.titleGenerate(
                      'My Business Statistics', "center", 170591, false),
                  //añado un spcio entre el titulo y el boton
                  const SizedBox(
                    height: 15,
                  ),

                  _widgets.infoCard(controller.mensualEarning,
                      controller.rateReliability, controller.todayEarning),
                  const SizedBox(
                    height: 30,
                  ),
                  _widgets.barraProgresoMontoMensual(
                      controller.last30DaysProgress,
                      controller.last30DaysEarnings),
                  const SizedBox(
                    height: 30,
                  ),
                  _widgets.infoCardProgreso(
                      controller.currentMetricsResponse,
                      controller.currentMetricsAcceptance,
                      controller.currentMetricsRejection),
                  const SizedBox(
                    height: 30,
                  ),
                  _widgets.franjaInformativa(
                      "Work to keep your customers satisfied",
                      0xFF170591,
                      0xFFB8B0E9,
                      10,
                      13,
                      35,
                      false,
                      "left"),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// al cargar la pagina se ejecuta el metodo init para cargar las categorias
}

// class de widgets
