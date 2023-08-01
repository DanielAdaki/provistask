import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';
import 'package:provitask_app/pages/chat/chat_conversation/propuestas/chat_propuesta_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class ChatConversationWidgets {
  final _controller = Get.put(ChatPropuestaController());

  final _controllerLocation = Get.find<LocationController>();
  Widget registerTaskSelectLocation() {
    return Container(
      width: Get.width * 0.9,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFDD7813),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Task location',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                // icono de la ubicacion si no hay seleccionada una

                _controllerLocation.selectedAddress == ""
                    ? const Icon(
                        Icons.location_on_outlined,
                        color: Colors.white,
                        size: 18,
                      )
                    : const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 18,
                      ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      border: _controllerLocation.selectedAddress == ""
                          ? Border.all(color: Colors.white, width: 1)
                          : Border.all(
                              color: const Color(0xFFDD7813), width: 1),
                    ),
                    child: Obx(() => Text(
                          _controllerLocation.selectedAddress == ""
                              ? 'Select your location'
                              : _controllerLocation.selectedAddress,
                          style: const TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // abro el dialog en el widget MapDialog

                    Get.dialog(
                      mapDialog(),
                      barrierDismissible: false,
                    );
                  },
                  // si no hay seleccionada una direccion, el icono es un add  si no es un edit

                  icon: _controllerLocation.selectedAddress == ""
                      ? const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        )
                      : const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 18,
                        ),
                ),
              ],
            ),
          ),

          // cuadro de texto que diga "How long is your task?"
        ],
      ),
    );
  }

  Widget mapDialog() {
    final LatLng? initialLocation = _controllerLocation.initialCameraPosition;

    ///    final LatLng? selectedLocation = _controllerLocation.selectedLocation;
    Set<Marker> markers = <Marker>{};

    // Agregar un marcador en la posición inicial

    // Agregar un marcador si se ha seleccionado una ubicación
    if (_controllerLocation.selectedLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: _controllerLocation.selectedLocation!,
          draggable: true,
          onDragEnd: (LatLng newPosition) {
            // Manejar el evento de arrastrar el marcador
            //_controllerLocation.updateSelectedLocation(newPosition);
          },
        ),
      );

      _controllerLocation.update();
    } else {
      markers.add(
        Marker(
          markerId: const MarkerId('initialLocation'),
          position: initialLocation != null
              ? LatLng(initialLocation.latitude, initialLocation.longitude)
              : const LatLng(37.42796133580664,
                  -122.085749655962), // Usa la ubicación actual o una ubicación predeterminada si no se ha obtenido la ubicación actual
          draggable: true,
          onDragEnd: (LatLng newPosition) {
            // Manejar el evento de arrastrar el marcador
            // _controllerLocation.updateSelectedLocation(newPosition);
          },
        ),
      );
    }

    return Obx(() => AlertDialog(
          title: const Text('Selecciona una ubicación'),
          content: SizedBox(
            width: Get.width * 1,
            height: Get.height * 1,
            child: GetBuilder<LocationController>(
              builder: (controller) => GoogleMap(
                mapType: MapType.normal,
                markers: markers,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: initialLocation != null
                      ? LatLng(
                          initialLocation.latitude, initialLocation.longitude)
                      : const LatLng(37.42796133580664,
                          -122.085749655962), // Usa la ubicación actual o una ubicación predeterminada si no se ha obtenido la ubicación actual
                  zoom: 16.0,
                ),
                onTap: (LatLng location) {
                  //controller.updateSelectedLocation(location);

                  _controllerLocation.updateSelectedLocation(location);
                  markers.clear();

                  // Añadir un nuevo marcador en la ubicación seleccionada
                  markers.add(
                    Marker(
                      markerId: const MarkerId('selectedLocation'),
                      position: location,
                      draggable: true,
                      onDragEnd: (LatLng newPosition) {
                        // Manejar el evento de arrastrar el marcador
                        // _controllerLocation.updateSelectedLocation(newPosition);
                      },
                    ),
                  );

                  // Actualizar el estado del controlador para que el marcador aparezca en el mapa
                  _controllerLocation.update();
                },
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              onPressed: _controllerLocation.selectedLocation != null
                  ? () async {
                      // Si se ha seleccionado una ubicación, obtener la dirección y cerrar el diálogo
                      _controllerLocation.getAddressFromLatLng();

                      Get.back(result: _controllerLocation.selectedAddress);
                    }
                  : null,
              child: const Text('Seleccionar'),
            ),
          ],
        ));
  }

  Widget registerTaskSelectTimeLong() {
    return Container(
      width: Get.width * 0.9,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFDD7813),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 5),
            child: const Text(
              'How long is your task?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 5),
            child: const Text(
              'Select the duration that your task requireds',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Checkbox(
                    value: _controller.lengthTask.value == "small",
                    shape: const CircleBorder(),
                    onChanged: (a) {
                      _controller.lengthTask.value = "small";
                    },
                    activeColor: const Color(0xFFDD7813),
                    checkColor: const Color(0xFFDD7813),
                  ),
                  title: const Text('Small - Est. 1 hr',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.left),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Checkbox(
                    value: _controller.lengthTask.value == "medium",
                    shape: const CircleBorder(),
                    onChanged: (a) {
                      _controller.lengthTask.value = "medium";
                    },
                    activeColor: const Color(0xFFDD7813),
                    checkColor: const Color(0xFFDD7813),
                  ),
                  title: const Text('Medium - Est. 2-4 hr',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.left),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Checkbox(
                    value: _controller.lengthTask.value == "large",
                    shape: const CircleBorder(),
                    onChanged: (a) {
                      _controller.lengthTask.value = "large";
                    },
                    activeColor: const Color(0xFFDD7813),
                    checkColor: const Color(0xFFDD7813),
                  ),
                  title: const Text('Large - Est. 5+ hr',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.left),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget registerTaskSelectTransport() {
    return Container(
      width: Get.width * 0.9,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFDD7813),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 5),
            child: const Text(
              'Any kind of transportation',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _controller.carTask.value = 1;
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _controller.carTask.value == 1
                                    ? Colors.grey[400]
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(2),
                              margin: const EdgeInsets.only(right: 5),
                              child: Icon(
                                FontAwesomeIcons.motorcycle,
                                color: Colors.indigo[800],
                                size: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Motobicycle',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          _controller.carTask.value = 2;
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _controller.carTask.value == 2
                                    ? Colors.grey[400]
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(2),
                              margin: const EdgeInsets.only(right: 5),
                              child: Icon(
                                FontAwesomeIcons.car,
                                color: Colors.indigo[800],
                                size: 19,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Car',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _controller.carTask.value = 3;
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _controller.carTask.value == 3
                                    ? Colors.grey[400]
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(2),
                              margin: const EdgeInsets.only(right: 5),
                              child: Icon(
                                FontAwesomeIcons.truck,
                                color: Colors.indigo[800],
                                size: 19,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Truck',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          _controller.carTask.value = 4;
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: _controller.carTask.value == 4
                                    ? Colors.grey[400]
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(2),
                              margin: const EdgeInsets.only(right: 5),
                              child: Icon(
                                FontAwesomeIcons.xmark,
                                color: Colors.indigo[800],
                                size: 28,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              'Not needed',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget timeLongSelected() {
    return Container(
        width: Get.width * 0.9,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFDD7813),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              const Icon(
                Icons.av_timer_outlined,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                _formatDateTime(_controller.selectedDay.value.toString()),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () {
                  // abro el dialog en el widget MapDialog

                  Get.dialog(
                    timeDialog(),
                    barrierDismissible: false,
                  );
                },
              ),
            ],
          ),
        ));
  }

  Widget registerTaskTellDetails() {
    return Container(
      width: Get.width * 0.9,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFDD7813),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 5),
            child: const Text(
              'Proposal Details',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: const Text(
              'Tell us in more detail what you need to do, how space, how to get to the place or other information so that Provitask can show you the most appropiate professionals for you needs.',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: TextField(
              controller: _controller.descriptionProvis.value,
              maxLines: 3,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 12,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: const Text(
              'If you need two or more Providers, plis post additional Task for each Providers needed',
              style: TextStyle(
                color: Color(0xFF8B4001),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(String dateTimeString) {
    final hourSelected = _controller.selectedHour.value;

    // mezclo la fecha y hora seleccionada

    //  dateTimeString = "${dateTimeString.substring(0, 10)} $hourSelected";

    DateTime dateTime = DateTime.parse(dateTimeString);

    // Formatea la fecha y hora en el formato "MMM dd, HH:mm"
    String formattedDateTime = DateFormat('MMM dd').format(dateTime);

    return "$formattedDateTime $hourSelected";
  }

  Widget registerContinueButton(
      String text, double margin, void Function() onTap,
      {Color bgColor = Colors.amber, Color textColor = Colors.white}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget timeDialog() {
    return Obx(() => AlertDialog(
          insetPadding: const EdgeInsets.all(2),
          title: const Text('Selecciona una fecha'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: Get.height * 0.55,
                  width: Get.width * 0.8,
                  color: const Color(0XFFEE8B38),
                  child: TableCalendar(
                    firstDay: DateTime.now().toUtc(),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _controller.selectedDay.value,
                    selectedDayPredicate: (day) {
                      // Retorna true si el día es igual al día seleccionado
                      return day.year == _controller.selectedDay.value.year &&
                          day.month == _controller.selectedDay.value.month &&
                          day.day == _controller.selectedDay.value.day;
                    },
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      // Actualiza la variable observable 'selectedDay' en el controlador GetX
                      _controller.selectedDay.value = selectedDay;
                    },
                    calendarBuilders: CalendarBuilders(
                      dowBuilder: (context, dayOfWeek) {
                        bool isSaturday = dayOfWeek.weekday == 6; // Sábado
                        bool isSunday = dayOfWeek.weekday == 7; // Domingo

                        // Aplica bordes y bordes redondeados solo a los días sábado y domingo
                        if (isSaturday || isSunday) {
                          return Container(
                            height: 70,
                            // aplico padding a la derecha si es sabado y izquierda si es domingo
                            margin: isSaturday
                                ? const EdgeInsets.only(right: 10)
                                : const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: // aplico borde a la parte derecha si es sabado y a la izquierda si es domingo

                                  isSaturday
                                      ? const BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        )
                                      : const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                        ),
                            ),
                            child: Center(
                              child: Text(
                                DateFormat.E().format(dayOfWeek),
                                style: const TextStyle(
                                  color: Color(0xFFDD7813),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        } else {
                          // Personaliza la apariencia de los días de la semana que no son sábado ni domingo
                          return Container(
                            height: 70,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                DateFormat.E().format(dayOfWeek),
                                style: const TextStyle(
                                  color: Color(0xFFDD7813),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    calendarStyle: const CalendarStyle(
                      todayTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      defaultTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      outsideDaysVisible: false,
                      selectedDecoration: BoxDecoration(
                        color: Color(0xFF2B1B99),
                        shape: BoxShape.circle,
                      ),
                      weekendTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              18 // Cambia el color de los días de fin de semana a rojo
                          ),
                      selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      todayDecoration: BoxDecoration(
                          // color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border(
                            top: BorderSide(width: 1.0, color: Colors.white),
                            left: BorderSide(width: 1.0, color: Colors.white),
                            right: BorderSide(width: 1.0, color: Colors.white),
                            bottom: BorderSide(width: 1.0, color: Colors.white),
                          )),
                    ),
                    headerStyle: const HeaderStyle(
                      decoration: BoxDecoration(
                        color: Colors.white, // Color de fondo del encabezado
                      ),
                      titleCentered: true,
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(
                        color: Color(0XFF2B1B99), // Color del texto del mes
                        fontSize: 20, // Tamaño de fuente del texto del mes
                        fontWeight:
                            FontWeight.bold, // Peso de fuente del texto del mes
                      ),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: Color(0XFF2B1B99),
                        size: 40,
                        // Color del icono de navegación a la izquierda
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: Color(0XFF2B1B99),
                        size: 40, // Color del icono de navegación a la derecha
                      ),
                      headerPadding: EdgeInsets.symmetric(
                          vertical: 16), // Padding del encabezado del mes
                      headerMargin: EdgeInsets.only(bottom: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    width: Get.width * 0.4,
                    child: Align(
                      alignment: Alignment
                          .centerLeft, // Alineación a la izquierda del DropdownButtonFormField
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            borderSide: BorderSide(
                              color: Color(0xFFDD7813),
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFDD7813),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          filled: true,
                          fillColor: Color(0xFFDD7813),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                        ),
                        dropdownColor: const Color(0xFFDD7813),
                        value: _controller.selectedHour.value.isNotEmpty
                            ? _controller.selectedHour.value
                            : _controller.arrayHours[0],
                        items: _controller.arrayHours
                            .map(
                              (hour) => DropdownMenuItem(
                                value: hour,
                                child: Text(
                                  hour,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          _controller.selectedHour.value = value.toString();
                        },
                      ),
                    )
                    // Agrega un Container vacío si _controller.disponibility está vacío
                    ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              onPressed: _controller.selectedDay.value != null
                  ? () async {
                      // Si se ha seleccionado una ubicación, obtener la dirección y cerrar el diálogo
                      //_controllerLocation.getAddressFromLatLng();

                      Get.back(result: _controller.selectedDay.value);
                    }
                  : null,
              child: const Text('Seleccionar'),
            ),
          ],
        ));
  }
}
