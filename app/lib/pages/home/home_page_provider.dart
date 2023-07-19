import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';

import 'package:provitask_app/controllers/home/home_provider_controller.dart';

import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/main_drawer.dart';
import 'package:provitask_app/widget/home/provider/home_provider_widget.dart';

class HomePageProvider extends GetView<HomeProviderController> {
  final _widgets = HomeWidgetsProvider();

  //saco listCategory de la clase HomeController

  HomePageProvider({Key? key}) : super(key: key);

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
                      'Hello ' + controller.user!['name'] + ".",
                      "center",
                      170591,
                      false),
                  //añado un spcio entre el titulo y el boton
                  const SizedBox(
                    height: 15,
                  ),

                  _widgets.franjaInformativa(
                      "We keep you updated on what's happening today",
                      0xFFFFFFFF,
                      0xFFD67B21,
                      15,
                      14,
                      30,
                      false,
                      "left"),

                  const SizedBox(
                    height: 30,
                  ),
                  _widgets.franjaInformativaFlecha(
                      "Same day task",
                      "/home-proveedor/tareas-pendientes",
                      0xFF838383,
                      0xFFFFFFFF,
                      15,
                      18,
                      30,
                      true,
                      "left",
                      20,
                      0xFFD67B21),

                  const SizedBox(
                    height: 30,
                  ),

                  _widgets.franjaInformativa(
                      "Get tasks that need to be done today.",
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
                  const Divider(
                    color: Colors.grey,
                    height: 1,
                    thickness: 0.8,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _widgets.franjaInformativaFlecha(
                      "No new messages",
                      "/notificaciones-page",
                      0xFF838383,
                      0xFFFFFFFF,
                      15,
                      18,
                      30,
                      true,
                      "left",
                      20,
                      0xFFD67B21),
                  const SizedBox(
                    height: 30,
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 1,
                    thickness: 0.8,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _widgets.infoCard(controller.mensualEarning,
                      controller.rateReliability, controller.todayEarning),

                  const SizedBox(
                    height: 30,
                  ),

                  _widgets.franjaInformativaFlecha(
                      "No tasks scheduled today",
                      "/help-page",
                      0xFF838383,
                      0xFFFFFFFF,
                      15,
                      18,
                      30,
                      true,
                      "left",
                      20,
                      0xFFD67B21),
                  const SizedBox(
                    height: 30,
                  ),

                  _widgets.franjaInformativa(
                      "Rectify your availability daily so that customers..",
                      0xFF170591,
                      0xFFB8B0E9,
                      10,
                      13,
                      35,
                      false,
                      "right"),
                  const SizedBox(
                    height: 60,
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
