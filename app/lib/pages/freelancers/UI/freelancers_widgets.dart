import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/pages/freelancers/UI/freelancers_controller.dart';

class FreelancersWidgets {
  final _controller = Get.put<FreelancersController>(FreelancersController());

  Widget freelancersFloatingButton() {
    return Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!, width: 3.5),
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            //This keeps the splash effect within the circle
            borderRadius: BorderRadius.circular(
                1000.0), //Something large to ensure a circle
            onTap: () {
              print('hola');
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                Icons.add,
                size: 45.0,
                color: Colors.grey[400],
              ),
            ),
          ),
        ));
  }

  Widget freelancersTitleTop() {
    return Container(
      width: Get.width,
      height: Get.height * 0.1,
      padding: const EdgeInsets.only(left: 10),
      alignment: Alignment.bottomLeft,
      child: Text(
        'My Freelancers',
        style: TextStyle(
          fontSize: 20,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          color: Colors.amber[900],
        ),
      ),
    );
  }

  Widget freelancersSelectionType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () async => {
            _controller.favoritesOrPreviously.value = 1,
            await _controller.getFreelancers()
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: _controller.favoritesOrPreviously.value == 0
                ? MaterialStateProperty.all(Colors.transparent)
                : MaterialStateProperty.all(Colors.amber[800]),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90),
                  side: BorderSide(
                      color: _controller.favoritesOrPreviously.value == 0
                          ? Colors.grey
                          : Colors.transparent)),
            ),
          ),
          child: Text(
            'Favorites freelancer',
            style: TextStyle(
              color: _controller.favoritesOrPreviously.value == 0
                  ? Colors.grey
                  : Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async => {
            _controller.favoritesOrPreviously.value = 0,
            await _controller.getFreelancers()
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: _controller.favoritesOrPreviously.value == 1
                ? MaterialStateProperty.all(Colors.transparent)
                : MaterialStateProperty.all(Colors.amber[800]),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90),
                  side: BorderSide(
                      color: _controller.favoritesOrPreviously.value == 1
                          ? Colors.grey
                          : Colors.transparent)),
            ),
          ),
          child: Text(
            'Freelancer booked',
            style: TextStyle(
              color: _controller.favoritesOrPreviously.value == 1
                  ? Colors.grey
                  : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget freelancersPreviously() {
    return SizedBox(
      height: Get.height * 0.6,
      width: Get.width * 1,
      child: Center(
        child: ListView(
          children: List.generate(
            _controller.freelancers.length,
            (index) => taskProCard(_controller.freelancers[index]),
          ),
        ),
      ),
    );
  }

  Widget freelancersCardFreelancer(Map<String, dynamic> freelancer) {
    return Row(children: [
      Container(
        width: Get.width * 0.9,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(3, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: Get.width * 0.15,
              height: Get.width * 0.15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: freelancer["avatar_image"] == false
                    ? Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        ConexionCommon.hostBase + freelancer["avatar_image"],
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: Get.width * 0.6,
              child: Column(
                children: [
                  SizedBox(
                    width: Get.width * 0.3,
                    child: Text(
                      freelancer["name"] + ' ' + freelancer["lastname"],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width * 0.3,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        RatingBar(
                          initialRating: freelancer["scoreAverage"].toDouble(),
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
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 0.5),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        Text(
                          '(${freelancer["scoreAverage"]})',
                          style:
                              TextStyle(color: Colors.amber[900], fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    freelancer["description"] ?? '',
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(top: 100),
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(Colors.amber[800]),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 0, horizontal: 20)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90),
                  side: const BorderSide(color: Colors.transparent)),
            ),
          ),
          child: const Text(
            'Contact',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    ]);
  }

  Widget taskProCard(Map<String, dynamic> freelancer) {
    return Container(
      width: Get.width * 9,
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Center(
        child: Stack(
          children: [
            Container(
              width: Get.width * 1,
              height: 120,
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
                          width: Get.width * 0.3,
                          height: Get.width * 0.2,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              // si item.avatar es null, se usa el avatar por defecto

                              image: freelancer["avatar_image"] != false
                                  ? NetworkImage(ConexionCommon.hostBase +
                                      freelancer["avatar_image"])
                                  : const AssetImage(
                                      "assets/images/REGISTER TASK/avatar.jpg",
                                    ) as ImageProvider,

                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          transformAlignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //las primeras 10 letras de la descripcion item["attributes"]["description"] capitalizando la primera letra
                              Column(
                                children: [
                                  Text(
                                    freelancer["name"] +
                                        ' ' +
                                        freelancer["lastname"],

                                    // meto overflow para que no se salga del contenedor
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      color: Colors.indigo[800],
                                      fontWeight: FontWeight.w800,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Container(
                                    //margin: const EdgeInsets.only(left: 10),
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        RatingBar(
                                          initialRating:
                                              freelancer["scoreAverage"]
                                                  .toDouble(),
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
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0.5),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        Text(
                                          '(${freelancer["scoreAverage"]})',
                                          style: TextStyle(
                                              color: Colors.amber[900],
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              freelancer["description"] ?? '',
                              maxLines: 3,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 100),
              child: ElevatedButton(
                onPressed: () async {
                  final idChat =
                      await _controller.getConversation(freelancer["id"]);

                  Get.toNamed("/chat/$idChat/");
                },
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(Colors.amber[800]),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 30)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90),
                        side: const BorderSide(color: Colors.transparent)),
                  ),
                ),
                child: const Text(
                  'Contact',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
