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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    height: 100,
                                    color: Colors.white,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '\$${controller.mensualEarning.value}',
                                          style: GoogleFonts.raleway(
                                              fontSize: 18,
                                              color: const Color(0xFFD06605),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Monthly earning",
                                          style: GoogleFonts.raleway(
                                              fontSize: 14,
                                              color: const Color(0xFF838383)),
                                        ),
                                      ],
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                    height: 100,
                                    color: Colors.white,
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: 'Today you \n made ',
                                            style: GoogleFonts.raleway(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    '\$${controller.todayEarning.value}',
                                                style: GoogleFonts.raleway(
                                                  fontSize: 12,
                                                  color: Color(0xFFD06605),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    height: 100,
                                    color: Colors.white,
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '\$${controller.rateReliability.value}',
                                          style: GoogleFonts.raleway(
                                              fontSize: 18,
                                              color: const Color(0xFFD06605),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Reliability Rate",
                                          style: GoogleFonts.raleway(
                                              fontSize: 14,
                                              color: const Color(0xFF838383)),
                                        ),
                                      ],
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                    height: 100,
                                    color: Colors.white,
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // llamo la imagen de los assets que se llama ayuda.png que está dentro de la carpeta imges

                                        Image.asset(
                                          'assets/images/ayuda.png',
                                          width: 45,
                                          height: 45,
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

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
