import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:get/get.dart';

import 'package:provitask_app/common/conexion_common.dart';
import 'package:provitask_app/models/data/client_information.dart';
import 'package:provitask_app/pages/payments_methods/UI/payments_metods_controller.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';
import 'package:provitask_app/pages/register_provider/UI/register_provider_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provitask_app/pages/chat/chat_home/UI/chat_home_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provitask_app/controllers/auth/login_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileClientWidgets {
  final _controller = Get.put<ProfileController>(ProfileController());

  AppBar profileAppBar([String? title]) {
    return AppBar(
      actions: [
        // boton de deslogueo con un icono
        IconButton(
          onPressed: () {
            // limpio los campos
            _controller.logout();
          },
          icon: const Icon(
            Icons.logout,
            color: Color(0xffD06605),
          ),
        ),
      ],
      title: Text(
        title ?? '',
        style: const TextStyle(
          color: Color(0xffD06605),
          fontSize: 28,
          //pongo italica
        ),
      ),
      centerTitle: true,
      leading: IconButton(
          // si el titulo es "change password" entonces al presionar el boton de atras se regresa de edicion de perfil

          onPressed: () {
            if (Get.currentRoute == '/edit-password') {
              Get.toNamed('/profile_client');
              // limpio los campos
              _controller.stateClear();
            } else if (Get.currentRoute == '/profile_client') {
              Get.toNamed('/home');
              // limpio los campos
              _controller.stateClear();
            } else {
              Get.back();
            }
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xffD06605),
          )),
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xffD06605),
      elevation: 0,
      toolbarHeight: Get.height * 0.1,
    );
  }

  Drawer homeDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Image.asset(
              'assets/images/logo3.png',
              width: Get.width * 0.4,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.indigo[900],
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Colors.indigo[900],
              ),
            ),
            onTap: () => Get.back(),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.indigo[900],
            ),
            title: Text(
              'Profile',
              style: TextStyle(
                color: Colors.indigo[900],
              ),
            ),
            onTap: () {
              if (!ClientInformation.isLoggedIn) {
                Get.put<LoginController>(LoginController());
                Get.toNamed('/login');
              } else {
                // Get.put<ProfileController>(ProfileController());
                Get.toNamed('/profile_client');
              }
            },
          ),
          ListTile(
            leading: Icon(
              Icons.message,
              color: Colors.indigo[900],
            ),
            title: Text(
              'Chat',
              style: TextStyle(
                color: Colors.indigo[900],
              ),
            ),
            onTap: () {
              Get.put<ChatHomeController>(ChatHomeController());
              Get.toNamed('/chat_home');
            },
          ),
        ],
      ),
    );
  }

  // widget de imagen de perfil, solo la imagen

  Widget profileImage() {
    // envuelvo en un gesturedetector para que al hacer tap en la imagen se pueda cambiar subiendo una nueva imagen

    return Center(
      child: GestureDetector(
        onTap: () async {
          if (await Permission.storage.request().isGranted) {
            // permiso concedido, abre la galería para seleccionar una imagen
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
            }
            // Resto del código para manejar la imagen seleccionada
          } else {
            showDialog(
              context: Get.context!,
              builder: (context) => const AlertDialog(
                title: Text('Permiso denegado'),
                content: Text('No se puede acceder a la galería sin permiso'),
              ),
            );
          }
        },
        child: Container(
          height: Get.width * 0.28,
          width: Get.width * 0.28,
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            image: DecorationImage(
              image: NetworkImage(
                  ConexionCommon.hostBase + _controller.clientImage.value),

              /* image: NetworkImage(
                  ConexionCommon.hostBase + ClientInformation.clientImage!),*/
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 3,
                offset: const Offset(0, 5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // un widget ocn una lista que redirige a su sección correspondiente. Las opciones son , no posee sombra sino que cada oipcion tiene una linea de separación y una flecha para indicar que es un boton que redirige a otra sección

  // 1. Editar perfil
  // 2. Editar contraseña
  // 3. Payment methods
  // 4. Notificaciones

  Widget profileOptions() {
    return Container(
      width: Get.width * 0.9,
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.amber[900],
            ),
            title: const Text(
              'Edit profile',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Get.toNamed('/edit-perfil');
            },
          ),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.amber[900],
            ),
            title: const Text(
              'Change password',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Get.toNamed('/edit-password');
            },
          ),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          // ListTile(
          //   trailing: Icon(
          //     Icons.arrow_forward_ios,
          //     color: Colors.amber[900],
          //   ),
          //   title: const Text(
          //     'Payment methods',
          //     style: TextStyle(
          //       color: Colors.grey,
          //     ),
          //   ),
          //   onTap: () {
          //     //Get.put<PaymentsMethodsController>(PaymentsMethodsController());
          //     Get.toNamed('/payments_methods');
          //   },
          // ),
          // const Divider(
          //   color: Colors.grey,
          //   height: 20,
          //   thickness: 1,
          //   indent: 20,
          //   endIndent: 20,
          // ),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.amber[900],
            ),
            title: const Text(
              'Notifications',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Get.toNamed('/notifications');
            },
          )
        ],
      ),
    );
  }

  Widget providerForm() {
    return Container(
      width: Get.width * 0.9,
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.amber[900],
            ),
            title: const Text(
              'Vehicles',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Get.toNamed('/profile_client/edit-vehicles');
            },
          ),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.amber[900],
            ),
            title: const Text(
              'About Me',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Get.toNamed('/profile_client/edit-about');
            },
          ),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.amber[900],
            ),
            title: const Text(
              'Skills',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Get.toNamed('/profile_client/edit-skills');
            },
          ),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.amber[900],
            ),
            title: const Text(
              'Payment methods',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Get.toNamed('/profile_client/payments_methods');
            },
          ),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.amber[900],
            ),
            title: const Text(
              'Location Services',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            onTap: () {
              Get.toNamed('/profile_client//edit-services-location');
            },
          ),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }

  Widget paymentForm() {
    // contenedor con un boton y un indicardor que diga enlazar stripe

    return Container(
      width: Get.width * 0.9,
      padding: const EdgeInsets.all(15),
      // necesito una fila que tenga  una imagen de stripe y al lado un boton que diga enlazar stripe

      child: Column(
        children: [
          const Row(
            // texto que diga que acá puede vincular la cuenta stripe para recibir pagos

            children: [
              Text(
                'Link your stripe account to receive payments',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // imagen que apunte a app\assets\images\stripe.png

                Image.asset(
                  'assets/images/stripe.png',
                  width: 100,
                ),
                _controller.prefs.user!["is_stripe_connect"] != true
                    ? ElevatedButton(
                        onPressed: () async {
                          ProgressDialog pd =
                              ProgressDialog(context: Get.context);
                          pd.show(
                            max: 100,
                            msg: 'Please wait...',
                            progressBgColor: Colors.transparent,
                          );
                          try {
                            dynamic response =
                                await _controller.createStripeAccount();

                            pd.close();

                            final uriUrl = Uri.parse(response);
                            await canLaunchUrl(uriUrl)
                                ? await launchUrl(
                                    uriUrl,
                                    webViewConfiguration:
                                        const WebViewConfiguration(
                                      enableJavaScript: true,
                                    ),
                                    mode: LaunchMode.inAppWebView,
                                  )
                                : throw 'Could not launch URL';
                          } catch (e) {
                            // log(e.toString());
                            pd.close();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffD06605),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Link Stripe',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          ProgressDialog pd =
                              ProgressDialog(context: Get.context);
                          pd.show(
                            max: 100,
                            msg: 'Please wait...',
                            progressBgColor: Colors.transparent,
                          );
                          try {
                            await _controller.createStripeAccount();

                            pd.close();

                            // muestro un dialogo que diga que se desvinculo la cuenta

                            Get.defaultDialog(
                              title: 'Success',
                              middleText: 'Stripe account unlinked',
                              textConfirm: 'Ok',
                              barrierDismissible: false,
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                // update controllersa

                                _controller.getProfileData();

                                Get.back();
                              },
                            );
                          } catch (e) {
                            // log(e.toString());
                            pd.close();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffD06605),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Unlink stripe'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileImageCard() {
    return Container(
      width: Get.width * 0.9,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: Get.width * 0.28,
            width: Get.width * 0.28,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              border: Border.all(color: const Color(0xffD06605), width: 7),
              image: const DecorationImage(
                image: AssetImage('assets/images/person.jpeg'),
                /* image: NetworkImage(
                    ConexionCommon.hostBase + ClientInformation.clientImage!),*/
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.indigo[800],
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: const Text(
                      "Full Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Client Name",
                    style: TextStyle(
                      color: Colors.indigo[200],
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.indigo[800],
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: const Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "client@client.com",
                    style: TextStyle(
                      color: Colors.indigo[200],
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              // width: 50,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.indigo[800],
                                borderRadius: BorderRadius.circular(90),
                              ),
                              child: const Text(
                                "Zip Code",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 200,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "zip code",
                              style: TextStyle(
                                color: Colors.indigo[200],
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo[100]),
                        minimumSize:
                            MaterialStateProperty.all(const Size(30, 30)),
                        shape: MaterialStateProperty.all<CircleBorder>(
                          const CircleBorder(),
                        ),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(0)),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.indigo[800],
                      ),
                      onPressed: () => _showDialodData(),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget profileNotificationSwitch() => Container(
        width: Get.width * 0.9,
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Allow Notifications',
              style: TextStyle(color: Colors.grey[600], fontSize: 22),
            ),
            FlutterSwitch(
              value: _controller.allowNotifications.value,
              onToggle: (value) {
                _controller.allowNotifications.value =
                    !_controller.allowNotifications.value;
              },
              height: 30,
              width: 50,
              activeColor: const Color(0xffD06605),
            ),
          ],
        ),
      );

  Widget profileButtons() {
    return SizedBox(
      width: Get.width * 0.8,
      height: Get.height * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Get.put(PaymentMethodsController());
              Get.toNamed('/payment-methods');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3),
              width: Get.width * 0.5,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.indigo[800]!, width: 2),
                borderRadius: BorderRadius.circular(90),
              ),
              child: Text(
                'Payment Methods',
                style: TextStyle(
                  color: Colors.indigo[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => _showMessageInformation(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3),
              alignment: Alignment.center,
              width: Get.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.indigo[800]!, width: 2),
                borderRadius: BorderRadius.circular(90),
              ),
              child: Text(
                'Change Password',
                style: TextStyle(
                  color: Colors.indigo[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              final rePro = Get.put<RegisterProviderController>(
                  RegisterProviderController());
              await rePro.getSkills().then((data) {
                if (data) {
                  Get.toNamed('/verification_provider');
                } else {
                  Get.snackbar(
                    'ERROR!',
                    "Error loading data!!",
                    backgroundColor: Colors.red,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3),
              alignment: Alignment.center,
              width: Get.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.indigo[800]!, width: 2),
                borderRadius: BorderRadius.circular(90),
              ),
              child: Text(
                'Join to Providers',
                style: TextStyle(
                  color: Colors.indigo[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3),
              alignment: Alignment.center,
              width: Get.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.indigo[800]!, width: 2),
                borderRadius: BorderRadius.circular(90),
              ),
              child: Text(
                'Support',
                style: TextStyle(
                  color: Colors.indigo[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xffD06605)),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 45),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90),
                ),
              ),
            ),
            child: const Text(
              'Sign Out',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialodData() => showDialog(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          actions: [
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                decoration: BoxDecoration(
                    color: const Color(0xffD06605),
                    borderRadius: BorderRadius.circular(90)),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width,
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.indigo[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: const Text(
                  'Info Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Name:',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.45,
                      child: TextField(
                        controller: _controller.clientName.value,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration.collapsed(
                          hintText: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                indent: 5,
                endIndent: 5,
                height: 2,
                color: Colors.grey[400],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Last Name:',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.45,
                      child: TextField(
                        controller: _controller.clientLastName.value,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration.collapsed(
                          hintText: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                indent: 5,
                endIndent: 5,
                height: 2,
                color: Colors.grey[400],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Email:',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.45,
                      child: TextField(
                        controller: _controller.clientEmail.value,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration.collapsed(
                          hintText: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                indent: 5,
                endIndent: 5,
                height: 2,
                color: Colors.grey[400],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Phone Number:',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.45,
                      child: TextField(
                        controller: _controller.clientPhone.value,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration.collapsed(
                          hintText: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                indent: 5,
                endIndent: 5,
                height: 2,
                color: Colors.grey[400],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Zip Coode:',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.45,
                      child: TextField(
                        controller: _controller.clientZipCode.value,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration.collapsed(
                          hintText: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                indent: 5,
                endIndent: 5,
                height: 2,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      );

  void _showChagePassword() => showDialog(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          actions: [
            InkWell(
              onTap: () => _controller.passwordVerification(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                decoration: BoxDecoration(
                    color: const Color(0xffD06605),
                    borderRadius: BorderRadius.circular(90)),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width,
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.indigo[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: const Text(
                  'Change Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Password:',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.45,
                      child: TextField(
                        controller: _controller.clientResetPassword.value,
                        textAlign: TextAlign.right,
                        obscureText: true,
                        decoration: const InputDecoration.collapsed(
                          hintText: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Confirm Password:',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.4,
                      child: TextField(
                        controller: _controller.clientConfirmPassword.value,
                        textAlign: TextAlign.right,
                        obscureText: true,
                        decoration: const InputDecoration.collapsed(
                          hintText: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Confirmation code:',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.4,
                      child: TextField(
                        controller: _controller.clientResetCode.value,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration.collapsed(
                          hintText: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void _showMessageInformation() async {
    //if (await SendMail.forgotPassword()) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        actions: [
          InkWell(
            onTap: () {
              Get.back();
              _showChagePassword();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
              decoration: BoxDecoration(
                  color: const Color(0xffD06605),
                  borderRadius: BorderRadius.circular(90)),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
              decoration: BoxDecoration(
                color: Colors.indigo[100],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: const Text(
                'Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'We have sent a confirmation code to your email',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                ))
          ],
        ),
      ),
    );
    // }
  }

  Widget registerFrom() {
    // ejecuto la funcion para obtener los paises getAllPhoneCodes() que est'a en el controlador

    _controller.getAllPhoneCodes();

    return Form(
      key: _controller.formKey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: registerNameField()),
                Expanded(child: registerSurnameField()),
              ],
            ),
          ),
          registerEmailField(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: registerPhoneCodeSelect(),
                ),
                Expanded(
                  child: registerPhoneField(),
                ),
              ],
            ),
          ),
          registerPostalCodeField(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
            margin: const EdgeInsets.only(top: 10),
            child: const Text(
              'Your phone and zip code help us find the right freelancers and get in touch with',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          registerButton()
        ],
      ),
    );
  }

  Widget registerNameField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: _controller.clientName.value,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          labelText: 'Name',
          labelStyle: TextStyle(
            fontSize: 20,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) return 'Please enter your name';
          return null;
        },
      ),
    );
  }

  Widget registerSurnameField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: _controller.clientLastName.value,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          labelText: 'Surname',
          labelStyle: TextStyle(
            fontSize: 20,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) return 'Please enter your surname';
          return null;
        },
      ),
    );
  }

  Widget registerEmailField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
      child: TextFormField(
        controller: _controller.clientEmail.value,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(
            fontSize: 20,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) return 'Please enter your email';
          if (!value.isValidEmail()) return 'Please enter a valid email';
          return null;
        },
      ),
    );
  }

  Widget registerPasswordField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: _controller.clientPassword.value,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
            fontSize: 20,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the password';
          }

          if (value.length < 6) {
            return 'The password must be at least 6 characters';
          }

          if (value != _controller.clientConfirmPassword.value.text) {
            return 'The passwords do not match';
          }

          return null;
        },
      ),
    );
  }

  Widget registerConfirmPasswordField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: _controller.clientConfirmPassword.value,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          labelText: 'Confirm Password',
          labelStyle: TextStyle(
            fontSize: 20,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the password';
          }
          if (value.length < 6) {
            return 'The password must be at least 6 characters';
          }

          if (value != _controller.clientPassword.value.text) {
            return 'The passwords do not match';
          }
          return null;
        },
      ),
    );
  }

  Widget registerPhoneCodeSelect() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(top: 10),
      child: DropdownButtonFormField(
        value: _controller.phoneCodeRegister.value,
        decoration: const InputDecoration(
          labelText: 'Code',
          labelStyle: TextStyle(
            fontSize: 20,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        items: _controller.phoneCodes!.map((phoneCode) {
          return DropdownMenuItem(
            value: phoneCode.dialCode,
            child: Text(
              phoneCode.dialCode!,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          _controller.phoneCodeRegister.value = value!.toString();
        },
      ),
    );
  }

  Widget registerPhoneField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(top: 5),
      child: TextFormField(
        controller: _controller.clientPhone.value,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          labelText: 'Phone Number',
          labelStyle: TextStyle(
            fontSize: 20,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the password';
          }
          return null;
        },
      ),
    );
  }

  Widget registerPostalCodeField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: _controller.clientZipCode.value,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          labelText: 'Postal Code',
          labelStyle: TextStyle(
            fontSize: 20,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the postal code';
          }
          return null;
        },
      ),
    );
  }

  Widget registerButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.12),
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 40)),
          backgroundColor: MaterialStateProperty.all(Colors.indigo[900]),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        ),
        child: const Text(
          'Save',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        onPressed: () {
          if (_controller.formKey.currentState!.validate()) {
            _controller.updateProfile();
          }
        },
      ),
    );
  }

  Widget optForm() {
    final TextEditingController otpController = TextEditingController();
    final FocusNode otpFocusNode = FocusNode();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          const Text(
            'Please enter the OTP sent to your email',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          // texto que indicque que el codigo de verificacion expira en 15 minutos  y un boton que diga reenviar codigo

          const Text(
            'The verification code expires in 15 minutes',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          PinCodeTextField(
            controller: otpController,
            focusNode: otpFocusNode,
            length: 6,
            onChanged: (value) {
              // Aquí puedes hacer algo cuando el usuario cambie el valor del campo OTP
            },
            onCompleted: (value) {
              // valido el codigo de verificacion y lo paso a la otra pantalla

              _controller.verifyOtp(value);
            },
            appContext: Get.context!,
            autoDisposeControllers: false,
            keyboardType: TextInputType.number,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              inactiveFillColor: Colors.transparent,
              activeFillColor: Colors.transparent,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
              selectedColor: Colors.blue,
              selectedFillColor: Colors.transparent,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          const Text(
            'If you have not received the code, you can request it again',
            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
          ),

          const SizedBox(
            height: 10,
          ),

          // CONTAINER CON EL BOTON DE REENVIAR CODIGO

          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 40)),
              backgroundColor: MaterialStateProperty.all(Colors.indigo[900]),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
            ),
            child: const Text(
              'Resend Code',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            onPressed: () {
              _controller.requestResetPassword();
            },
          ),
        ],
      ),
    );
  }

  Widget requestOtpForm() {
    // reorna un container con un escrito que dice que debe verificar su correo antes de continuar  y un voton que muestre el formulario de otp

    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          const Text(
            'Please verify your email before continuing',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
// otro texto que diga que se mandara un correo con un codigo de verificacion

          const SizedBox(
            height: 10,
          ),

          const Text(
            'We will send you a verification code to your email',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 40)),
              backgroundColor: MaterialStateProperty.all(Colors.indigo[900]),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
            ),
            child: const Text(
              'Verify',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            onPressed: () {
              _controller.requestResetPassword();
            },
          ),
        ],
      ),
    );
  }

  Widget changePasswordForm() {
    // ejecuto la funcion para obtener los paises getAllPhoneCodes() que est'a en el controlador

    return Form(
      key: _controller.formKeyPaswword,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: SizedBox(
                    width: Get.width *
                        0.8, // O puedes usar otro valor específico para el ancho
                    child: registerPasswordField(),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  child: registerConfirmPasswordField(),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: Get.width * 0.8,
                  child: savePasswordButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget savePasswordButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.12),
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 40)),
          backgroundColor: MaterialStateProperty.all(Colors.indigo[900]),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        ),
        child: const Text(
          'Save',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        onPressed: () {
          if (_controller.formKeyPaswword.currentState!.validate()) {
            _controller.updatePassword();
          }
        },
      ),
    );
  }

  Widget formSkills() {
    return Container(
      alignment: Alignment.center,
      width: Get.width * 0.8,
      height: Get.height * 0.6,
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              child: ListView(
                children: _controller.skills
                    .map(
                      (e) => ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: Checkbox(
                          value: _controller.skillsList.contains(e['id']),
                          shape: const CircleBorder(),
                          onChanged: (a) {
                            if (a!) {
                              _controller.skillsList.add(e["id"]);
                            } else {
                              _controller.skillsList
                                  .removeWhere((element) => element == e["id"]);
                            }
                          },
                          activeColor: Colors.indigo[800],
                          checkColor: Colors.indigo[800],
                        ),
                        title: Text(e["attributes"]["name"],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(color: Colors.grey[400]),
                            textAlign: TextAlign.left),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (_controller.skillsList.isNotEmpty) {
                final respuesta = await _controller.saveSkills();

                if (respuesta) {
                  Get.snackbar(
                    'Success!',
                    'Skills updated',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );

                  // demora de 1 segundo para que se vea el snackbar
                } else {
                  Get.snackbar(
                    'Error!',
                    'Not possible update skills',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              } else {
                Get.snackbar(
                  'Information!',
                  "Pease select one o more skills",
                  backgroundColor: Colors.yellow,
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 35),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(0xffD06605),
                borderRadius: BorderRadius.circular(90),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget formVehicles() {
    return Container(
      alignment: Alignment.center,
      width: Get.width * 0.9,
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              _controller.moto.value = !_controller.moto.value;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: _controller.moto.value
                    ? Colors.white
                    : const Color(0xffB8B0E9),
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
              width: Get.width * 1,
              height: 85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bicycle/Scooter/Motorcycle',
                    style: TextStyle(
                      color: _controller.moto.value
                          ? const Color(0xffD06605)
                          : const Color(0xff170591),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'For transporting small or single items',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              _controller.truck.value = !_controller.truck.value;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: _controller.truck.value
                    ? Colors.white
                    : const Color(0xffB8B0E9),
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
              width: Get.width * 1,
              height: 85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pickup Truck',
                    style: TextStyle(
                      color: _controller.truck.value
                          ? const Color(0xffD06605)
                          : const Color(0xff170591),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'For hauling large-sized items',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              _controller.car.value = !_controller.car.value;
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: _controller.car.value
                    ? Colors.white
                    : const Color(0xffB8B0E9),
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
              width: Get.width * 1,
              height: 85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Car',
                    style: TextStyle(
                      color: _controller.car.value
                          ? const Color(0xffD06605)
                          : const Color(0xff170591),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'For transporting medium-sized items',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              ProgressDialog pd = ProgressDialog(context: Get.context);
              pd.show(
                max: 100,
                msg: 'Please wait...',
                progressBgColor: Colors.transparent,
              );

              final respuesta = await _controller.saveVehicles();

              pd.close();

              if (respuesta) {
                Get.snackbar(
                  'Success!',
                  'Vehicles updated',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  // lo usbo un poco
                  margin: const EdgeInsets.only(bottom: 20),
                );

                // demora de 1 segundo para que se vea el snackbar
              } else {
                Get.snackbar(
                  'Error!',
                  'Not updated vehicles',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.only(bottom: 20),
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 35),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(0xffD06605),
                borderRadius: BorderRadius.circular(90),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget formAboutMe() {
    return Container(
      alignment: Alignment.center,
      width: Get.width * 0.9,
      // margin: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'About me',
            style: TextStyle(
              color: Color(0xff170591),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Why are you a provider?',
            style: TextStyle(color: Color(0xff868686), fontSize: 13),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xffB8B0E9),
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
            width: Get.width * 6,
            height: 60,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tell us more about yourself, why you decided to join this great community',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff170591),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // container con input de texto para escribir sobre mi

          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
            width: Get.width * 9,
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller.aboutMeController.value,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write here...',
                    hintStyle: TextStyle(
                      color: Color(0xff170591),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),

          InkWell(
            onTap: () async {
              ProgressDialog pd = ProgressDialog(context: Get.context);
              pd.show(
                max: 100,
                msg: 'Please wait...',
                progressBgColor: Colors.transparent,
              );

              final respuesta = await _controller.saveAboutMe();

              pd.close();

              if (respuesta) {
                Get.snackbar(
                  'Success!',
                  'About me updated',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  // lo usbo un poco
                  margin: const EdgeInsets.only(bottom: 20),
                );

                // demora de 1 segundo para que se vea el snackbar
              } else {
                Get.snackbar(
                  'Error!',
                  'Not updated about me',
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.only(bottom: 20),
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 35),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
              decoration: BoxDecoration(
                color: const Color(0xffD06605),
                borderRadius: BorderRadius.circular(90),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
