import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provitask_app/controllers/home/home_provider_controller.dart';

class StatisticsWidgetsProvider {
  final controller = Get.find<HomeProviderController>();
  Widget franjaInformativa(String texto,
      [int colorText = 0xFFFFFFFF,
      int colorFondo = 0xFFD67B21,
      double border = 10,
      double fontSize = 14,
      double height = 30,
      bool bold = false,
      String alignment = "center"]) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 20),
      width: Get.width * 0.9,
      height: height,
      decoration: BoxDecoration(
        color: Color(colorFondo),
        borderRadius: BorderRadius.circular(border),
      ),
      child: Text(
        texto,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            color: Color(colorText)),
      ),
    );
  }

  Widget titleGenerate(String title,
      [String? alignment, int? color, bool? italic]) {
    return Container(
      alignment: alignment == null
          ? Alignment.topLeft
          : alignment == "center"
              ? Alignment.center
              : Alignment.topLeft,
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: italic == null ? FontStyle.italic : FontStyle.normal,
            color: color == null ? Colors.amber[800] : Colors.indigo[900]),
      ),
    );
  }

  Widget infoCard(mensualEarning, rateReliability, todayEarning) {
    return Obx(
      () => Container(
        // color: const Color(0XFFD67B21),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0XFFD67B21),
          borderRadius: BorderRadius.circular(15),
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
          borderRadius: BorderRadius.circular(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // un texto centrado y un icono a la derecha
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: Get.width * 0.15),
                      child: Text(
                        "${DateFormat.MMMM().format(DateTime(DateTime.now().year, controller.selectedMonth.value))} Earnings",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            // fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,
                          size: 20, color: Color.fromARGB(255, 255, 255, 255)),
                      onPressed: () {
                        // aparece un modeal para seleccionar con un pocker para seleccionar mes
                        Get.dialog(
                          AlertDialog(
                            title: const Text('Selecciona un mes'),
                            content: SizedBox(
                              width: Get.width * 0.8,
                              height: Get.height * 0.3,
                              child: Scrollbar(
                                child: ListView.builder(
                                  itemCount: 12,
                                  itemBuilder: (context, index) {
                                    final month = index + 1;
                                    final monthName = DateFormat.MMMM().format(
                                        DateTime(DateTime.now().year, month));
                                    final isSelected =
                                        controller.selectedMonth.value == month;
                                    return ListTile(
                                      title: Text(
                                        monthName,
                                        style: TextStyle(
                                          color: isSelected
                                              ? const Color(0xFF170591)
                                              : Colors.black,
                                        ),
                                      ),
                                      onTap: () {
                                        controller.selectedMonth.value = month;
                                        controller.filterPendingRequests();
                                        Get.back();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // un texto con las ganancias del mes
                  Expanded(
                    child: Container(
                      child: Text(
                        "\$${controller.mensualEarning}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // un texto con las ganancias del mes
                  Expanded(
                    child: Container(
                      child: Text(
                        "Total earned",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            //fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget infoCardProgreso(
      progresResponse, progresAcceptance, progresRejection) {
    return Obx(
      () => Container(
        padding:
            const EdgeInsets.only(bottom: 40, left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
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
          borderRadius: BorderRadius.circular(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: Get.width * 0.03),
                      child: Text(
                        "${DateFormat.MMMM().format(DateTime(DateTime.now().year, controller.selectedMonth.value))} Metrics",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0XFFD67B21),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${progresResponse.value.percentage.toString()}%",
                      style: GoogleFonts.raleway(fontSize: 12)),
                  SizedBox(
                    width: Get.width * 0.4,
                    child: progresResponse.value.progressWidget,
                  ),
                  Text(
                    "${progresResponse.value.name}",
                    style: GoogleFonts.raleway(fontSize: 12),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                color: Colors.grey,
                height: 1,
                thickness: 0.8,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${progresAcceptance.value.percentage.toString()}%",
                      style: GoogleFonts.raleway(fontSize: 12)),
                  SizedBox(
                    width: Get.width * 0.4,
                    child: progresAcceptance.value.progressWidget,
                  ),
                  Text(
                    "${progresAcceptance.value.name}",
                    style: GoogleFonts.raleway(fontSize: 12),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                color: Colors.grey,
                height: 1,
                thickness: 0.8,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${progresRejection.value.percentage.toString()}%",
                      style: GoogleFonts.raleway(fontSize: 12)),
                  SizedBox(
                    width: Get.width * 0.4,
                    child: progresRejection.value.progressWidget,
                  ),
                  Text(
                    "${progresRejection.value.name}",
                    style: GoogleFonts.raleway(fontSize: 12),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget barraProgresoMontoMensual(
      RxDouble last30DaysProgress, RxString last30DaysEarnings) {
    return Obx(() => Column(
          children: [
            SizedBox(
              height: 15,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: last30DaysProgress.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0XFF170591),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("30 days left"),
                Text("\$${last30DaysEarnings.value}"),
              ],
            ),
          ],
        ));
  }

  String dayFormat(String dia) {
    DateTime fecha = DateTime(
        DateTime.now().year, controller.selectedMonth.value, int.parse(dia));
    DateFormat formato = DateFormat('dd\nEE', 'en');
    return formato.format(fecha);
  }
}

String formatDate(DateTime date, [String type = 'day']) {
  if (type == 'day') {
    return "${date.day}-${date.month}";
  } else if (type == 'hour') {
    return "${date.hour}:${date.minute}";
  } else {
    return "${date.day}-${date.month}-${date.year}";
  }
}
