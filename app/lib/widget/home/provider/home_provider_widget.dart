import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:provitask_app/models/pending_request/pending_request.dart';

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
      double fontSize = 12]) {
    return Container(
      width: Get.width * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
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
            children: [
              Column(
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
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
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
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
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
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: request.cliente['avatar'] != null
                    ? NetworkImage(request.cliente['avatar'])
                    : const AssetImage('assets/images/avatar.png')
                        as ImageProvider,
              ),
              const SizedBox(width: 5),
              Text(
                request.cliente['name'] ?? '',
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String formatDate(DateTime date) {
  return "${date.day}/${date.month}/${date.year}";
}
