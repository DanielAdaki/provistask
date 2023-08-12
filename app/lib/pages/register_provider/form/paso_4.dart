import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_widgets.dart';

class RegisterProviderPage4 extends GetView<ProfileController> {
  final _widgets = RegisterProviderWidgets();

  RegisterProviderPage4({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _widgets.registerProAppBAr(4),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                _widgets.registerProStepper(4),
                _widgets.registerProStepSubtitle(4),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        width: Get.width * 0.5,
                        height: Get.width * 0.5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              ConexionCommon.hostBase +
                                  controller.clientImage.value,
                            ),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.amber[800]!,
                            width: 8,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: ElevatedButton(
                          onPressed: () {
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
                                        final pickedFile =
                                            await picker.pickImage(
                                          source: ImageSource.camera,
                                          maxWidth: 800,
                                          maxHeight: 800,
                                          imageQuality: 80,
                                        );

                                        if (pickedFile != null) {
                                          // verifico el tamaño de la imagen

                                          final size =
                                              await pickedFile.length();

                                          // debe ser menor 5 megas

                                          if (size > 5000000) {
                                            Get.snackbar('Error',
                                                'The image must be less than 5 megabytes',
                                                backgroundColor: Colors.red,
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                margin: const EdgeInsets.only(
                                                    bottom: 20,
                                                    left: 20,
                                                    right: 20));
                                            return;
                                          }

                                          controller.uploadImage(pickedFile);
                                          //Get.toNamed('/register_provider/step4');
                                        } else {
                                          Get.snackbar('Error',
                                              'No se seleccionó ninguna imagen',
                                              backgroundColor: Colors.red,
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              margin: const EdgeInsets.only(
                                                  bottom: 20,
                                                  left: 20,
                                                  right: 20));
                                        }
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.photo),
                                      title:
                                          const Text('Seleccionar de galería'),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        final picker = ImagePicker();
                                        final pickedFile =
                                            await picker.pickImage(
                                          source: ImageSource.gallery,
                                          maxWidth: 800,
                                          maxHeight: 800,
                                          imageQuality: 80,
                                        );

                                        if (pickedFile != null) {
                                          final size =
                                              await pickedFile.length();

                                          // debe ser menor 5 megas

                                          if (size > 5000000) {
                                            Get.snackbar('Error',
                                                'The image must be less than 5 megabytes',
                                                backgroundColor: Colors.red,
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                margin: const EdgeInsets.only(
                                                    bottom: 20,
                                                    left: 20,
                                                    right: 20));
                                            return;
                                          }
                                          controller.uploadImage(pickedFile);
                                          //Get.toNamed('/register_provider/step4');
                                        } else {
                                          Get.snackbar('Error',
                                              'No se seleccionó ninguna imagen',
                                              backgroundColor: Colors.red,
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              margin: const EdgeInsets.only(
                                                  bottom: 20,
                                                  left: 20,
                                                  right: 20));
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(90)))),
                          child: Text(
                            'Change Photo',
                            style: TextStyle(
                                color: Colors.indigo[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // un delay para que se suba la imagen al servidor

                          //    Future.delayed(const Duration(seconds: 2));

                          Get.toNamed('/register_provider/step5');
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
