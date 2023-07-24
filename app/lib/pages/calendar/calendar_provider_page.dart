import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';

import 'package:provitask_app/controllers/home/home_provider_controller.dart';

import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/main_drawer.dart';
import 'package:provitask_app/models/pending_request/pending_request.dart';
import 'package:provitask_app/widget/home/provider/home_provider_widget.dart';

class CalendarPage extends GetView<HomeProviderController> {
  final _widgets = HomeWidgetsProvider();

  //saco listCategory de la clase HomeController

  CalendarPage({Key? key}) : super(key: key);

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
                        "Task of the day", "left", 170591, false),
                    const SizedBox(
                      height: 30,
                    ),
                    _widgets.monthSlider(),
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
    );
  }

// al cargar la pagina se ejecuta el metodo init para cargar las categorias
}

// class de widgets
