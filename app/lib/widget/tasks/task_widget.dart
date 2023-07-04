import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provitask_app/pages/chat/chat_home/UI/chat_home_controller.dart';
import 'package:provitask_app/controllers/task/task_controller.dart';

import 'package:provitask_app/common/conexion_common.dart';

class TaskWidgets {
  // final _controller = Get.find<HomeController>();

  final _controller = Get.put(TaskController());

  AppBar homeAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.indigo[900]),
      toolbarHeight: 80,
      title: Image.asset(
        'assets/images/letras_new.png',
        width: Get.width * 0.2,
      ),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Colors.indigo[800]),
                //  minimumSize: MaterialStateProperty.all(Size(40, 40)),
                shape: MaterialStateProperty.all<CircleBorder>(
                  const CircleBorder(),
                ),
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () => Get.toNamed('/profile_client'),
            ),
            Text('Profile',
                style: TextStyle(
                  color: Colors.indigo[800],
                  fontSize: 12,
                ))
          ],
        )
      ],
    );
  }

  Drawer homeDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Image.asset(
              'assets/images/logo3.png',
              width: Get.width * 0.4,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.indigo[900],
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Colors.indigo[900],
              ),
            ),
            onTap: () => Get.back(),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.indigo[900],
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: Colors.indigo[900],
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.message,
              color: Colors.indigo[900],
            ),
            title: Text(
              'Chat',
              style: TextStyle(
                color: Colors.indigo[900],
              ),
            ),
            onTap: () {
              Get.put<ChatHomeController>(ChatHomeController());
              Get.toNamed('/chat_home');
            },
          ),
        ],
      ),
    );
  }

  Widget homeSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90),
          ),
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  Widget titleGenerate(title) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.amber[800]),
      ),
    );
  }

  // widget que muestra la imagen de la tarea centrada y con un box shadow leve que parece que esta sobre el fondo elevado

  Widget imageTask(String url) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Center(
        child: Container(
          //alineo el contenido al centro
          alignment: Alignment.center,
          width: Get.width * 0.9,
          height: Get.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            //alineo el contenido al centro

            image: DecorationImage(
              alignment: Alignment.center,
              image: NetworkImage(ConexionCommon.hostBase + url),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  // widget que muestra la descripcion de la tarea

  Widget descriptionTask(String description) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        description,
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
    );
  }

  // widget que muestra el precio de la tarea donde el precio está dentro de un cuadro de color amarillo y el simbolo de la moneda dentgro de otro cuadro de color azul abos pegados. Sin usar la palabra precio

  Widget priceTask(String price) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.amber[800],
              //  solo radius en la esquina superior izquierda

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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: Text(
              '/hr',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.amber[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* widget que muestra los datos del cliente que publico la tarea nombre, enlace a su perfil, ubicacion , cantidad de ventas y calificacion. 

  ejemplo:

  Jose Perez
  3 km for you

  (icono de ubicacion) Av. 1ra. de Mayo 1234

 (icono de estrellas) 4.8 (100 ventas)

  */

  Widget proviData(
      String name,
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
          Text(
            name,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Color(0xff0B0058),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              // texto con el nombre de color #0B0058 y en cursiva

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
          SizedBox(
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
          )
        ],
      ),
    );
  }

  Widget buttonContact(id) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Get.width * 0.5,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                _controller.generarChat(id);

                //  Get.toNamed('/chat', arguments: id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0B0058),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                'Contact',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
