import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'package:provitask_app/controllers/home/home_controller.dart';

import 'package:provitask_app/common/conexion_common.dart';

class HomeWidgets {
  // final _controller = Get.find<HomeController>();

  final _controller = Get.put(HomeController());

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

  Widget homeTopPicksCard(
    String imageLink,
    String titleService,
    String rankingService,
    String distanceService,
    String disponibilityService,
  ) {
    return Container(
      height: Get.height * 0.15,
      width: Get.width * 0.35,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(3, 2), // changes position of shadow
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(ConexionCommon.hostBase + imageLink),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Colors.white.withOpacity(0.8),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    titleService,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.indigo[900],
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star_border,
                          color: Colors.amber[800],
                          size: 12,
                        ),
                        Text(
                          rankingService,
                          style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/BOTTOM BAR/location.png',
                          height: 8,
                          color: Colors.amber[800],
                        ),
                        Text(
                          distanceService,
                          style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/BOTTOM BAR/calendar.png',
                          height: 8,
                          color: Colors.amber[800],
                        ),
                        Text(
                          disponibilityService,
                          style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget homePublicityCarrousel(items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: Get.height * 0.25,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: CarouselSlider(
        items: generateWidgets(items),
        options: CarouselOptions(
          disableCenter: true,
          aspectRatio: 2.0,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 3600),
        ),
      ),
    );
  }

  Widget homeNeedHelpServicesCard(
      rating, String title, price, String image, bool OnSiteStimation) {
    return InkWell(
      child: Column(
        children: [
          Container(
            height: Get.height * 0.15,
            width: Get.width * 0.25,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage(ConexionCommon.hostBase + image),
                fit: BoxFit.fitHeight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(3, 2), // changes position of shadow
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.indigo[900],
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RatingBar(
                initialRating: rating.toDouble(),
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 12,
                ratingWidget: RatingWidget(
                  full: Icon(
                    Icons.star,
                    color: Colors.amber[900],
                  ),
                  half: Icon(
                    Icons.star_half,
                    color: Colors.amber[900],
                  ),
                  empty: Icon(
                    Icons.star_border,
                    color: Colors.amber[900],
                  ),
                ),
                itemPadding: const EdgeInsets.symmetric(horizontal: 0.5),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              Text(
                '($rating)',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.amber[900],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '\$$price',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.amber[900],
                ),
              ),
              // texto de estimacion en sitio o no

              OnSiteStimation
                  ? Text(
                      ' / On site estimate',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.amber[900],
                      ),
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }

  Widget categoryCard(String title, String image) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: const Color(0xFF170591),
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //añado un espacio entre la imagen y el texto

          children: [
            Image.network(
              ConexionCommon.hostBase + image,
              width: 50,
              height: 50,
            ),

            // añado un espacio entre la imagen y el texto

            const SizedBox(height: 10),

            Text(
              title,
              //centro el texto
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF170591),
              ),
            ),
            // una imagen de prueba y un texto
          ],
        ),
      ),
    );
  }

  // retorno con obx un listado de categoryCard recorriendo la variable _controllerlistCategory

  Widget listCategory() {
    return Obx(() => Expanded(
          child: GridView.count(
            scrollDirection: Axis.horizontal,
            crossAxisCount: 2,
            childAspectRatio: 1.3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 30,
            physics: const ClampingScrollPhysics(),
            children: List.generate(
                _controller.listCategory.length,
                (index) => categoryCard(
                    _controller.listCategory[index]["attributes"]["title"],
                    _controller.listCategory[index]["attributes"]["image"]
                        ["data"]["attributes"]["url"])),
          ),
        ));
  }

  Widget listTasks() {
    return Obx(() => Expanded(
          child: GridView.count(
            // scrollDirection: Axis.horizontal,
            crossAxisCount: 3,
            childAspectRatio: 0.6,
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            physics: const ClampingScrollPhysics(),
            children: List.generate(
                _controller.listTask.length,
                (index) => homeNeedHelpServicesCard(
                    _controller.listTask[index]["attributes"]["averageScore"],
                    _controller.listTask[index]["attributes"]["name"],
                    _controller.listTask[index]["attributes"]["price"],
                    _controller.listTask[index]["attributes"]["image"]["data"]
                        ["attributes"]["url"],
                    _controller.listTask[index]["attributes"]
                        ["on_site_estimate"])),
          ),
        ));
  }

  Widget listPopularTasks() {
    return Obx(() => Expanded(
          child: GridView.count(
            // scrollDirection: Axis.horizontal,
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 5,
            mainAxisSpacing: 20,
            physics: const ClampingScrollPhysics(),
            children: List.generate(
                _controller.popularTask.length,
                (index) => InkWell(
                      onTap: () {
                        Get.toNamed(
                            '/task/${_controller.popularTask[index]["id"]}');
                      },
                      child: homeTopPicksCard(
                          _controller.popularTask[index]["attributes"]["image"]
                              ["data"]["attributes"]["url"],
                          _controller.popularTask[index]["attributes"]["name"],
                          _controller.popularTask[index]["attributes"]
                                  ["averageScore"]
                              .toString(),
                          '3 Km',
                          'Book Now '),
                    )),
          ),
        ));
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

  // barra de busqueda de tareas

  Widget searchTask() {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 47,
      margin: const EdgeInsets.only(top: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Try "moving" or "air repair"',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90),
            // añado color a la linea de borde A0A0A0

            borderSide: const BorderSide(color: Color(0xFFA0A0A0)),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  generateWidgets(items) {
    List<Widget> widgets = [];

    for (var item in items.value) {
      widgets.add(
        GestureDetector(
          onTap: null,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.black, width: 2),
                  image: DecorationImage(
                    image: NetworkImage(ConexionCommon.hostBase + item.image),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xFF001A8C).withOpacity(0.5),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.text,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return widgets;
  }
}
