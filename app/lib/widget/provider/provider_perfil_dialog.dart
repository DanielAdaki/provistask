import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/services/provider_services.dart';
import 'package:readmore/readmore.dart';
import 'package:accordion/accordion.dart';

class ProfileDialog extends GetWidget {
  final Map<String, dynamic> perfilProvider;

  final int? idSkill;

  final bool? general;

  final reviews = [].obs;
  final currentPage = RxInt(1);
  final lastPage = RxInt(0);
  final totalPage = RxInt(0);
  final limit = RxInt(10);
  final isLoadingReviews = false.obs;
  final _services = ProviderRegisterServices();
  final count = RxInt(0);

  ProfileDialog(
      {Key? key,
      required this.perfilProvider,
      this.idSkill,
      this.general = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        key: const Key('45531121'),
        thickness: 3,
        radius: const Radius.circular(3),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: Get.width * 1,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  imageTask(perfilProvider["avatar_image"]),
                  const SizedBox(
                    height: 10,
                  ),
                  /* nombre del provider con Text(
                    "${perfilProvider["name"]} ${perfilProvider["lastname"]}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ) 
                  mas un boton a la derecha que diga book now
                  */

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.6,
                          child: Text(
                            "${perfilProvider["name"]} ${perfilProvider["lastname"]}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0XFFe68320),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Book now",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (general! == false) ...[
                    priceTask(
                      perfilProvider["skill_select"]["categorias_skill"],
                      perfilProvider["skill_select"]["cost"].toString(),
                      perfilProvider["skill_select"]["type_price"],
                    ),
                    proviData(
                      perfilProvider["type_provider"],
                      perfilProvider["skill_select"] != null
                          ? perfilProvider["skill_select"]["cost"].toString()
                          : '0',
                      perfilProvider["distanceLineal"].toString(),
                      perfilProvider["skill_select"] != null
                          ? perfilProvider["skill_select"]["scoreAverage"]
                              .toString()
                          : '0',
                      perfilProvider["open_disponibility"].toString(),
                      perfilProvider["close_disponibility"].toString(),
                      perfilProvider["provider_skills"],
                      perfilProvider["car"],
                      perfilProvider["truck"],
                      perfilProvider["motorcycle"],
                      perfilProvider["skill_select"] != null
                          ? perfilProvider["skill_select"]["count"].toString()
                          : '0',
                    ),
                  ] else ...[
                    proviData(
                      perfilProvider["type_provider"],
                      perfilProvider["skill_select"] != null
                          ? perfilProvider["skill_select"]["cost"].toString()
                          : '0',
                      perfilProvider["distanceLineal"].toString(),
                      perfilProvider["averageScore"].toString(),
                      perfilProvider["open_disponibility"].toString(),
                      perfilProvider["close_disponibility"].toString(),
                      perfilProvider["provider_skills"],
                      perfilProvider["car"],
                      perfilProvider["truck"],
                      perfilProvider["motorcycle"],
                      perfilProvider["averageCount"].toString(),
                    ),
                  ],
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 1,
                    ),
                  ),
                  descriptionPro("About me", perfilProvider["description"]),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (general! == false) ...[
                    descriptionPro(
                      "Skills and Experience",
                      perfilProvider["skill_select"]["description"],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Photos",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (general == false) ...[
                            GalleryImage(
                              numOfShowImages: calculeImageMininal(
                                  perfilProvider["skill_select"]["media"]),
                              imageUrls: formatImages(
                                  perfilProvider["skill_select"], false),
                            ),
                          ] /*else ...[
                          GalleryImage(
                            numOfShowImages: 3,
                            imageUrls: formatImages(
                                perfilProvider["provider_skills"], true),
                          ),
                        ]*/
                        ],
                      ),
                    ),
                  ] else ...[
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Skills",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left),
                      ),
                    ),
                    Accordion(
                      maxOpenSections: 1,
                      headerBackgroundColor: Colors.white,
                      headerPadding: const EdgeInsets.all(10),
                      children: [
                        for (var i = 0;
                            i < perfilProvider["provider_skills"].length;
                            i++) ...[
                          AccordionSection(
                            headerBackgroundColor: const Color(0XFF170591),
                            contentBorderColor: const Color(0XFF170591),
                            isOpen: false,
                            header: Text(
                              perfilProvider["provider_skills"][i]
                                  ["categorias_skill"],
                              style: const TextStyle(
                                fontSize: 18,
                                //   fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            content: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // muestro la info de hour minimun, cost y type price usando iconos uno debajo del otro

                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        formatMinimalHour(
                                            perfilProvider["provider_skills"][i]
                                                ["hour_minimun"]),
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      ),

                                      /* un toottip`                                      const Tooltip(
                                        waitDuration: Duration(seconds: 1),
                                        message:
                                            "Minimum number of hours to complete the task",
                                        child: Icon(
                                          Icons.info_outline,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                        Qu esté pegado a la derecha la border del container
                                      */
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.attach_money,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${perfilProvider["provider_skills"][i]["cost"]} /${perfilProvider["provider_skills"][i]["type_price"] == 'per_hour' ? 'hr' : perfilProvider["provider_skills"][i]["type_price"] == 'by_project_flat_rate' ? 'bpfr' : 'ft'}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),

                                  const Text(
                                    'Experience',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ReadMoreText(
                                    perfilProvider["provider_skills"][i]
                                            ["description"] ??
                                        'No description',
                                    trimLines: 2,
                                    textAlign: TextAlign.justify,
                                    colorClickableText: const Color(0xFF2B1B99),
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: const TextStyle(
                                        fontSize: 15, color: Color(0xFF2B1B99)),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GalleryImage(
                                    numOfShowImages: calculeImageMininal(
                                        perfilProvider["provider_skills"][i]
                                            ["media"]),
                                    imageUrls: formatImages(
                                        perfilProvider["provider_skills"][i],
                                        true),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (general == false) ...[
                          Text(
                            "Reviews for ${perfilProvider["skill_select"]["categorias_skill"]} (${perfilProvider["skill_select"]["count"]})",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ] else ...[
                          Text(
                            "Reviews (${perfilProvider["averageCount"]})",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                        const SizedBox(
                          height: 20,
                        ),
                        if (general == false) ...[
                          Container(
                            width: Get.width * 1,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FutureBuilder(
                              future: getComments(
                                perfilProvider["id"],
                                perfilProvider["skill_select"] != null
                                    ? perfilProvider["skill_select"]
                                        ["categorias_skill_id"]
                                    : null,
                              ),
                              builder: (BuildContext context,
                                  AsyncSnapshot<void> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  );
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: count.value,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final review = reviews[index];
                                      return ReviewWidget(
                                        avatarUrl: review["avatar"],
                                        username: review["client"],
                                        rating: review["valoration"],
                                        review: review["comment"],
                                        date: formatFecha(review["date"]),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ] else ...[
                          Container(
                            width: Get.width * 1,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FutureBuilder(
                              future: getComments(
                                perfilProvider["id"],
                                null,
                              ),
                              builder: (BuildContext context,
                                  AsyncSnapshot<void> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  );
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: count.value,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final review = reviews[index];
                                      return ReviewWidget(
                                        avatarUrl: review["avatar"],
                                        username: review["client"],
                                        rating: review["valoration"],
                                        review: review["comment"],
                                        date: formatFecha(review["date"]),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getComments(int id, [int? skill]) async {
    try {
      isLoadingReviews.value = true;
      Logger().i("id: $id");
      final response = await _services.getComments(
          id, currentPage.value, limit.value, idSkill);

      if (response['status'] == 200) {
        final data = response['data'].data["data"];

        reviews.value = data;

        final metadata = response['data'].data["metadata"];

        count.value = metadata['count'];

        currentPage.value = metadata['page'];

        // calculo el lastPage

        lastPage.value = metadata['pages'] % limit.value;

        totalPage.value = metadata['pages'];

        isLoadingReviews.value = false;
      } else {
        throw Exception('Failed to fetch reviews');
      }
    } catch (error) {
      isLoadingReviews.value = false;
      throw Exception('Failed to fetch reviews: $error');
    }
  }

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
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
              if (distance != "") ...[
                Text(
                  '$distance km for you',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ],
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
                '$rating ($sales reviews)',
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

  Widget descriptionPro(String title, String? description) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // texto de titulo de "sobre mi"

          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 20,
          ),
          ReadMoreText(
            description ?? 'No description',
            trimLines: 4,
            textAlign: TextAlign.justify,
            colorClickableText: const Color(0xFF2B1B99),
            trimMode: TrimMode.Line,
            trimCollapsedText: ' Show more',
            trimExpandedText: ' Show less',
            moreStyle: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  formatImages(perfilProvider, [bool? general = false]) {
    final List<String> images = [];

    logger.i(perfilProvider);

    if (general == true) {
      Logger().i("hola");
      //  for (var i = 0; i < perfilProvider.length; i++) {
      for (var j = 0; j < perfilProvider["media"].length; j++) {
        Logger().i(perfilProvider["media"][j]);
        images.add(perfilProvider["media"][j]);
      }
      //}
    } else {
      /*
      Media posee esta forma

      [
                    "http://192.168.0.105:1337/uploads/xc43zrqui3zfoelrsfgm_8b23af7112.jpg",
                    "http://192.168.0.105:1337/uploads/amettkxuazq8eboccwv4_2d7a906098.jpg",
                    "http://192.168.0.105:1337/uploads/mlwksl1epv9p2m9qyf3d_24fe8bed86.jpg",
                    "http://192.168.0.105:1337/uploads/jllohootiiiazrqdlgni_d82f4af117.jpg",
                    "http://192.168.0.105:1337/uploads/eyewgsovtngmyue8oren_315c80d3e9.jpg",
                    "http://192.168.0.105:1337/uploads/v5widhmbcu7ho0sb1kzn_8c16a08fb1.jpg",
                    "http://192.168.0.105:1337/uploads/jaiosj2hipr0enssqr4l_ce6ea80a3f.jpg",
                    "http://192.168.0.105:1337/uploads/unyjxr7d2jxdb2nkvltx_78ac2a90b7.jpg"
                ]
      
      */
      Logger().i(perfilProvider["media"]);

      for (var i = 0; i < perfilProvider["media"].length; i++) {
        images.add(perfilProvider["media"][i]);
      }
    }

    return images;
  }

  calculeImageMininal(image) {
    if (image.length > 3) {
      return 3;
    } else {
      return image.length;
    }
  }

  String formatMinimalHour(String? minimalHour) {
    if (minimalHour == null) {
      return '1 hour minimum ';
    } else {
      // minimalHour tiene esta forma hour_1

      minimalHour = minimalHour.substring(5);

      return '$minimalHour hour minimum';
    }
  }
}

class ReviewWidget extends StatelessWidget {
  final String avatarUrl;
  final String username;
  final int rating;
  final String review;
  final String date;
  const ReviewWidget({
    Key? key,
    required this.avatarUrl,
    required this.username,
    required this.rating,
    required this.review,
    required this.date,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: List.generate(
                    rating,
                    (index) => const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ),
                ),
                ReadMoreText(
                  review,
                  trimLines: 2,
                  textAlign: TextAlign.justify,
                  colorClickableText: const Color(0xFF2B1B99),
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(date),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String formatFecha(String fecha) {
  final parsedDate = DateTime.parse(fecha);
  final formattedDate = DateFormat('MMMM dd, yyyy').format(parsedDate);
  return formattedDate;
}
