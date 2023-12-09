import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provitask_app/controllers/home/home_provider_controller.dart';
import 'package:provitask_app/controllers/task/task_controller.dart';
import 'package:provitask_app/models/pending_request/pending_request.dart';
import 'package:provitask_app/pages/tasks/UI/tasks_controller.dart';
import 'package:provitask_app/widget/tasks/task_details_widget.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HomeWidgetsProvider {
  final controller = Get.find<HomeProviderController>();
  final _controller = Get.put<TasksController>(TasksController());
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
    return GestureDetector(
      onTap: () async {
        try {
          _controller.isLoading.value = true;

          List<Future> futures = [
            _controller.getTask(request.id, true),
          ];

          // Ejecutar las funciones en paralelo
          await Future.wait(futures);

          Get.dialog(
            Dialog(
              insetPadding: const EdgeInsets.all(0),
              child: TaskDetailDialog(task: _controller.task),
            ),
          );
          _controller.isLoading.value = false;
        } catch (e) {
          print(e);
          _controller.isLoading.value = false;
        }
      },
      child: Container(
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
                  overflow: TextOverflow.ellipsis,
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
                        overflow: TextOverflow.ellipsis,
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
                          overflow: TextOverflow.ellipsis,
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
                SizedBox(
                  width: Get.width * 0.2,
                  child: Text(
                    request.cliente['name'] ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      overflow: TextOverflow.clip,
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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

  Widget pendingRequestWidget2(PendingRequest request,
      [Color backgroundColor = const Color(0xFF555555),
      Color textColor = const Color.fromARGB(255, 255, 255, 255),
      double fontSize = 13]) {
    return GestureDetector(
      onTap: () async {
        try {
          _controller.isLoading.value = true;

          List<Future> futures = [
            _controller.getTask(request.id),
          ];

          // Ejecutar las funciones en paralelo
          await Future.wait(futures);

          Get.dialog(
            Dialog(
              insetPadding: const EdgeInsets.all(0),
              child: TaskDetailDialog(task: _controller.task),
            ),
          );
          _controller.isLoading.value = false;
        } catch (e) {
          _controller.isLoading.value = false;
        }
      },
      child: Container(
        width: Get.width * 0.9,
        height: Get.height * 0.25,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                    request.cliente['name'],
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // hora de la tarea tirada a la derecha de la pantalla
                  const Spacer(),
                  Text(
                    formatDate(request.fecha, 'hour'),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      request.description ?? '',
                      maxLines: 4,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.1,
                      child: Column(
                        children: [
                          Icon(
                            Icons.attach_money,
                            color: const Color(0xFF170591),
                            size: fontSize,
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
                    SizedBox(
                      width: Get.width * 0.1,
                      child: Column(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: const Color(0xFF170591),
                            size: fontSize,
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
                    SizedBox(
                      width: Get.width * 0.2,
                      child: Column(
                        children: [
                          Icon(
                            Icons.category,
                            color: const Color(0xFF170591),
                            size: fontSize,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget monthSlider() {
    return Obx(
      () => Column(
        children: [
          SizedBox(
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Color(0XFFD67B21)),
                  onPressed: () {
                    controller.monthPageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
                Expanded(
                  child: PageView.builder(
                    controller: controller.monthPageController,
                    itemCount: 12,
                    onPageChanged: controller.onPageChanged,
                    itemBuilder: (context, index) {
                      final month = index + 1;
                      final monthName = DateFormat.MMMM().format(
                        DateTime(DateTime.now().year, month),
                      );

                      return Center(
                        child: Obx(
                          () => Container(
                            alignment: Alignment.center,
                            width: 70,
                            height: 50,
                            decoration: BoxDecoration(
                              color: month == controller.selectedMonth.value
                                  ? const Color(0XFFD67B21)
                                  : Colors.transparent,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              monthName,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight:
                                    month == controller.selectedMonth.value
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                color: month == controller.selectedMonth.value
                                    ? Colors.white
                                    : Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Color(0XFFD67B21)),
                    onPressed: () {
                      if (controller.monthPageController.hasClients) {
                        print('has clients');

                        final ScrollPosition position =
                            controller.monthPageController.position;
                        final int nextPage =
                            position.pixels ~/ position.viewportDimension + 1;
                        controller.monthPageController.animateToPage(
                          nextPage,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        controller.monthPageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      }
                    }),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            child: Obx(
              () => PageView.builder(
                controller: controller.dayPageController,
                itemCount: DateTime(
                  DateTime.now().year,
                  controller.selectedMonth.value + 1,
                  0,
                ).day,
                onPageChanged: (index) {
                  controller.onDayPageChanged(index);
                  controller
                      .filterPendingRequests(); // Filtrar tareas al cambiar de día
                },
                itemBuilder: (context, index) {
                  final day = index + 1;

                  return Center(
                    child: Obx(
                      () => Container(
                        width: 40,
                        height: 50,
                        decoration: BoxDecoration(
                          color: day == controller.selectedDay.value
                              ? const Color(0XFF555555)
                              : Colors.transparent,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            dayFormat(day.toString()),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: day == controller.selectedDay.value
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: day == controller.selectedDay.value
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (controller.filteredPendingRequests.isEmpty) ...[
            Container(
              height: Get.height * 0.4,
              width: Get.width * 0.9,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.warning,
                    color: Color(0XFFD67B21),
                    size: 50,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No pending tasks',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Container(
              height: Get.height * 0.4,
              width: Get.width * 0.9,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 40),
              child: Obx(
                () {
                  return ListView.builder(
                    itemCount: controller.filteredPendingRequests.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TimelineTile(
                        alignment: TimelineAlign.start,
                        isFirst: index == 0,
                        isLast: index ==
                            controller.filteredPendingRequests.length - 1,
                        indicatorStyle: IndicatorStyle(
                          width: 15,
                          indicatorXY: 0.15,
                          color: const Color(0XFF555555),
                          drawGap: true,
                          iconStyle: IconStyle(
                            fontSize: index == 0 ? 0 : 15,
                            color: Colors.white,
                            iconData: Icons.circle,
                          ),
                          padding: const EdgeInsets.all(6),
                        ),
                        beforeLineStyle: LineStyle(
                          color: const Color(0XFF555555).withOpacity(0.8),
                          thickness: 2,
                        ),
                        endChild: index == 0
                            ? pendingRequestWidget2(
                                controller.filteredPendingRequests[index])
                            : pendingRequestWidget2(
                                controller.filteredPendingRequests[index],
                                Colors.white,
                                Colors.black,
                                13),
                      );
                    },
                  );
                },
              ),
            ),
          ]
        ],
      ),
    );
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
