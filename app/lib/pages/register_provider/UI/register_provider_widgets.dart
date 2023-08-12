import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';

import 'package:provitask_app/services/preferences.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class RegisterProviderWidgets {
  final _controller = Get.put<ProfileController>(ProfileController());
  final Preferences _preferences = Preferences();

  AppBar registerProAppBAr([int step = 1]) {
    return AppBar(
      elevation: 0,
      toolbarHeight: Get.height * 0.12,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Get.back(),
      ),
      foregroundColor: Colors.amber[800],
      title: Text(
        _controller.titleController(step),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          color: Colors.indigo[800],
        ),
      ),
      centerTitle: true,
    );
  }

  Widget registerProStepper([int step = 1]) {
    // _controller.stepController.value = step;
    return Container(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: Get.width * 0.45,
              margin: const EdgeInsets.only(top: 20),
              child: LinearProgressIndicator(
                value: _controller.stepBarController(step),
                color: Colors.indigo[800],
                backgroundColor: Colors.grey[400],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: Get.width * 0.55,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: const Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          step < 2 ? Colors.grey[400] : Colors.green),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: step < 2
                        ? const Text('2')
                        : const Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.white,
                          ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          _controller.stepController.value < 9
                              ? Colors.grey[400]
                              : Colors.green),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(0)),
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: step < 9
                        ? const Text('3')
                        : const Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.white,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget registerProStepSubtitle([int step = 1]) {
    return Container(
      width: Get.width * 0.75,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: 12),
      child: Text(
        _controller.subtitleController(step),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget registerProFormStep2() {
    return Expanded(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: Get.width * 0.5,
                  height: 40,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 35),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(45),
                        bottomRight: Radius.circular(45)),
                  ),
                  child: Text(
                    'Create Your Account',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(right: Get.width * 0.5),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: Get.width * 0.5,
                  height: 40,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 35),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(45),
                        bottomRight: Radius.circular(45)),
                  ),
                  child: Text(
                    'Select Skills',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(right: Get.width * 0.5),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: Get.width * 0.5,
                height: 40,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 35),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(45),
                      bottomRight: Radius.circular(45)),
                ),
                child: Text(
                  'Verify Your Information',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(right: Get.width * 0.5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.indigo[800],
                  borderRadius: BorderRadius.circular(45),
                ),
                child: const Text(
                  "3",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Get.toNamed('/register_provider/step3');
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
          Container(
            margin: EdgeInsets.only(right: Get.width * 0.4),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 45, bottom: 10),
                      padding:
                          const EdgeInsets.only(left: 15, top: 1, bottom: 1),
                      decoration: BoxDecoration(
                        color: Colors.indigo[800],
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Provitask Tips',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  'How to add positive reviews?',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget registerProFormStep4() {
    return Container(
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
                  _preferences.imageProfile.value,
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
                            final pickedFile = await picker.pickImage(
                              source: ImageSource.camera,
                              maxWidth: 800,
                              maxHeight: 800,
                              imageQuality: 80,
                            );

                            if (pickedFile != null) {
                              // se seleccionó una imagen, la subo al servidor
                              _controller.uploadImage(pickedFile);
                              //Get.toNamed('/register_provider/step4');
                            } else {
                              Get.snackbar(
                                  'Error', 'No se seleccionó ninguna imagen',
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
                              // se seleccionó una imagen, la subo al servidor
                              _controller.uploadImage(pickedFile);
                              //Get.toNamed('/register_provider/step4');
                            } else {
                              Get.snackbar(
                                  'Error', 'No se seleccionó ninguna imagen',
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
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90)))),
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
    );
  }

  Widget registerProFormStep5() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Who do we need this?',
              style: TextStyle(
                  color: Colors.amber[800], fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: _registerProField(
                'Social Security Number',
                '1201-1231-1321-123',
                _controller.socialSecNumber.value,
                Get.width * 0.7),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: _registerProField(
                'Street Number and Name',
                '1231 2oinas afsfa',
                _controller.address.value,
                Get.width * 0.7),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: _registerProField('', 'apt / suite',
                      _controller.aptSuite.value, Get.width * 0.35),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: _registerProField('City', 'Hialaten',
                      _controller.city.value, Get.width * 0.35),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: _registerProField(
                      'State', 'Fl', _controller.state.value, Get.width * 0.35),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: _registerProField('Zip Code', '33010',
                      _controller.zipCode.value, Get.width * 0.35),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.topLeft,
            child: _registerProField(
              'Date of Birth',
              '22-11-1999',
              _controller.birthDate.value,
              Get.width * 0.4,
              onTap: () async {
                DateTime? date = await showDatePicker(
                    context: Get.context!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2030));

                _controller.birthDate.value.text =
                    date.toString().substring(0, 10);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'All your personal data will be kept and kept\nconfidential.',
              style: TextStyle(
                color: Colors.indigo[800],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (_controller.validateFields()) {
                final respuesta = await _controller.saveMetaUser();

                if (respuesta) {
                  /*  Future.delayed(const Duration(seconds: 2));
                  Get.snackbar(
                    'Success!',
                    'Metadata updated',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );*/

                  Get.toNamed('/register_provider/step6');
                } else {
                  Get.snackbar('Error!', 'Not possible update metadata',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: const EdgeInsets.only(
                          bottom: 20, left: 20, right: 20));
                }
              } else {
                Get.snackbar('Information!', "Pease fill all the fields",
                    backgroundColor: Colors.yellow,
                    snackPosition: SnackPosition.BOTTOM,
                    colorText: Colors.white,
                    margin:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20));
              }
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

  Widget registerProFormStep6() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque suscipit diam in lacus ultricies ultricies. Aenean hendrerit eget dui vitae rutrum. Cras nec elementum neque. Fusce ut ullamcorper leo. Nunc ac bibendum velit. Etiam nec sodales libero. Maecenas et nunc libero. Nam et finibus purus. Pellentesque hendrerit erat ac neque semper blandit. In lacinia augue urna, id egestas ante euismod non. Fusce eu tortor aliquet, laoreet elit molestie, vestibulum nunc.',
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque suscipit diam in lacus ultricies ultricies. Aenean hendrerit eget dui vitae rutrum. Cras nec elementum neque. Fusce ut ullamcorper leo. Nunc ac bibendum velit. Etiam nec sodales libero. Maecenas et nunc libero. Nam et finibus purus. Pellentesque hendrerit erat ac neque semper blandit. In lacinia augue urna, id egestas ante euismod non. Fusce eu tortor aliquet, laoreet elit molestie, vestibulum nunc.',
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque suscipit diam in lacus ultricies ultricies. Aenean hendrerit eget dui vitae rutrum. Cras nec elementum neque. Fusce ut ullamcorper leo. Nunc ac bibendum velit. Etiam nec sodales libero. Maecenas et nunc libero. Nam et finibus purus. Pellentesque hendrerit erat ac neque semper blandit. In lacinia augue urna, id egestas ante euismod non. Fusce eu tortor aliquet, laoreet elit molestie, vestibulum nunc.',
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: _registerProField('First and Last Name', 'Mateo Gomez',
                _controller.firstAndLastName.value, Get.width * 0.8,
                labelColor: Colors.amber[800]!),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Enter your first and last name to continue, and accept the terms and conditions.',
              style: TextStyle(
                color: Colors.amber[800],
              ),
            ),
          ),
          registerProContinueButton('I accept all the terms', 7, () async {
            if (_controller.firstAndLastName.value.text.isNotEmpty) {
              final respuesta = await _controller.saveMetaUser();

              if (respuesta) {
                /*  Future.delayed(const Duration(seconds: 2));
                Get.snackbar(
                  'Success!',
                  'Metadata updated',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );*/

                Get.toNamed('/register_provider/step7');
              } else {
                Get.snackbar('Error!', 'Not possible update metadata',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    margin:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20));
              }
            } else {
              Get.snackbar('Information!', "Pease enter your name",
                  backgroundColor: Colors.yellow,
                  snackPosition: SnackPosition.BOTTOM,
                  margin:
                      const EdgeInsets.only(bottom: 20, left: 20, right: 20));
            }
          }, bgColor: Colors.indigo[800]!),
        ],
      ),
    );
  }

  Widget registerProFormStep7() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque suscipit diam in lacus ultricies ultricies. Aenean hendrerit eget dui vitae rutrum. Cras nec elementum neque. Fusce ut ullamcorper leo. Nunc ac bibendum velit. Etiam nec sodales libero. Maecenas et nunc libero. Nam et finibus purus. Pellentesque hendrerit erat ac neque semper blandit. In lacinia augue urna, id egestas ante euismod non. Fusce eu tortor aliquet, laoreet elit molestie, vestibulum nunc.',
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque suscipit diam in lacus ultricies ultricies. Aenean hendrerit eget dui vitae rutrum. Cras nec elementum neque. Fusce ut ullamcorper leo. Nunc ac bibendum velit. Etiam nec sodales libero. Maecenas et nunc libero. Nam et finibus purus. Pellentesque hendrerit erat ac neque semper blandit. In lacinia augue urna, id egestas ante euismod non. Fusce eu tortor aliquet, laoreet elit molestie, vestibulum nunc.',
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Checkbox(
                    value: _controller.checkPolicy.value,
                    activeColor: Colors.amber[800],
                    onChanged: (value) {
                      _controller.checkPolicy.value = value!;
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              const Flexible(
                flex: 10,
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque suscipit diam in lacus ultricies ultricies. Aenean hendrerit eget dui vitae rutrum. Cras nec elementum neque. Fusce ut ullamcorper leo. Nunc ac bibendum velit. Etiam nec sodales libero. Maecenas et nunc libero. Nam et finibus purus. Pellentesque hendrerit erat ac neque semper blandit. In lacinia augue urna, id egestas ante euismod non. Fusce eu tortor aliquet, laoreet elit molestie, vestibulum nunc.',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ),
            ],
          ),
          registerProContinueButton('I agree', 70, () {
            if (_controller.checkPolicy.value) {
              Get.toNamed('/register_provider/step8');
            } else {
              Get.snackbar(
                  'Information!', 'You must agree to the terms and conditions.',
                  backgroundColor: Colors.yellow,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin:
                      const EdgeInsets.only(bottom: 20, left: 20, right: 20));
            }
          }, bgColor: Colors.indigo[800]!),
        ],
      ),
    );
  }

  Widget registerProFormStep8() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        children: [
          const Text(
            'To help us maintain our platform secure as well as provide best customer service, we charge a one-time registration fee.',
            style: TextStyle(color: Colors.grey, fontSize: 17),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Tasker Registration Fee',
                  style: TextStyle(
                      color: Colors.amber[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '\$15',
                    style: TextStyle(
                        color: Colors.indigo[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    width: Get.width * 0.15,
                    height: Get.width * 0.2,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/REGISTER PROVIDER/money_provider.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque suscipit diam in lacus ultricies ultricies. Aenean hendrerit eget dui vitae rutrum. Cras nec elementum neque. Fusce ut ullamcorper leo. Nunc ac bibendum velit.',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),
              ],
            ),
          ),
          registerProContinueButton('Pay & continue', 30, () async {
            await _controller.initPaymentSheet();
          }, bgColor: Colors.indigo[800]!),
        ],
      ),
    );
  }

  Widget registerProFormStep9() {
    return Column(
      children: [
        Container(
          width: Get.width,
          height: Get.height * 0.55,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/REGISTER PROVIDER/succes_provider.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: Get.width * 0.8,
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: const Text(
            'You criminal history chech is begin processed, wich should take 3-5 business days to complete.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
        ),
        registerProContinueButton('Continue', 10, () {
          /*  Get.put<VerificationProviderController>(
              VerificationProviderController());
          Get.offNamed('/verification_provider');*/

          Get.offAllNamed('/profile_client');
        }, bgColor: Colors.indigo[800]!),
      ],
    );
  }

  Widget _registerProField(String label, String hintText,
      TextEditingController fieldController, double width,
      {void Function()? onTap, Color labelColor = Colors.grey}) {
    return Container(
      width: width,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(bottom: 5),
            child: Text(
              label,
              style: TextStyle(
                color: labelColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              border: Border.all(
                color: Colors.grey[400]!,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            child: TextField(
              controller: fieldController,
              onTap: onTap,
              decoration: InputDecoration.collapsed(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget registerProContinueButton(
      String text, double margin, void Function() onTap,
      {Color bgColor = Colors.amber}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(bgColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90),
            ),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget registerTaskImageZone() {
    return Obx(
      () => Container(
        // height: Get.height * 0.2,
        width: Get.width * 0.9,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            if (_controller.images.isNotEmpty) ...[
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: _controller.images.length,
                  itemBuilder: (BuildContext context, int index) {
                    var img = _controller.images[index];
                    return Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(img!),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _controller.images.remove(img),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
            Visibility(
              visible: _controller.images.length < 10 &&
                  _controller.mediaBySkill.length < 10,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity, // Hace que el botón ocupe todo el ancho
                child: ElevatedButton.icon(
                  icon:
                      const Icon(Icons.add_a_photo), // Añade un icono al botón
                  label: Text(
                    'Add images',
                    style: TextStyle(
                      color: Colors.indigo[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: Get.context!,
                      builder: (context) => AlertDialog(
                        title: const Text('Select an option'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Take a photo'),
                              onTap: () async {
                                Navigator.pop(context);
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                  source: ImageSource.camera,
                                  maxWidth: 800,
                                  maxHeight: 800,
                                  imageQuality: 80,
                                );
                                if (pickedFile == null) return;
                                _controller.images.clear();
                                int length = await pickedFile.length();
                                // uno controller.mediaBySkill  y controller.images para calcular el tamaño

                                final countRest =
                                    _controller.mediaBySkill.length;

                                final count = 10 - countRest;
                                if (length <= 20000000 &&
                                    _controller.images.length < count) {
                                  _controller.images.add(File(pickedFile.path));
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo),
                              title: const Text('Select from gallery'),
                              onTap: () async {
                                Navigator.pop(context);
                                final picker = ImagePicker();
                                final List<XFile> pickedFile =
                                    await picker.pickMultiImage(
                                  maxWidth: 800,
                                  maxHeight: 800,
                                  imageQuality: 80,
                                );

                                if (pickedFile.isEmpty) return;

                                //vacio el array de imagenes

                                _controller.images.clear();
                                final countRest =
                                    _controller.mediaBySkill.length;

                                final count = 10 - countRest;
                                for (var img in pickedFile) {
                                  int length = await img.length();
                                  if (length <= 20000000 &&
                                      _controller.images.length < count) {
                                    _controller.images.add(File(img.path));
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90),
                    )),
                  ),
                ),
              ),
            ),
            const Text(
              'Máximo 20MB por imagen, máximo 10 imágenes',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

formatImages(image, [bool? general = false]) {
  final List<String> images = [];

  for (var img in image) {
    images.add(img);
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
