import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_controller.dart';

import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class RegisterTaskPage3 extends GetView<RegisterTaskController> {
  final _widgets = RegisterTaskWidget();
  final _controller = Get.find<RegisterTaskController>();

  RegisterTaskPage3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: HomeMainAppBar(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        drawerEnableOpenDragGesture: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/REGISTER TASK/bg_degraded.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                children: [
                  Visibility(
                    visible: _controller.isLoading.value,
                    child: const Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Visibility(
                      visible: !_controller.isLoading.value,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _widgets.registerTaskTopBar(3),
                            const SizedBox(
                              height: 30,
                            ),
                            Obx(
                              () => Column(
                                children: [
                                  // container que tiene dentro la imagen del proveedor seleccionado y su nombre

                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    alignment: Alignment.topLeft,
                                    width: Get.width * 0.6,
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Color(0xff170591),
                                      //
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // imagen del proveedor redondeada

                                        Image(
                                          image: NetworkImage(
                                              ConexionCommon.hostBase +
                                                  _controller.infoProvider
                                                      .value["avatar_image"]),
                                          width: 75,
                                        ),

                                        const SizedBox(width: 10),
                                        Text(
                                          _controller
                                                  .infoProvider.value["name"] +
                                              " \n" +
                                              _controller.infoProvider
                                                  .value["lastname"],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    color: const Color(0XFFEE8B38),
                                    child: TableCalendar(
                                      firstDay: DateTime.now().toUtc(),
                                      lastDay: DateTime.utc(2030, 3, 14),
                                      focusedDay: _controller.selectedDay.value,
                                      selectedDayPredicate: (day) {
                                        // Retorna true si el día es igual al día seleccionado
                                        return day.year ==
                                                _controller
                                                    .selectedDay.value.year &&
                                            day.month ==
                                                _controller
                                                    .selectedDay.value.month &&
                                            day.day ==
                                                _controller
                                                    .selectedDay.value.day;
                                      },
                                      availableCalendarFormats: const {
                                        CalendarFormat.month: 'Month',
                                      },

                                      onDaySelected: (selectedDay, focusedDay) {
                                        // Actualiza la variable observable 'selectedDay' en el controlador GetX
                                        _controller
                                            .verifySelectedDate(selectedDay);
                                      },
                                      calendarBuilders: CalendarBuilders(
                                        dowBuilder: (context, dayOfWeek) {
                                          bool isSaturday =
                                              dayOfWeek.weekday == 6; // Sábado
                                          bool isSunday =
                                              dayOfWeek.weekday == 7; // Domingo

                                          // Aplica bordes y bordes redondeados solo a los días sábado y domingo
                                          if (isSaturday || isSunday) {
                                            return Container(
                                              height: 70,
                                              // aplico padding a la derecha si es sabado y izquierda si es domingo
                                              margin: isSaturday
                                                  ? const EdgeInsets.only(
                                                      right: 10)
                                                  : const EdgeInsets.only(
                                                      left: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: // aplico borde a la parte derecha si es sabado y a la izquierda si es domingo

                                                    isSaturday
                                                        ? const BorderRadius
                                                            .only(
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    15),
                                                          )
                                                        : const BorderRadius
                                                            .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15),
                                                          ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  DateFormat.E()
                                                      .format(dayOfWeek),
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
                                                  DateFormat.E()
                                                      .format(dayOfWeek),
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
                                      eventLoader: (day) {
                                        // Filtrar los eventos que tienen fecha igual al día seleccionado
                                        final eventsForDay = _controller.events
                                            .where((event) =>
                                                isSameDay(event.dateTime, day))
                                            .toList();

                                        // Puedes devolver la lista de eventos para ese día
                                        return eventsForDay;
                                      },
                                      enabledDayPredicate: (day) {
                                        // Verificar si hay eventos para el día seleccionado
                                        final eventsForDay = _controller.events
                                            .where((event) =>
                                                isSameDay(event.dateTime, day))
                                            .toList();
                                        return eventsForDay
                                            .isEmpty; // Devuelve true si no hay eventos, y false si hay eventos
                                      },

                                      //damos estilos al calendario , que tenga fondo color  background: #EE8B38;

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
                                              top: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.white),
                                              left: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.white),
                                              right: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.white),
                                              bottom: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.white),
                                            )),
                                      ),

                                      headerStyle: const HeaderStyle(
                                        decoration: BoxDecoration(
                                          color: Colors
                                              .white, // Color de fondo del encabezado
                                        ),
                                        titleCentered: true,
                                        formatButtonVisible: false,
                                        titleTextStyle: TextStyle(
                                          color: Color(
                                              0XFF2B1B99), // Color del texto del mes
                                          fontSize:
                                              20, // Tamaño de fuente del texto del mes
                                          fontWeight: FontWeight
                                              .bold, // Peso de fuente del texto del mes
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
                                          size:
                                              40, // Color del icono de navegación a la derecha
                                        ),
                                        headerPadding: EdgeInsets.symmetric(
                                            vertical:
                                                16), // Padding del encabezado del mes
                                        headerMargin:
                                            EdgeInsets.only(bottom: 16),
                                      ),
                                    ),
                                  ),
                                  Container(),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, top: 20),
                                        width: Get.width * 0.3,

                                        child: _controller
                                                .disponibility.isNotEmpty
                                            ? Align(
                                                alignment: Alignment
                                                    .centerLeft, // Alineación a la izquierda del DropdownButtonFormField
                                                child: DropdownButtonFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(50),
                                                      ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFDD7813),
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0xFFDD7813),
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(50),
                                                      ),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xFFDD7813),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 15,
                                                    ),
                                                  ),
                                                  dropdownColor:
                                                      const Color(0xFFDD7813),
                                                  value: _controller
                                                          .selectedHour
                                                          .value
                                                          .isNotEmpty
                                                      ? _controller
                                                          .selectedHour.value
                                                      : _controller
                                                          .disponibility[0],
                                                  items: _controller
                                                      .disponibility
                                                      .map(
                                                        (hour) =>
                                                            DropdownMenuItem(
                                                          value: hour,
                                                          child: Text(
                                                            hour,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  onChanged: (value) {
                                                    _controller.selectedHour
                                                            .value =
                                                        value.toString();

                                                    _controller.formStepThree
                                                        .value = 0.5;
                                                  },
                                                ),
                                              )
                                            : Container(), // Agrega un Container vacío si _controller.disponibility está vacío
                                      ),
                                    ],
                                  ),
                                  // texto con You can chat with your `Provider, adjust task details or change task time after booking
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 20, top: 20),
                                    width: Get.width * 0.9,
                                    child: const Text(
                                      'You can chat with your Provider, adjust task details or change task time after booking',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 20),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        width: Get.width * 0.9,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Request for:',
                                                style: TextStyle(
                                                  color: Colors.indigo[800],
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              margin:
                                                  const EdgeInsets.only(top: 5),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    _controller.dateResume(),
                                                    style: const TextStyle(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Color(0XFF2B1B99),
                                                    ),
                                                  ),

                                                  // This provider requieres 1 hour min

                                                  // boton Select & continue
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                'This provider requieres 1 hour min',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xFFDD7813),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Get.toNamed(
                                                          '/register_task/step4');
                                                    },
                                                    child: const Text(
                                                      'Select & continue',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .library_add_check_rounded,
                                                    color: Color(0XFF2B1B99),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Next confirm your details to get connected with your provider',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
