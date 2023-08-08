import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';

class RegisterSuccesPage extends GetView<ProfileController> {
  const RegisterSuccesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                // muestro un texto que diga que se registro correctamente y arriba un icono de check grnade

                child: Column(children: [
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    size: 100,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'You have been registered successfully',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //mando al perfil del usuario
                      Get.offAllNamed('/profile_client');
                    },
                    child: const Text('Continue'),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
