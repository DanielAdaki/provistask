import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_widgets.dart';

class RegisterProviderPage3 extends GetView<ProfileController> {
  final _widgets = RegisterProviderWidgets();

  RegisterProviderPage3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _widgets.registerProAppBAr(3),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                _widgets.registerProStepper(3),
                _widgets.registerProStepSubtitle(3),
                registerProFormStep3(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget registerProFormStep3() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: Get.width * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {},
                      child: Obx(() {
                        final imageUrl = ConexionCommon.hostBase +
                            controller.clientImage.value;
                        if (imageUrl.isNotEmpty) {
                          return CircleAvatar(
                            radius: Get.width * 0.12,
                            backgroundImage: NetworkImage(imageUrl),
                          );
                        } else {
                          return CircleAvatar(
                            radius: Get.width * 0.12,
                            backgroundImage: const AssetImage(
                                'assets/images/REGISTER PROVIDER/icon_provider.png'),
                          );
                        }
                      }),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.grey[400],
                      size: Get.width * 0.12,
                    ),
                    Container(
                      width: Get.width * 0.25,
                      height: Get.width * 0.25,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/REGISTER PROVIDER/person_provider.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 110),
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () async {
                    showDialog(
                      context: Get.context!,
                      builder: (context) => AlertDialog(
                        title: const Text('Selecciona una opción'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Tomar foto'),
                              onTap: () async {
                                Navigator.pop(context);
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                  source: ImageSource.camera,
                                  maxWidth: 800,
                                  maxHeight: 800,
                                  imageQuality: 80,
                                );

                                if (pickedFile != null) {
                                  // verifco el tamaño de la imagen
                                  final size = await pickedFile.length();
                                  Logger().i('Tamaño de la imagen: $size');

                                  // debe ser menor 5 megas

                                  if (size > 5000000) {
                                    Get.snackbar('Error',
                                        'The image must be less than 5 megabytes',
                                        backgroundColor: Colors.red,
                                        snackPosition: SnackPosition.BOTTOM,
                                        margin: const EdgeInsets.only(
                                            bottom: 20, left: 20, right: 20));
                                    return;
                                  }

                                  controller.uploadImage(pickedFile);
                                  Get.toNamed('/register_provider/step4');
                                } else {
                                  Get.snackbar('Error',
                                      'No se seleccionó ninguna imagen',
                                      backgroundColor: Colors.red,
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin: const EdgeInsets.only(
                                          bottom: 20, left: 20, right: 20));
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo),
                              title: const Text('Seleccionar de galería'),
                              onTap: () async {
                                Navigator.pop(context);
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  maxWidth: 800,
                                  maxHeight: 800,
                                  imageQuality: 80,
                                );

                                if (pickedFile != null) {
                                  // verifco el tamaño de la imagen

                                  final size = await pickedFile.length();

                                  Logger().i('Tamaño de la imagen: $size');

                                  // debe ser menor 5 megas

                                  if (size > 5000000) {
                                    Get.snackbar('Error',
                                        'The image must be less than 5 megabytes',
                                        backgroundColor: Colors.red,
                                        snackPosition: SnackPosition.BOTTOM,
                                        margin: const EdgeInsets.only(
                                            bottom: 20, left: 20, right: 20));
                                    return;
                                  }

                                  controller.uploadImage(pickedFile);
                                  Get.toNamed('/register_provider/step4');
                                } else {
                                  Get.snackbar('Error',
                                      'No se seleccionó ninguna imagen',
                                      backgroundColor: Colors.red,
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin: const EdgeInsets.only(
                                          bottom: 20, left: 20, right: 20));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.amber[800],
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: const Text(
                      'Click to add photo',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: const Text(
              'A nice photo improves your chance of getting employed. \nHere are a few photography tips:',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Container(
            width: Get.width * 0.8,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check,
                  color: Colors.amber[800],
                  size: 30,
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Smile at the camera',
                    style: TextStyle(
                      color: Colors.indigo[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width * 0.8,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check,
                  color: Colors.amber[800],
                  size: 30,
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Take a portrit of yourself from the chest up',
                    style: TextStyle(
                      color: Colors.indigo[800],
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width * 0.8,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check,
                  color: Colors.amber[800],
                  size: 30,
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Make sure it\'s well-lit and focused',
                    style: TextStyle(
                      color: Colors.indigo[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: Get.width * 0.8,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check,
                  color: Colors.amber[800],
                  size: 30,
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Remove any hats or sunglasses \n you may have',
                    style: TextStyle(
                      color: Colors.indigo[800],
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    textWidthBasis: TextWidthBasis.parent,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: const Text(
              'If your photo does not meet these requeriments, account \nactivation may be delayed.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          InkWell(
            onTap: () async {
              Get.toNamed('/register_provider/step4');
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              padding: const EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.amber[800],
                borderRadius: BorderRadius.circular(90),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
