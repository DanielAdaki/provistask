import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_controller.dart';

import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/pages/register_task/UI/register_task_widgets.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class RegisterTaskPage3 extends GetView<RegisterTaskController> {
  final _widgets = RegisterTaskWidget();
  //final controller = Get.find<RegisterTaskController>();

  RegisterTaskPage3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: controller.key,
        appBar: const HomeMainAppBar(),
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

                              await controller.getPerfilProvider(item.id, true,
                                  int.parse(controller.filters["skill"].value));

                              pd.close();

                              Get.dialog(
                                Dialog(
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

                                    body: SafeArea(
                                      child: SingleChildScrollView(
                                        child: Container(
                                          width: Get.width * 1,
                                          padding: const EdgeInsets.all(10),
                                          child: Column(children: [
                                            imageTask(controller.perfilProvider[
                                                "avatar_image"]),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              controller.perfilProvider[
                                                          "name"] +
                                                      " " +
                                                      controller.perfilProvider[
                                                          "lastname"] ??
                                                  "",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            priceTask(
                                                controller.perfilProvider[
                                                        "skill_select"]
                                                    ["categorias_skill"],
                                                controller.perfilProvider[
                                                        "skill_select"]["cost"]
                                                    .toString(),
                                                controller.perfilProvider[
                                                        "skill_select"]
                                                    ["type_price"]),
                                            proviData(
                                                controller.perfilProvider[
                                                    "type_provider"],
                                                controller.perfilProvider[
                                                        "skill_select"]["cost"]
                                                    .toString(),
                                                controller.perfilProvider[
                                                        "distanceLineal"]
                                                    .toString(),
                                                controller.perfilProvider["scoreAverage"]
                                                    .toString(),
                                                controller.perfilProvider[
                                                        "open_disponibility"]
                                                    .toString(),
                                                controller.perfilProvider[
                                                        "close_disponibility"]
                                                    .toString(),
                                                controller.perfilProvider[
                                                    "provider_skills"],
                                                controller
                                                    .perfilProvider?["car"],
                                                controller
                                                    .perfilProvider?["truck"],
                                                controller.perfilProvider?[
                                                    "motorcycle"],
                                                Random()
                                                    .nextInt(100)
                                                    .toString()),
                                            descriptionPro(
                                                controller.perfilProvider[
                                                        "description"] ??
                                                    ""),
                                          ]),
                                        ),
                                      ),
                                    ),
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
                            await controller.findProvider();
                            Get.toNamed('/register_task/step4');
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
                        const SizedBox(
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
                        ),
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

  Widget imageTask(String url) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          // la imagen cerá circular
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
          ),

          // la imagen se obtiene de la url

          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              url,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  // widget que muestra la descripcion de la tarea

  Widget descriptionPro(String? description) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // texto de titulo de "sobre mi"

          const Text(
            'About me',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            description ?? 'No description',
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 18,
              // fontWeight: FontWeight.bold,
              //color gris
              color: Colors.grey,
              // alieneado a la izquierda

              // textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  // widget que muestra el precio de la tarea donde el precio está dentro de un cuadro de color amarillo y el simbolo de la moneda dentgro de otro cuadro de color azul abos pegados. Sin usar la palabra precio

  Widget priceTask(String name, String price, String type) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // texo con el name de la tarea

            Text(
              '$name for: ',
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.clip),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.amber[800],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    '\$$price',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        type == 'per_hour'
                            ? '/hr'
                            : type == 'by_project_flat_rate'
                                ? '/bpfr'
                                : '/ft',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[800],
                          overflow: TextOverflow.clip,
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
      Positioned(
        top: 0,
        right: 0,
        child: Tooltip(
          message: type == 'per_hour'
              ? 'Price per hour'
              : type == 'by_project_flat_rate'
                  ? 'Price by project flat rate'
                  : 'Free trading',
          child: const Icon(Icons.info_outline, size: 18),
        ),
      ),
    ]);
  }

  // widget que muestra el nombre del usuario que publicó la tarea y su foto de perfil

  Widget proviData(
      String type,
      String cost,
      String distance,
      String rating,
      String openHours,
      String closeHours,
      List skills,
      bool? car,
      bool? truck,
      bool? moto,
      [String sales = '0']) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Provider $type',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '$distance km for you',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.access_time,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                // formateo la hora de apertura y cierre que tienen forma 16:08:00.000

                '${openHours.substring(0, 5)} - ${closeHours.substring(0, 5)}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '$rating ($sales ventas)',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(children: [
            car != false
                ? const Icon(
                    FontAwesomeIcons.car,
                    color: Colors.grey,
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
              width: 5,
            ),
            truck != false
                ? const Icon(
                    FontAwesomeIcons.truck,
                    color: Colors.grey,
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
              width: 5,
            ),
            moto != false
                ? const Icon(
                    FontAwesomeIcons.motorcycle,
                    color: Colors.grey,
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
              width: 5,
            ),
            car == false && truck == false && moto == false
                ? const Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.xmark,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'No vehicle',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                : const SizedBox(
                    width: 5,
                  )
          ]),
          const SizedBox(
            height: 5,
          ),
          /*SizedBox(
              width: Get.width * 0.8,
              height: 35,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: skills
                    .map((skill) => Container(
                          margin: const EdgeInsets.only(right: 5, top: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.blue[800],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            skill,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ))
                    .toList(),
              )),
          const SizedBox(
            height: 30,
          )*/
        ],
      ),
    );
  }

  // widget con el perfil del provedor de servicio
}
