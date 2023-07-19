import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/models/pending_request/pending_request.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeWidgetsProvider {
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

  // widget de franja con una flecha a final a la derecha que mande a otra pagina

  Widget franjaInformativaFlecha(
    String texto,
    String ruta, [
    int colorText = 0xFF838383,
    int colorFondo = 0xFFFFFFFF,
    double border = 10,
    double fontSize = 18,
    double height = 30,
    bool bold = false,
    String alignment = "center",
    double iconSize = 20,
    int iconColor = 0xFFD67B21,
  ]) {
    return Container(
      width: Get.width * 0.9,
      height: height,
      decoration: BoxDecoration(
        color: Color(colorFondo),
        borderRadius: BorderRadius.circular(border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              texto,
              textAlign: alignment == "center"
                  ? TextAlign.center
                  : alignment == "right"
                      ? TextAlign.right
                      : TextAlign.left,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  color: Color(colorText)),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios,
                  size: iconSize, color: Color(iconColor)),
              onPressed: () {
                print(ruta);
                Get.toNamed(ruta);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget pendingRequestWidget(PendingRequest request,
      [Color backgroundColor = Colors.white,
      Color textColor = const Color(0xFF170591),
      double fontSize = 13]) {
    return Container(
      width: Get.width * 0.4,
      height: Get.height * 0.2,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                request.nombre,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: textColor,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      request.monto,
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: textColor,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      formatDate(request.fecha),
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.category,
                      color: textColor,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      request.categoria['name'] ?? '',
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: request.cliente['avatar_image'] != null
                    ? NetworkImage(request.cliente['avatar_image'])
                    : const AssetImage('assets/images/avatar.png')
                        as ImageProvider,
              ),
              const SizedBox(width: 5),
              Text(
                request.cliente['name'] ?? '',
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoCard(mensualEarning, rateReliability, todayEarning) {
    return Obx(
      () => Container(
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '\$${mensualEarning.value}',
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
                                  fontSize: 14, color: const Color(0xFF838383)),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
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
                                    text: '\$${todayEarning.value}',
                                    style: GoogleFonts.raleway(
                                      fontSize: 12,
                                      color: const Color(0xFFD06605),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '\$${rateReliability.value}',
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
                                  fontSize: 14, color: const Color(0xFF838383)),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
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
    );
  }
}

String formatDate(DateTime date) {
  return "${date.day}-${date.month}";
}

class MonthSliderController extends GetxController {
  final PageController pageController;
  final PageController dayPageController;
  final selectedMonth = DateTime.now().month.obs;
  final selectedDay = DateTime.now().day.obs;

  MonthSliderController()
      : pageController = PageController(
          viewportFraction: 0.4,
          initialPage: DateTime.now().month - 1,
        ),
        dayPageController = PageController(
          viewportFraction: 0.2,
          initialPage: (DateTime.now().day - 1) + DateTime.now().day ~/ 2,
        );

  void onPageChanged(int index) {
    selectedMonth.value = (index + 1);
  }

  void onDayPageChanged(int index) {
    selectedDay.value = index + 1;
  }

  void jumpToCurrentMonth() {
    pageController.jumpToPage(DateTime.now().month - 1);
    dayPageController
        .jumpToPage((DateTime.now().day - 1) + DateTime.now().day ~/ 2);
  }

  @override
  void onInit() {
    super.onInit();
    //jumpToCurrentMonth();
  }
}

class MonthSlider extends StatelessWidget {
  final MonthSliderController controller = Get.put(MonthSliderController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  controller.pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: 12,
                  onPageChanged: controller.onPageChanged,
                  itemBuilder: (context, index) {
                    final month = index + 1;
                    final monthName = DateFormat.MMMM().format(
                      DateTime(DateTime.now().year, month),
                    );

                    return Center(
                      child: Obx(
                        () => Text(
                          monthName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: month == controller.selectedMonth.value
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: month == controller.selectedMonth.value
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  controller.pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 30,
          child: Obx(
            () => PageView.builder(
              controller: controller.dayPageController,
              itemCount: DateTime(
                DateTime.now().year,
                controller.selectedMonth.value + 1,
                0,
              ).day,
              onPageChanged: controller.onDayPageChanged,
              itemBuilder: (context, index) {
                final day = index + 1;
                final isSelected = (day == controller.selectedDay.value &&
                    controller.selectedMonth.value == DateTime.now().month);

                return Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        day.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
