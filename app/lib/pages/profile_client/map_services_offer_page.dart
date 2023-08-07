import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/controllers/user/profile_controller.dart';
import 'package:provitask_app/pages/profile_client/UI/profile_client_widgets.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:provitask_app/controllers/location/location_controller.dart';

class MapServices extends GetView<ProfileController> {
  final _widgets = ProfileClientWidgets();

  final _controllerLocation = Get.put(LocationController());

  MapServices({Key? key}) : super(key: key);

  // ejecuto el metodo getSkills para obtener los skills del usuario

  @override
  Widget build(BuildContext context) {
    if (controller.lat.value != 90.0 && controller.lng.value != 180.0) {
      _controllerLocation.updateSelectedLocation(
          LatLng(controller.lat.value, controller.lng.value));
      _controllerLocation.getAddressFromLatLng();
    }

    return Obx(
      // saco la latitud y la longitud

      () => Scaffold(
        // paso elñ titulo edit perfil
        appBar: _widgets.profileAppBar(),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        drawer: _widgets.homeDrawer(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Service location',
                    style: TextStyle(
                      color: Color(0xff170591),
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Select the location where you will offer your services.',
                    style: TextStyle(color: Color(0xff868686), fontSize: 13),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: Get.width * 0.9,
                    // margin: const EdgeInsets.only(top: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          width: Get.width * 0.9,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDD7813),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Location',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(top: 10),
                                child: Row(
                                  children: [
                                    _controllerLocation.selectedAddress == ""
                                        ? const Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.white,
                                            size: 18,
                                          )
                                        : const Icon(
                                            Icons.location_on,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                          border: _controllerLocation
                                                      .selectedAddress ==
                                                  ""
                                              ? Border.all(
                                                  color: Colors.white, width: 1)
                                              : Border.all(
                                                  color:
                                                      const Color(0xFFDD7813),
                                                  width: 1),
                                        ),
                                        child: Obx(() => Text(
                                              _controllerLocation
                                                          .selectedAddress ==
                                                      ""
                                                  ? 'Select your location'
                                                  : _controllerLocation
                                                      .selectedAddress,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        late final LatLng? initialLocation;
                                        if (controller.lat.value == 90.0 &&
                                            controller.lng.value == 180.0) {
                                          initialLocation = _controllerLocation
                                              .initialCameraPosition;
                                        } else {
                                          initialLocation = LatLng(
                                              controller.lat.value,
                                              controller.lng.value);
                                        }

                                        LocationResult result =
                                            await Navigator.of(Get.context!)
                                                .push(
                                          MaterialPageRoute(
                                            builder: (context) => PlacePicker(
                                              "AIzaSyBbluXRjZ7O3n3A6n5Wi01ePbDm9pXMCH4",
                                              defaultLocation: initialLocation,
                                            ),
                                          ),
                                        );

                                        _controllerLocation
                                            .updateSelectedLocation(
                                                result.latLng!);

                                        _controllerLocation
                                            .getAddressFromLatLng();
                                      },
                                      // si no hay seleccionada una direccion, el icono es un add  si no es un edit

                                      icon:
                                          _controllerLocation.selectedAddress ==
                                                  ""
                                              ? const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 18,
                                                )
                                              : const Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                    ),
                                  ],
                                ),
                              ),
                              if (_controllerLocation.selectedAddress !=
                                  "") ...[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Good news! Now you can appear in searches.',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                )
                              ] else ...[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'If you do not configure your work location, it could not appear in the list of service providers.',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                )
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Working hours',
                    style: TextStyle(
                      color: Color(0xff170591),
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Select the range of hours of availability',
                    style: TextStyle(color: Color(0xff868686), fontSize: 13),
                  ),

                  // container con par de botones para seleccionar hora de inicio y fin

                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: Get.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.width * 0.9,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDD7813),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Start time :',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              // container con un selector que contiene horas que van desde las 8 am hasta las 8 pm
                              Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 26, vertical: 5),
                                      width: Get.width * 0.6,
                                      child: Align(
                                        alignment: Alignment
                                            .centerLeft, // Alineación a la izquierda del DropdownButtonFormField
                                        child: DropdownButtonFormField(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                width: 2.0,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                width: 2,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Color.fromARGB(
                                                255, 255, 255, 255),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 15,
                                            ),
                                          ),
                                          dropdownColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          value: controller.open_hour.value,
                                          items: controller.disponibilityHour
                                              .map(
                                                (hour) => DropdownMenuItem(
                                                  value: hour,
                                                  child: Text(
                                                    hour,
                                                    style: const TextStyle(
                                                      color: Color(0xFF3828a8),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (value) {
                                            controller.open_hour.value =
                                                value.toString();
                                          },
                                        ),
                                      )
                                      // Agrega un Container vacío si _controller.disponibility está vacío
                                      ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: Get.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.width * 0.9,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDD7813),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Close time :',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              // container con un selector que contiene horas que van desde las 8 am hasta las 8 pm
                              Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 26, vertical: 5),
                                      width: Get.width * 0.6,
                                      child: Align(
                                        alignment: Alignment
                                            .centerLeft, // Alineación a la izquierda del DropdownButtonFormField
                                        child: DropdownButtonFormField(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                width: 2.0,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                width: 2,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Color.fromARGB(
                                                255, 255, 255, 255),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 15,
                                            ),
                                          ),
                                          dropdownColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          value: controller.close_hour.value,
                                          items: controller.disponibilityHour
                                              .map(
                                                (hour) => DropdownMenuItem(
                                                  value: hour,
                                                  child: Text(
                                                    hour,
                                                    style: const TextStyle(
                                                      color: Color(0xFF3828a8),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (value) {
                                            // verifico que
                                            controller.close_hour.value =
                                                value.toString();
                                          },
                                        ),
                                      )
                                      // Agrega un Container vacío si _controller.disponibility está vacío
                                      ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  InkWell(
                    onTap: () async {
                      ProgressDialog pd = ProgressDialog(context: Get.context);
                      pd.show(
                          max: 100,
                          msg: 'Please wait...',
                          progressBgColor: Colors.transparent,
                          closeWithDelay: 50,
                          barrierDismissible: true);

                      final respuesta = await controller.saveUbicationServices(
                          _controllerLocation.selectedLocation);

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
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 15),
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
            ),
          ),
        ),
      ),
    );
  }

  Widget mapContainer() {
    final LatLng? initialLocation = _controllerLocation.initialCameraPosition;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: Get.width * 1,
      height: Get.height * 0.4,
      child: GetBuilder<LocationController>(
        builder: (controller) => GoogleMap(
          mapType: MapType.normal,
          markers: _controllerLocation.markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          initialCameraPosition: CameraPosition(
            target: initialLocation != null
                ? LatLng(initialLocation.latitude, initialLocation.longitude)
                : const LatLng(37.42796133580664,
                    -122.085749655962), // Usa la ubicación actual o una ubicación predeterminada si no se ha obtenido la ubicación actual
            zoom: 16.0,
          ),
          onTap: (LatLng location) {
            //controller.updateSelectedLocation(location);

            _controllerLocation.updateSelectedLocation(location, true);
            _controllerLocation.markers.clear();

            // Añadir un nuevo marcador en la ubicación seleccionada
            _controllerLocation.markers.add(
              Marker(
                markerId: const MarkerId('selectedLocation'),
                position: location,
                draggable: true,
                onDragEnd: (LatLng newPosition) {
                  // Manejar el evento de arrastrar el marcador
                  _controllerLocation.updateSelectedLocation(newPosition);
                },
              ),
            );

            // Actualizar el estado del controlador para que el marcador aparezca en el mapa
            _controllerLocation.update();
          },
        ),
      ),
    );
  }
}
