import 'package:flutter/material.dart';
import 'package:provitask_app/controllers/task/task_controller.dart';

import 'package:rating_dialog/rating_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/models/tasks/task_aproved_detaill_model.dart';
import 'package:provitask_app/widget/common/circle_Icon_widget.dart';
import 'package:readmore/readmore.dart';
import 'package:provitask_app/widget/provider/review_widget.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class TaskDetailDialog extends GetWidget {
  final TaskApprovalDetail task;

  final reasonCancel = TextEditingController().obs;
  final _errorText = "The reason must be at least 15 characters long".obs;

  // creo una key para el scrollview

  final GlobalKey<ScrollableState> _scrollableKey = GlobalKey();

  // key del scaffold

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  TaskDetailDialog({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        key: _scrollableKey,
        thickness: 3,
        radius: const Radius.circular(3),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: Get.width * 1,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  imageTask(task.skill.image!),
                  const SizedBox(
                    height: 10,
                  ),
                  infoTask(task.skill.name, task.status),
                  // fila donde van los botones de acciones, para cancelar la tarea , aceptarla en caso sea una oferta o marcarla como completada
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (task.status == 'acepted') ...[
                        CircleIconButton(
                          height: 40,
                          width: 40,
                          onPressed: () async {
                            // muestro un dialogo de confirmación para marcar la tarea como completada

                            final result = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Confirm'),
                                content: const Text(
                                    'Are you sure you want to mark the task as completed?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                            );

                            if (result == true) {
                              final ProgressDialog progressDialog =
                                  ProgressDialog(context: Get.context);

                              try {
                                progressDialog.show(
                                  max: 100,
                                  msg: 'Please wait...',
                                  progressType: ProgressType.valuable,
                                );

                                final respuesta =
                                    await TaskController().finishTask(task.id);

                                if (respuesta == null) {
                                  throw Exception(
                                      "Error al marcar la tarea como completada");
                                }

                                progressDialog.close();

                                Get.back();

                                // muestro un mensaje de que se envio la calificación

                                Get.snackbar(
                                  'Success',
                                  'The task was marked as completed successfully',
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  duration: const Duration(seconds: 3),
                                );
                              } catch (e) {
                                progressDialog.close();
                                Get.back();
                                Get.snackbar(
                                  'Error',
                                  e.toString(),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  duration: const Duration(seconds: 3),
                                );
                              }
                            }
                          },
                          icon: const Icon(Icons.done),
                          iconSize: 20,
                          backgroundColor: Colors.green,
                          iconColor: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CircleIconButton(
                          height: 40,
                          width: 40,
                          onPressed: () async {
                            // muestro un dialogo de confirmación para marcar la tarea como completada

                            final result = await showDialog(
                              context: context,
                              builder: (context) => Obx(
                                () => AlertDialog(
                                  title: const Text('Cancel task'),
                                  content: SizedBox(
                                    height: Get.height * 0.3,
                                    child: Column(
                                      children: [
                                        const Text(
                                            'Are you sure you want to cancel the task?'),

                                        // campo de texto para ingresar el motivo de la cancelación

                                        const SizedBox(
                                          width: 10,
                                        ),

                                        TextField(
                                          decoration: const InputDecoration(
                                            hintText: 'Reason for cancellation',
                                          ),
                                          controller: reasonCancel.value,
                                          maxLines: 4,
                                          onChanged: (value) {
                                            if (value.length < 15) {
                                              _errorText.value =
                                                  'The reason must be at least 15 characters long';
                                            } else {
                                              _errorText.value = '';
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Obx(
                                          () => Text(
                                            _errorText.value,
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 13,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text('No'),
                                    ),
                                    if (_errorText.value.isEmpty) ...[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text('Yes'),
                                      ),
                                    ] else ...[
                                      const TextButton(
                                        onPressed: null,
                                        child: Text('Yes'),
                                      ),
                                    ]
                                  ],
                                ),
                              ),
                            );

                            if (result == true) {
                              final ProgressDialog progressDialog =
                                  ProgressDialog(context: Get.context);

                              try {
                                progressDialog.show(
                                  max: 100,
                                  msg: 'Please wait...',
                                  progressType: ProgressType.valuable,
                                );

                                final respuesta = await TaskController()
                                    .canceledTask(
                                        task.id, reasonCancel.value.text);

                                if (respuesta == null) {
                                  throw Exception(
                                      "Error the task could not be canceled");
                                }

                                progressDialog.close();

                                Get.back();

                                // muestro un mensaje de que se envio la calificación

                                Get.snackbar(
                                  'Success',
                                  'The task was marked as canceled successfully',
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  duration: const Duration(seconds: 3),
                                );
                              } catch (e) {
                                progressDialog.close();
                                Get.back();
                                Get.snackbar(
                                  'Error',
                                  e.toString(),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  duration: const Duration(seconds: 3),
                                );
                              }
                            }
                          },
                          icon: const Icon(Icons.cancel),
                          iconSize: 20,
                          backgroundColor: Colors.red,
                          iconColor: Colors.white,
                        )
                      ],
                      if (task.status == 'offer') ...[
                        CircleIconButton(
                          height: 40,
                          width: 40,
                          onPressed: () {
                            // Acción para aceptar la oferta
                          },
                          icon: const Icon(Icons.check),
                          iconSize: 20,
                          backgroundColor: Colors.blue,
                          iconColor: Colors.white,
                        ),
                      ],
                      if (task.status == 'completed' && task.review == null ||
                          task.status == 'cancelled' &&
                              task.review == null) ...[
                        CircleIconButton(
                          height: 40,
                          width: 40,
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible:
                                  true, // set to false if you want to force a rating
                              builder: (context) => ratingWrapperDialog(
                                  task.provider, task.skill.name, task.id),
                            );
                          },
                          icon: const Icon(Icons.star),
                          iconSize: 20,
                          backgroundColor: const Color(0xffd06605),
                          iconColor: Colors.white,
                        ),
                      ]
                    ],
                  ),
                  taskData(
                      '${task.provider.name} ${task.provider.lastname}',
                      task.provider.avatar,
                      task.netoPrice!,
                      task.brutePrice!,
                      task.totalPrice,
                      task.location!,
                      task.datetime,
                      task.transportation),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 1,
                    ),
                  ),
                  descriptionPro("Task description", task.description),
                  const SizedBox(
                    height: 30,
                  ),
                  if (task.descriptionProvis != null) ...[
                    descriptionPro(
                        "Description Provider", task.descriptionProvis),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        color: Colors.grey,
                        height: 20,
                        thickness: 1,
                      ),
                    ),
                  ],
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Images",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GalleryImage(
                    numOfShowImages: calculeImageMininal(task.images),
                    imageUrls: task.images,
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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  if (task.review != null) ...[
                    ReviewWidget(
                      avatarUrl: task.review!.avatarUrl,
                      username: task.review!.username,
                      rating: task.review!.rating,
                      review: task.review!.review,
                      date: formatFecha(task.review!.date),
                    )
                  ] else if (task.status == 'completed' &&
                          task.review == null ||
                      task.status == 'cancelled' && task.review == null) ...[
                    // mensaje indicnado que no haty reviews y botón para agregar una

                    const Text('There are no reviews yet'),

                    const SizedBox(
                      height: 10,
                    ),

                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible:
                              true, // set to false if you want to force a rating
                          builder: (context) => ratingWrapperDialog(
                              task.provider, task.skill.name, task.id),
                        );
                      },
                      child: const Text('Add review'),
                    )
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imageTask(String? url) {
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
              url!,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget infoTask(String name, String status) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // texo con el name de la tarea

            Text(
              name,
              style: const TextStyle(
                  fontSize: 18,
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
                    color: generateColorStatus(status),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    task.status == 'completed'
                        ? 'Completed'
                        : task.status == 'acepted'
                            ? 'Scheduled'
                            : task.status == 'request'
                                ? 'Requested'
                                : task.status == 'cancelled'
                                    ? 'Canceled'
                                    : task.status == 'pending_completed'
                                        ? 'Waiting confirmation'
                                        : 'Offer',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: Tooltip(
          message: getTootipStatus(status),
          child: const Icon(Icons.info_outline, size: 18),
        ),
      ),
    ]);
  }

