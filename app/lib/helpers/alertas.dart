import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provitask_app/constants/app_colors.dart';
import 'package:provitask_app/constants/app_sizes.dart';
import 'package:provitask_app/constants/app_text_styles.dart';

mosrtarAlerta(String titulo, String? subtitulo) {
  final context = Get.context!;
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(titulo),
              content: subtitulo != null ? Text(subtitulo) : null,
              actions: [
                MaterialButton(
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ok"))
              ],
            ));
  }

  showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title: Text(titulo),
            content: subtitulo != null ? Text(subtitulo) : null,
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text("Ok"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ));
}

Future<dynamic> inputModalPassWord(BuildContext context) async {
  TextEditingController emailCtrl = TextEditingController();
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                "Recupera tu contraseña",
                textAlign: TextAlign.center,
                style: poppinsBold,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      "Ingresa tu correo electrónico registrado para enviarte un código de confirmación.",
                      textAlign: TextAlign.center,
                      style: poppinsLight.copyWith(color: AppColors.greyColor)),
                  TextFormField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "Ingresa tu correo registrado",
                        hintStyle:
                            poppinsLight.copyWith(color: AppColors.greyColor)),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  child: Text("Cancelar", style: poppinsLight),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(
                  color: AppColors.orangeMainColor,
                  child: Text("Confirmar", style: poppinsBold),
                  onPressed: () {
                    if (emailCtrl.text != "") {
                      Navigator.pop(context, emailCtrl.text);
                    }
                  },
                )
              ],
            ));
  }

  return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: const Text("Recupera tu contraseña"),
            content: Column(
              children: [
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
                Text(
                    "Ingresa tu correo electrónico registrado para enviarte un código de confirmación",
                    style: poppinsLight.copyWith(color: AppColors.greyColor)),
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
                CupertinoTextField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  placeholder: "Ingresa tu correo registrado",
                  placeholderStyle:
                      poppinsLight.copyWith(color: AppColors.greyColor),
                ),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: false,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancelar"),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  if (emailCtrl.text != "") {
                    Navigator.pop(context, emailCtrl.text);
                  }
                },
                child: const Text("Confirmar"),
              )
            ],
          ));
}

customSnackBar(String titulo, String mensage, Color color) {
  Get.snackbar(
    titulo,
    mensage,
    duration: const Duration(seconds: 2),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: color,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    borderColor: color,
    borderWidth: 2,
  );
}
