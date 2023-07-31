import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provitask_app/services/provider_services.dart';
import 'package:readmore/readmore.dart';

class ProfileDialog extends StatelessWidget {
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
                  Text(
                    "${perfilProvider["name"]} ${perfilProvider["lastname"]}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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
                  ],
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
                  if (general! == false) ...[
                    descriptionPro(
                      "Skills and Experience",
                      perfilProvider["skill_select"]["description"],
                    ),
                  ] else ...[
                    descriptionPro(
                      "Skills and Experience",
                      perfilProvider["skillAndExperience"] ?? 'No description',
                    ),
                  ],
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
                              numOfShowImages: 3,
                              imageUrls: (perfilProvider["provider_skills"]
                                      as List<dynamic>)
                                  .map<String>(
                                      (item) => item["media"].toString())
                                  .toList()),
                        ] else ...[
                          GalleryImage(
                            numOfShowImages: 3,
                            imageUrls:
                                formatImages(perfilProvider["provider_skills"]),
                          ),
                        ]
                      ],
                    ),
                  ),
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

  Future<void> getComments(int id, int? skill) async {
    try {
      isLoadingReviews.value = true;
      // Realiza la llamada al servidor para obtener los datos de las revisiones
      // Puedes utilizar paquetes como http o dio para realizar la solicitud HTTP
      // y obtener la respuesta del servidor

      // Por ejemplo, utilizando el paquete dio:
      final response = await _services.getComments(
          id, currentPage.value, limit.value, idSkill!);

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

  formatImages(perfilProvider) {
    final List<String> images = [];

    for (var i = 0; i < perfilProvider.length; i++) {
      for (var j = 0; j < perfilProvider[i]["media"].length; j++) {
        images.add(perfilProvider[i]["media"][j]);
      }
    }

    return images;
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
                  review ?? 'No description',
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