// widget que muestra el nombre del usuario que publicó la tarea y su foto de perfil

  Widget taskData(
    String name,
    String imageProfile,
    String netoCost,
    String bruteCost,
    String? totalCost,
    String location,
    DateTime date,
    String transportations,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // la imagen cerá circular

              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),

                // la imagen se obtiene de la url

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    imageProfile,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0),
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
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
              if (location != "") ...[
                Text(
                  location,
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
                // muetro la fecha de la tarea en formato  mes dia, año a las hora:minutos

                formatFecha(date.toString(), true),

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
              if (totalCost == null) ...[
                const Icon(
                  Icons.attach_money_rounded,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '$netoCost \$',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ] else ...[
                // texto avisando que esta tarea tuvo una extension de precio

                const Text(
                  'The price of this task has been extended',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),

                const Icon(
                  Icons.attach_money,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '$netoCost \$',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.attach_money_rounded,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '$totalCost \$',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ]
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(children: [
            transportations == "cart"
                ? const Icon(
                    FontAwesomeIcons.car,
                    color: Colors.grey,
                  )
                : const SizedBox(),
            transportations == "truck"
                ? const Icon(
                    FontAwesomeIcons.truck,
                    color: Colors.grey,
                  )
                : const SizedBox(),
            transportations == "motorcycle"
                ? const Icon(
                    FontAwesomeIcons.motorcycle,
                    color: Colors.grey,
                  )
                : const SizedBox(),
            transportations == "not_necessary"
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

    if (general == true) {
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

  getTootipStatus(String s) {
    if (s == 'completed') {
      return 'The task has been completed.';
    } else if (s == 'acepted') {
      return 'Task accepted, paid and scheduled to be carried out.';
    } else if (s == 'request') {
      return 'Task requested from a service provider.';
    } else if (s == 'cancelled') {
      return 'The task has been canceled.';
    } else if (s == 'pending_completed') {
      return 'Task marked as completed by the service provider and awaits confirmation.';
    } else {
      return 'The task is an offer from a service provider.';
    }
  }

  generateColorStatus(String status) {
    if (status == 'completed') {
      return Colors.green;
    } else if (status == 'acepted') {
      return Colors.blue;
    } else if (status == 'request') {
      return Colors.yellow;
    } else if (status == 'cancelled') {
      return Colors.red;
    } else if (status == 'pending_completed') {
      return Colors.orange;
    } else {
      return Colors.purple;
    }
  }
}

String formatFecha(String fecha, [bool time = false]) {
  final parsedDate = DateTime.parse(fecha);
  if (time) {
    // mando en formato mes dia, año a las hora:minutos AM/PM

    final formattedDate =
        DateFormat('MMMM dd, yyyy \'at\' hh:mm a').format(parsedDate);

    return formattedDate;
  }
  final formattedDate = DateFormat('MMMM dd, yyyy').format(parsedDate);
  return formattedDate;
}

Widget ratingWrapperDialog(provider, skillName, idTask) {
  return RatingDialog(
    initialRating: 1.0,
    image: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),

      // la imagen se obtiene de la url

      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          provider.avatar,
          height: 70,
          width: 70,
          fit: BoxFit.cover,
        ),
      ),
    ),
    title: Text(
      'Rate ${provider.name} ${provider.lastname} for the task $skillName done for you.',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    // encourage your user to leave a high rating?
    message: const Text(
      'Tap a star to set your rating. Add more description here if you want.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    ),
    submitButtonText: 'Submit',
    commentHint:
        'Describe your experience with ${provider.name} ${provider.lastname}',
    onCancelled: () => print('cancelled'),
    onSubmitted: (response) async {
      final ProgressDialog progressDialog =
          ProgressDialog(context: Get.context);

      try {
        progressDialog.show(
          max: 100,
          msg: 'Please wait...',
          progressType: ProgressType.valuable,
        );

        final respuesta = await TaskController().sendCalificacion(
            provider.id, idTask, response.rating, response.comment);

        if (respuesta == null) {
          throw Exception("Error al enviar la calificación");
        }

        progressDialog.close();

        Get.back();

        // muestro un mensaje de que se envio la calificación

        Get.snackbar(
          'Success',
          'The rating was sent successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 10),
          duration: const Duration(seconds: 3),
        );
      } catch (e) {
        progressDialog.close();
        Get.back();
        Get.snackbar(
          'Error',
          e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.only(bottom: 10),
          duration: const Duration(seconds: 3),
        );
      }
    },
  );
}
