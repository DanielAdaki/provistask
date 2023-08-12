import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/components/spinner.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';

import 'package:provitask_app/pages/register_provider/UI/register_provider_widgets.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class RegisterProviderPage extends GetView<ProfileController> {
  final _widgets = RegisterProviderWidgets();

  RegisterProviderPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getSkills();
    controller.getProfileData();
    return Obx(
      () => controller.isLoading.value == true
          ? const SpinnerWidget()
          : Scaffold(
              appBar: _widgets.registerProAppBAr(),
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Column(
                  children: [
                    _widgets.registerProStepper(1),
                    _widgets.registerProStepSubtitle(1),
                    Expanded(
                      child: Container(
                        width: Get.width * 0.8,
                        height: Get.height * 0.6,
                        margin: const EdgeInsets.only(top: 40),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'In demand skills',
                                  style: TextStyle(
                                    color: Colors.amber[800],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Icon(
                                  Icons.timer,
                                  color: Colors.grey[400],
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(top: 15),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[300]!,
                                      blurRadius: 10,
                                      spreadRadius: 5,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Obx(
                                  () => ListView(
                                    children: controller.skills
                                        .map(
                                          (e) => ListTile(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            leading: Checkbox(
                                              value: controller.skillsList.any(
                                                  (skill) =>
                                                      skill.idCategory ==
                                                      e['id']),
                                              shape: const CircleBorder(),
                                              onChanged: (a) {
                                                controller.images.clear();

                                                controller.mediaBySkill.clear();

                                                if (controller.skillsList.any(
                                                    (skill) =>
                                                        skill.idCategory ==
                                                        e['id'])) {
                                                  // obetngo el elemento coincidente

                                                  final skill = controller
                                                      .skillsList
                                                      .firstWhere((skill) =>
                                                          skill.idCategory ==
                                                          e['id']);

                                                  Logger().i("REcorrdio");

                                                  //lleno los campos del formulario con los datos del elemento

                                                  controller.costSkill.value
                                                          .text =
                                                      skill.cost.toString();
                                                  controller.descriptionSkill
                                                          .value.text =
                                                      skill.description ?? '';
                                                  controller.typeCost.value =
                                                      skill.typePrice ??
                                                          'per_hour';
                                                  controller
                                                          .minimalHours.value =
                                                      skill.minimalHour ??
                                                          'hour_1';

                                                  if (skill.media != null) {
                                                    for (var image
                                                        in skill.media!) {
                                                      controller.mediaBySkill
                                                          .add(ConexionCommon
                                                                  .hostBase +
                                                              image);
                                                    }
                                                  }
                                                } else {
                                                  controller.costSkill.value
                                                      .text = '';
                                                  controller.descriptionSkill
                                                      .value.text = '';
                                                  controller.typeCost.value =
                                                      'per_hour';
                                                  controller.minimalHours
                                                      .value = 'hour_1';
                                                }

                                                Get.dialog(
                                                  AlertDialog(
                                                    insetPadding:
                                                        const EdgeInsets.all(2),
                                                    contentPadding:
                                                        const EdgeInsets.all(2),
                                                    title: Text(
                                                      'Cost of service by: ${e["attributes"]["name"]}',
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                    content: SafeArea(
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Container(
                                                          width: Get.width * 1,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Obx(
                                                            () => Form(
                                                              key: controller
                                                                  .formKey,
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  TextFormField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    inputFormatters: <TextInputFormatter>[
                                                                      FilteringTextInputFormatter
                                                                          .allow(
                                                                              RegExp(r'[0-9]')),
                                                                    ],
                                                                    controller:
                                                                        controller
                                                                            .costSkill
                                                                            .value,
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      labelText:
                                                                          'Cost \$',
                                                                    ),
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
                                                                        return 'Please enter a cost';
                                                                      }
                                                                      return null;
                                                                    },
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          20),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      // un texto que diga horas minimas de trabajo
                                                                      const Text(
                                                                        'Minimum hours of work',
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              20),
                                                                      SizedBox(
                                                                        width: Get.width *
                                                                            0.8,
                                                                        child: DropdownButton<
                                                                            String>(
                                                                          value: controller
                                                                              .minimalHours
                                                                              .value,
                                                                          onChanged:
                                                                              (String? newValue) {
                                                                            if (newValue !=
                                                                                null) {
                                                                              controller.minimalHours.value = newValue;
                                                                            }
                                                                          },
                                                                          items: const <DropdownMenuItem<
                                                                              String>>[
                                                                            DropdownMenuItem<String>(
                                                                              value: 'hour_1',
                                                                              child: Text('1 hora'),
                                                                            ),
                                                                            DropdownMenuItem<String>(
                                                                              value: 'hour_2',
                                                                              child: Text('2 horas'),
                                                                            ),
                                                                            DropdownMenuItem<String>(
                                                                              value: 'hour_3',
                                                                              child: Text('3 horas'),
                                                                            ),
                                                                            DropdownMenuItem<String>(
                                                                              value: 'hour_4',
                                                                              child: Text('4 horas'),
                                                                            ),
                                                                            DropdownMenuItem<String>(
                                                                              value: 'hour_5',
                                                                              child: Text('5 horas'),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          20),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const Text(
                                                                        'Type of cost',
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              20),
                                                                      Row(
                                                                        children: [
                                                                          Radio(
                                                                            value:
                                                                                'per_hour',
                                                                            groupValue:
                                                                                controller.typeCost.value,
                                                                            onChanged:
                                                                                (value) {
                                                                              controller.typeCost.value = value as String;
                                                                            },
                                                                          ),
                                                                          const Text(
                                                                              'Per hour'),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Radio(
                                                                            value:
                                                                                'by_project_flat_rate',
                                                                            groupValue:
                                                                                controller.typeCost.value,
                                                                            onChanged:
                                                                                (value) {
                                                                              controller.typeCost.value = value as String;
                                                                            },
                                                                          ),
                                                                          const Text(
                                                                              'Per project'),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Radio(
                                                                            value:
                                                                                'free_trading',
                                                                            groupValue:
                                                                                controller.typeCost.value,
                                                                            onChanged:
                                                                                (value) {
                                                                              controller.typeCost.value = value as String;
                                                                            },
                                                                          ),
                                                                          const Text(
                                                                              'Free trading'),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  TextFormField(
                                                                    controller:
                                                                        controller
                                                                            .descriptionSkill
                                                                            .value,
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      labelText:
                                                                          'Tell us your experience',
                                                                    ),
                                                                    maxLines: 4,
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
                                                                        return 'Please enter a description';
                                                                      }
                                                                      return null;
                                                                    },
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          20),
                                                                  if (controller
                                                                      .mediaBySkill
                                                                      .isNotEmpty) ...[
                                                                    Container(
                                                                      margin: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              30),
                                                                      height:
                                                                          100,
                                                                      child: ListView
                                                                          .builder(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemCount: controller
                                                                            .mediaBySkill
                                                                            .length,
                                                                        itemBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          var img =
                                                                              controller.mediaBySkill[index];
                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              // Aquí puedes agregar la lógica para abrir la imagen en una vista ampliada
                                                                              showDialog(
                                                                                context: context,
                                                                                builder: (BuildContext context) {
                                                                                  return Dialog(
                                                                                    child: Stack(
                                                                                      children: [
                                                                                        Image.network(img),
                                                                                        Positioned(
                                                                                          top: 0,
                                                                                          right: 0,
                                                                                          child: IconButton(
                                                                                            icon: const Icon(
                                                                                              Icons.close,
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              );
                                                                            },
                                                                            child:
                                                                                Stack(
                                                                              children: [
                                                                                Container(
                                                                                  width: 100,
                                                                                  height: 100,
                                                                                  decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                    image: DecorationImage(
                                                                                      fit: BoxFit.cover,
                                                                                      image: NetworkImage(img),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Positioned(
                                                                                  top: 0,
                                                                                  right: 0,
                                                                                  child: IconButton(
                                                                                    icon: const Icon(Icons.delete, color: Colors.red),
                                                                                    onPressed: () async {
                                                                                      // modal de confirmacion

                                                                                      final respuesta = await Get.dialog<bool>(
                                                                                        AlertDialog(
                                                                                          title: const Text('Confirm'),
                                                                                          content: const Text('Are you sure you want to delete this image?'),
                                                                                          actions: [
                                                                                            TextButton(
                                                                                              onPressed: () {
                                                                                                Get.back(result: false);
                                                                                              },
                                                                                              child: const Text('Cancel'),
                                                                                            ),
                                                                                            TextButton(
                                                                                              onPressed: () async {
                                                                                                ProgressDialog pd = ProgressDialog(context: Get.context);
                                                                                                try {
                                                                                                  pd.show(
                                                                                                    max: 100,
                                                                                                    msg: 'Please wait...',
                                                                                                    progressBgColor: Colors.transparent,
                                                                                                  );
                                                                                                  final imageToDelete = controller.mediaBySkill[index];

                                                                                                  await controller.deleteImage(imageToDelete, e['id']);
                                                                                                  controller.mediaBySkill.removeAt(index);

                                                                                                  if (controller.skillsList.any((skill) => skill.idCategory == e['id'])) {
                                                                                                    controller.skillsList.firstWhere((skill) => skill.idCategory == e['id']).media!.removeAt(index);
                                                                                                  }

                                                                                                  await controller.getProfileData();

                                                                                                  controller.prepareSkills();
                                                                                                } catch (e) {
                                                                                                  print(e);
                                                                                                  // lanzo un dialogo de error

                                                                                                  Get.snackbar('Error', 'An error occurred while deleting the image', backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20));
                                                                                                } finally {
                                                                                                  pd.close();
                                                                                                }

                                                                                                Get.back(result: true);
                                                                                              },
                                                                                              child: const Text('Delete'),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      );

                                                                                      // si es true muestro un mensaje que diga skill eliminada

                                                                                      if (respuesta != null && respuesta) {
                                                                                        if (respuesta) {
                                                                                          Get.snackbar('Success!', 'Image deleted', backgroundColor: Colors.green, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20));
                                                                                        }
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  _widgets
                                                                      .registerTaskImageZone(),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          controller.formKey
                                                              .currentState!
                                                              .reset();
                                                          controller
                                                              .costSkill.value
                                                              .clear();
                                                          controller
                                                              .descriptionSkill
                                                              .value
                                                              .clear();
                                                          controller.typeCost
                                                                  .value =
                                                              'per_hour';
                                                          controller.images
                                                              .clear();

                                                          controller
                                                              .minimalHours
                                                              .value = 'hour_1';

                                                          Get.back();
                                                        },
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          if (controller.formKey
                                                              .currentState!
                                                              .validate()) {
                                                            ProgressDialog pd =
                                                                ProgressDialog(
                                                                    context: Get
                                                                        .context);
                                                            try {
                                                              pd.show(
                                                                max: 100,
                                                                msg:
                                                                    'Please wait...',
                                                                progressBgColor:
                                                                    Colors
                                                                        .transparent,
                                                              );

                                                              await controller.createSkill(
                                                                  e["id"],
                                                                  controller
                                                                      .costSkill
                                                                      .value
                                                                      .text,
                                                                  controller
                                                                      .typeCost
                                                                      .value,
                                                                  controller
                                                                      .descriptionSkill
                                                                      .value
                                                                      .text);
                                                              controller.formKey
                                                                  .currentState!
                                                                  .reset();
                                                              controller
                                                                  .costSkill
                                                                  .value
                                                                  .clear();
                                                              controller
                                                                  .descriptionSkill
                                                                  .value
                                                                  .clear();
                                                              controller
                                                                      .typeCost
                                                                      .value =
                                                                  'per_hour';
                                                              controller.images
                                                                  .clear();
                                                              controller
                                                                      .minimalHours
                                                                      .value =
                                                                  'hour_1';
                                                              await controller
                                                                  .getProfileData();
                                                              controller
                                                                  .prepareSkills();
                                                              pd.close();
                                                              Get.back();
                                                              Get.snackbar(
                                                                  'Success!',
                                                                  'Skill created',
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  colorText:
                                                                      Colors
                                                                          .white,
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM,
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          20,
                                                                      left: 20,
                                                                      right:
                                                                          20));
                                                            } catch (e) {
                                                              // muestro un diaglog con el error

                                                              pd.close();
                                                              Get.snackbar(
                                                                  'Error!',
                                                                  'Not possible create skill',
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  colorText:
                                                                      Colors
                                                                          .white,
                                                                  snackPosition:
                                                                      SnackPosition
                                                                          .BOTTOM,
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          20,
                                                                      left: 20,
                                                                      right:
                                                                          20));
                                                            }
                                                          }
                                                        },
                                                        child:
                                                            const Text('Save'),
                                                      ),
                                                    ],
                                                  ),
                                                  barrierDismissible: false,
                                                );
                                              },
                                              activeColor: Colors.indigo[800],
                                              checkColor: Colors.indigo[800],
                                            ),
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(e["attributes"]["name"],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        color:
                                                            Colors.grey[400]),
                                                    textAlign: TextAlign.left),

                                                // icono boton para eliminar
                                                // condicional, solo se muestra si el usuario ya tiene la categoria
                                                if (controller.skillsList.any(
                                                    (skill) =>
                                                        skill.idCategory ==
                                                        e['id'])) ...[
                                                  IconButton(
                                                    onPressed: () async {
                                                      // lanoz un dialogo de confirmacion

                                                      final respuesta =
                                                          await Get.dialog<
                                                              bool>(
                                                        AlertDialog(
                                                          title: const Text(
                                                              'Confirm'),
                                                          content: const Text(
                                                              'Are you sure you want to delete this skill?'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Get.back(
                                                                    result:
                                                                        false);
                                                              },
                                                              child: const Text(
                                                                  'Cancel'),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () async {
                                                                ProgressDialog
                                                                    pd =
                                                                    ProgressDialog(
                                                                        context:
                                                                            Get.context);
                                                                try {
                                                                  pd.show(
                                                                    max: 100,
                                                                    msg:
                                                                        'Please wait...',
                                                                    progressBgColor:
                                                                        Colors
                                                                            .transparent,
                                                                  );

                                                                  await controller
                                                                      .deleteSkill(
                                                                          e['id']);

                                                                  //
                                                                  // elimino de controller.skillsList la skill que acabo de eliminar
                                                                  controller
                                                                      .skillsList
                                                                      .removeWhere((skill) =>
                                                                          skill
                                                                              .idCategory ==
                                                                          e['id']);
                                                                  await controller
                                                                      .getProfileData();
                                                                  controller
                                                                      .prepareSkills();
                                                                } catch (e) {
                                                                  // muestro un diaglog con el error

                                                                  Get.snackbar(
                                                                      'Error!',
                                                                      'Not possible create skill',
                                                                      backgroundColor:
                                                                          Colors
                                                                              .red,
                                                                      colorText:
                                                                          Colors
                                                                              .white,
                                                                      snackPosition:
                                                                          SnackPosition
                                                                              .BOTTOM,
                                                                      margin: const EdgeInsets
                                                                              .only(
                                                                          bottom:
                                                                              20,
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20));
                                                                } finally {
                                                                  pd.close();
                                                                }
                                                                Get.back(
                                                                    result:
                                                                        true);
                                                              },
                                                              child: const Text(
                                                                  'Delete'),
                                                            ),
                                                          ],
                                                        ),
                                                      );

                                                      // si es true muestro un mensaje que diga skill eliminada

                                                      if (respuesta != null &&
                                                          respuesta) {
                                                        if (respuesta) {
                                                          Get.snackbar(
                                                              'Success!',
                                                              'Skill deleted',
                                                              backgroundColor:
                                                                  Colors.green,
                                                              colorText: Colors
                                                                  .white,
                                                              snackPosition:
                                                                  SnackPosition
                                                                      .BOTTOM,
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          20,
                                                                      left: 20,
                                                                      right:
                                                                          20));
                                                        }
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ]
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (controller.skillsList.isNotEmpty) {
                                  Get.toNamed('/register_provider/step2');
                                } else {
                                  Get.snackbar('Information!',
                                      "Pease select one o more skills",
                                      backgroundColor: Colors.yellow,
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin: const EdgeInsets.only(
                                          bottom: 20, left: 20, right: 20));
                                }
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 35),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 15),
                                decoration: BoxDecoration(
                                  color: Colors.amber[800],
                                  borderRadius: BorderRadius.circular(90),
                                ),
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
