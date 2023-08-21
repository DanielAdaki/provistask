import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/models/provider/provider_model.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_controller.dart';
import 'package:provitask_app/widget/provider/provider_perfil_dialog.dart';
import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_widgets.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

class RegisterTaskPage3 extends GetView<RegisterTaskController> {
  final _widgets = RegisterTaskWidget();
  //final controller = Get.find<RegisterTaskController>();

  RegisterTaskPage3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: controller.key,
        appBar: HomeMainAppBar(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        drawerEnableOpenDragGesture: false,
        backgroundColor: Colors.white,
        drawer: _widgets.registerTaskDrawerFilter(),
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
                    visible: controller.isLoading.value,
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
                      visible: !controller.isLoading.value,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _widgets.registerTaskTopBar(2),
                            const SizedBox(
                              height: 30,
                            ),
                            Obx(() => Column(
                                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (controller.key.currentState!
                                                  .isDrawerOpen) {
                                                Navigator.pop(context);
                                              } else {
                                                controller.key.currentState
                                                    ?.openDrawer();
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              minimumSize: Size.zero,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 20),
                                              backgroundColor:
                                                  Colors.indigo[800],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(45),
                                              ),
                                            ),
                                            child: const Text(
                                              'Filters',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Sorted by: ',
                                                style: TextStyle(
                                                  color: Color(0XFFD06605),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),

                                              // un selector con opciones de "recommended", "price", "distance"

                                              DropdownButton<String>(
                                                value: controller
                                                        .filters["sortBy"]
                                                        .value ??
                                                    "Distance",
                                                icon: const Icon(
                                                    Icons.arrow_drop_down),
                                                iconSize: 24,
                                                elevation: 16,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                underline: Container(
                                                  height: 2,
                                                  color: Colors.indigo[800],
                                                ),
                                                onChanged:
                                                    (String? newValue) async {
                                                  controller.filters["sortBy"]
                                                      .value = newValue;
                                                  await controller
                                                      .findProviders();
                                                },
                                                items: <String>[
                                                  'Recommended',
                                                  'Price',
                                                  'Distance',
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.6,
                                      child: Center(
                                        child: ListView(
                                          children: List.generate(
                                            controller.listProviders.length,
                                            (index) => registerTaskProCard(
                                                controller
                                                    .listProviders[index]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
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

  Widget registerTaskProCard(Provider item) {
    return Container(
      width: Get.width * 9,
      height: 250,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Center(
        child: Stack(
          children: [
            Container(
              width: Get.width * 1,
              height: 240,
              padding: const EdgeInsets.only(top: 10, bottom: 15, right: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ]),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Get.width * 0.2,
                          height: Get.width * 0.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              // si item.avatar es null, se usa el avatar por defecto

                              image: item.avatarImage != null
                                  ? NetworkImage(item.avatarImage!)
                                  : const AssetImage(
                                      "assets/images/REGISTER TASK/avatar.jpg",
                                    ) as ImageProvider,

                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 7),
                                decoration: BoxDecoration(
                                  color: item.online!.status == 'online'
                                      ? Colors.greenAccent[400]
                                      : Colors.grey[350],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Online',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 7),
                                decoration: BoxDecoration(
                                  color: // if item["online"] == true
                                      item.online!.status == 'online'
                                          ? Colors.grey[350]
                                          : Colors.red,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Offline',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            ProgressDialog pd =
                                ProgressDialog(context: Get.context);
                            try {
                              pd.show(
                                max: 100,
                                msg: 'Please wait...',
                                progressBgColor: Colors.transparent,
                              );

                              List<Future> futures = [
                                controller.getPerfilProvider(
                                    item.id,
                                    true,
                                    int.parse(
                                        controller.filters["skill"].value)),
                                // controller.getComments(item.id),
                              ];

                              // Ejecutar las funciones en paralelo
                              await Future.wait(futures);

                              pd.close();
                              Get.dialog(
                                Dialog(
                                  insetPadding: const EdgeInsets.all(0),
                                  child: ProfileDialog(
                                    perfilProvider:
                                        controller.perfilProvider.value,
                                    idSkill: int.parse(
                                        controller.filters["skill"].value),
                                  ),
                                ),
                              );
                            } catch (e) {
                              pd.close();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 10),
                            backgroundColor: Colors.transparent,
                            /* shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.indigo[800]!),
                            ),*/
                          ),
                          child: Text(
                            'View Profile & Reviews',
                            style: TextStyle(
                              color: Colors.indigo[800],
                              fontSize: 9,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // suma el id del provedor de servicio y paso al siguiente formulario
                            controller.idProvider.value = item.id;

                            Get.dialog(
                              Dialog(
                                key: controller.keyDialogSelect,
                                insetPadding: const EdgeInsets.all(0),
                                child: Scaffold(
                                  // declaro una appBar que sea una fila con un boton oara cerrar el dialogo

                                  appBar: AppBar(
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    leading: IconButton(
                                      onPressed: () => Get.back(),
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.indigo,
                                      ),
                                    ),
                                  ),
                                  body: Scrollbar(
                                    thickness:
                                        3, // Ajusta el grosor de la barra de desplazamiento
                                    radius: const Radius.circular(3),
                                    child: SafeArea(
                                      child: SingleChildScrollView(
                                        child: Container(
                                          width: Get.width * 1,
                                          padding: const EdgeInsets.all(10),
                                          child: Obx(
                                            () => Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 20),
                                                  alignment: Alignment.topLeft,
                                                  width: Get.width * 0.8,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xff170591),
                                                    //
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(50),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      // imagen del proveedor redondeada
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(75),
                                                        child: Image(
                                                          image: NetworkImage(
                                                              item.avatarImage!),
                                                          width: 75,
                                                          height: 75,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),

                                                      const SizedBox(width: 10),
                                                      Text(
                                                        "${item.name} ${item.lastname!}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  color:
                                                      const Color(0XFFEE8B38),
                                                  child: TableCalendar(
                                                    firstDay:
                                                        DateTime.now().toUtc(),
                                                    lastDay: DateTime.utc(
                                                        2030, 3, 14),
                                                    focusedDay: controller
                                                        .selectedDay.value,
                                                    selectedDayPredicate:
                                                        (day) {
                                                      final currentTime =
                                                          controller.selectedDay
                                                              .value;
                                                      return day.year ==
                                                              currentTime
                                                                  .year &&
                                                          day.month ==
                                                              currentTime
                                                                  .month &&
                                                          day.day ==
                                                              currentTime.day;
                                                    },
                                                    availableCalendarFormats: const {
                                                      CalendarFormat.month:
                                                          'Month',
                                                    },

                                                    onDaySelected: (selectedDay,
                                                        focusedDay) {
                                                      // Actualiza la variable observable 'selectedDay' en el controlador GetX
                                                      controller
                                                          .verifySelectedDate(
                                                              selectedDay);
                                                    },
                                                    calendarBuilders:
                                                        CalendarBuilders(
                                                      dowBuilder:
                                                          (context, dayOfWeek) {
                                                        bool isSaturday =
                                                            dayOfWeek.weekday ==
                                                                6; // Sábado
                                                        bool isSunday =
                                                            dayOfWeek.weekday ==
                                                                7; // Domingo
                                                        if (isSaturday ||
                                                            isSunday) {
                                                          return Container(
                                                            height: 70,
                                                            // aplico padding a la derecha si es sabado y izquierda si es domingo
                                                            margin: isSaturday
                                                                ? const EdgeInsets
                                                                        .only(
                                                                    right: 10)
                                                                : const EdgeInsets
                                                                        .only(
                                                                    left: 10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: // aplico borde a la parte derecha si es sabado y a la izquierda si es domingo

                                                                  isSaturday
                                                                      ? const BorderRadius
                                                                          .only(
                                                                          topRight:
                                                                              Radius.circular(15),
                                                                          bottomRight:
                                                                              Radius.circular(15),
                                                                        )
                                                                      : const BorderRadius
                                                                          .only(
                                                                          topLeft:
                                                                              Radius.circular(15),
                                                                          bottomLeft:
                                                                              Radius.circular(15),
                                                                        ),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                DateFormat.E()
                                                                    .format(
                                                                        dayOfWeek),
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xFFDD7813),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        } else {
                                                          // Personaliza la apariencia de los días de la semana que no son sábado ni domingo
                                                          return Container(
                                                            height: 70,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                DateFormat.E()
                                                                    .format(
                                                                        dayOfWeek),
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xFFDD7813),
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                    eventLoader: (day) {
                                                      // Filtrar los eventos que tienen fecha igual al día seleccionado
                                                      final eventsForDay =
                                                          controller.events
                                                              .where((event) =>
                                                                  isSameDay(
                                                                      event
                                                                          .dateTime,
                                                                      day))
                                                              .toList();

                                                      // Puedes devolver la lista de eventos para ese día
                                                      return eventsForDay;
                                                    },
                                                    enabledDayPredicate: (day) {
                                                      // Verificar si hay eventos para el día seleccionado
                                                      final eventsForDay =
                                                          controller.events
                                                              .where((event) =>
                                                                  isSameDay(
                                                                      event
                                                                          .dateTime,
                                                                      day))
                                                              .toList();
                                                      return eventsForDay
                                                          .isEmpty; // Devuelve true si no hay eventos, y false si hay eventos
                                                    },

                                                    //damos estilos al calendario , que tenga fondo color  background: #EE8B38;

                                                    calendarStyle:
                                                        const CalendarStyle(
                                                      todayTextStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                      defaultTextStyle:
                                                          TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                      outsideDaysVisible: false,
                                                      selectedDecoration:
                                                          BoxDecoration(
                                                        color:
                                                            Color(0xFF2B1B99),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      weekendTextStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              18 // Cambia el color de los días de fin de semana a rojo
                                                          ),
                                                      selectedTextStyle:
                                                          TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18),
                                                      todayDecoration:
                                                          BoxDecoration(
                                                              // color: Colors.white,
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border(
                                                                top: BorderSide(
                                                                    width: 1.0,
                                                                    color: Colors
                                                                        .white),
                                                                left: BorderSide(
                                                                    width: 1.0,
                                                                    color: Colors
                                                                        .white),
                                                                right: BorderSide(
                                                                    width: 1.0,
                                                                    color: Colors
                                                                        .white),
                                                                bottom: BorderSide(
                                                                    width: 1.0,
                                                                    color: Colors
                                                                        .white),
                                                              )),
                                                    ),

                                                    headerStyle:
                                                        const HeaderStyle(
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .white, // Color de fondo del encabezado
                                                      ),
                                                      titleCentered: true,
                                                      formatButtonVisible:
                                                          false,
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
                                                        color:
                                                            Color(0XFF2B1B99),
                                                        size: 40,
                                                        // Color del icono de navegación a la izquierda
                                                      ),
                                                      rightChevronIcon: Icon(
                                                        Icons.chevron_right,
                                                        color:
                                                            Color(0XFF2B1B99),
                                                        size:
                                                            40, // Color del icono de navegación a la derecha
                                                      ),
                                                      headerPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  16), // Padding del encabezado del mes
                                                      headerMargin:
                                                          EdgeInsets.only(
                                                              bottom: 16),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      // texto que diga en ingles: Horas disponibles

                                                      const Text(
                                                        'Available hours',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ), // texto que diga en ingles: Horas disponibles

                                                      Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20,
                                                                  top: 20),
                                                          width:
                                                              Get.width * 0.4,
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft, // Alineación a la izquierda del DropdownButtonFormField
                                                            child:
                                                                DropdownButtonFormField(
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            50),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xFFDD7813),
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xFFDD7813),
                                                                    width: 2,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            50),
                                                                  ),
                                                                ),
                                                                filled: true,
                                                                fillColor: Color(
                                                                    0xFFDD7813),
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      15,
                                                                ),
                                                              ),
                                                              dropdownColor:
                                                                  const Color(
                                                                      0xFFDD7813),
                                                              value: controller
                                                                  .selectedHour
                                                                  .value,
                                                              items: controller
                                                                  .disponibilityHour
                                                                  .map(
                                                                    (hour) =>
                                                                        DropdownMenuItem(
                                                                      value:
                                                                          hour,
                                                                      child:
                                                                          Text(
                                                                        hour,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                  .toList(),
                                                              onChanged:
                                                                  (value) {
                                                                print(value);
                                                                controller
                                                                        .selectedHour
                                                                        .value =
                                                                    value
                                                                        .toString();
                                                              },
                                                            ),
                                                          )
                                                          // Agrega un Container vacío si controller.disponibility está vacío
                                                          ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 20,
                                                          horizontal: 20),
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      width: Get.width * 0.9,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
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
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              'Request for:',
                                                              style: TextStyle(
                                                                color: Colors
                                                                        .indigo[
                                                                    800],
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 5),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  controller.dateResume(
                                                                      controller
                                                                          .selectedDay
                                                                          .value
                                                                          .toString(),
                                                                      controller
                                                                          .selectedHour
                                                                          .value),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        28,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    color: Color(
                                                                        0XFF2B1B99),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              'This provider requires a minimum ${item.skillSelect!['hourMinimum'].replaceAll("hour_", "") ?? 0} hours for the ${item.skillSelect!["categorias_skill"]} task',
                                                              style:
                                                                  const TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
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
                                                                          BorderRadius.circular(
                                                                              50),
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    ProgressDialog
                                                                        pd =
                                                                        ProgressDialog(
                                                                            context:
                                                                                Get.context);

                                                                    try {
                                                                      pd.show(
                                                                        max:
                                                                            100,
                                                                        msg:
                                                                            'Please wait...',
                                                                        progressBgColor:
                                                                            Colors.transparent,
                                                                      );

                                                                      await controller.getPerfilProvider(
                                                                          item
                                                                              .id,
                                                                          true,
                                                                          int.parse(controller
                                                                              .filters["skill"]
                                                                              .value));
                                                                      pd.close();
                                                                      Get.toNamed(
                                                                          '/register_task/step4');
                                                                    } catch (e) {
                                                                      Logger()
                                                                          .e(e);
                                                                      pd.close();
                                                                    }
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Continue',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
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
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );

                            // await controller.findProvider();
                            //Get.toNamed('/register_task/step4');
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 10),
                            backgroundColor: const Color(0xFFDD7813),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Color(0xFFDD7813)),
                            ),
                          ),
                          child: const Text(
                            'Select & Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              // fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'You can chat with your `Provider, adjust task details or change',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // color 6A6A6A

                            color: Color(0xFF6A6A6A),

                            fontSize: 7,
                          ),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                '${item.name} ${item.lastname!}',
                                style: TextStyle(
                                  color: Colors.indigo[800],
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 22,
                                ),
                              ),
                              // otro texto con el costo del servicio por hora
                              Text(
                                ' \$${item.skillSelect!['cost'] ?? 0}',
                                style: TextStyle(
                                  color: Colors.indigo[800],
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 16,
                              width: 16,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/REGISTER TASK/marca-de-verificacion.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              '${item.skillSelect!["taskCompleted"]} - ${item.skillSelect!["categorias_skill"]}',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 16,
                              width: 16,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/REGISTER TASK/verificado.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              '100% Reliable',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 16,
                              width: 16,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/REGISTER TASK/entrega.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                'Vehicles: ${item.car == true ? 'Car,' : ''} ${item.motorcycle == true ? 'Motocycle' : ''} ${item.truck == true ? 'Truck' : ''}',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: Get.width * 0.9,
                          height: 100,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.indigo[100],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'What can i do for you?',
                                style: TextStyle(
                                  color: Colors.indigo[800],
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                item.description ?? 'No description',
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // un text boton que diga "View comments" con un icono de flecha hacia  la derecha que al presionarlo se despliegue un listview con los comentarios
                        /*const SizedBox(
                          height: 10,
                        ),
                        Row(
                          // alineo a la derecha
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: null,
                              child: const Text(
                                'View comments',
                                style: TextStyle(
                                  color: Color(0xFF2B1B99),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue,
                              size: 12,
                            ),
                          ],
                        ),*/
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// extras

  // widget que muestra la imagen de la tarea centrada y con un box shadow leve que parece que esta sobre el fondo elevado

  // widget que muestra la descripcion de la tarea

  // widget que muestra el precio de la tarea donde el precio está dentro de un cuadro de color amarillo y el simbolo de la moneda dentgro de otro cuadro de color azul abos pegados. Sin usar la palabra precio

  // widget con el perfil del provedor de servicio
}
