import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationController extends GetxController {
  final Rx<LatLng?> _initialCameraPosition = Rx<LatLng?>(null);
  final Rx<LatLng?> currentLocartion = Rx<LatLng?>(null);
  LatLng? get initialCameraPosition => _initialCameraPosition.value;
  final RxBool _isError = RxBool(false);
  bool get isError => _isError.value;
  final RxString _address = RxString('');
  String get address => _address.value;
  final searchResults = <Map>[].obs;

  // declaro selectedLocation y selectedAddress como observables
  // Declaro selectedLocation y selectedAddress como observables
  final Rx<LatLng?> _selectedLocation = Rx<LatLng?>(null);
  LatLng? get selectedLocation => _selectedLocation.value;

  final _selectedAddress = "".obs;
  String get selectedAddress => _selectedAddress.value;

  TextEditingController textUbication = TextEditingController();

  TextEditingController inputTextUbication = TextEditingController();

  RxSet<Marker> markers = <Marker>{}.obs;

  // placemark selected y location selected

  final Rx<Placemark?> _selectedPlacemark = Rx<Placemark?>(null);

  Placemark? get selectedPlacemark => _selectedPlacemark.value;

  Future<void> getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();

      _initialCameraPosition.value =
          LatLng(position.latitude, position.longitude);

      currentLocartion.value = LatLng(position.latitude, position.longitude);

      // Obtener la dirección a partir de las coordenadas de latitud y longitud
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // imprimo la dirección

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String address = '';

        if (placemark.name != null && placemark.name!.isNotEmpty) {
          address += '${placemark.name!}, ';
        }

        if (placemark.thoroughfare != null &&
            placemark.thoroughfare!.isNotEmpty) {
          address += '${placemark.thoroughfare!}, ';
        }
        if (placemark.locality != null && placemark.locality!.isNotEmpty) {
          address += '${placemark.locality!}, ';
        }
        if (placemark.administrativeArea != null &&
            placemark.administrativeArea!.isNotEmpty) {
          address += '${placemark.administrativeArea!}, ';
        }
        if (placemark.country != null && placemark.country!.isNotEmpty) {
          address += placemark.country!;
        }
        _address.value = address;
      }
    } catch (e) {
      // Manejar errores al obtener la ubicación del usuario
      if (kDebugMode) {
        print('Error obteniendo ubicación: $e');
      }

      _isError.value = true;

      // verifico los permisos si fueron concedidos

      if (await Geolocator.isLocationServiceEnabled()) {
        // permisos concedidos
        if (await Geolocator.checkPermission() ==
            LocationPermission.deniedForever) {
          // permisos denegados para siempre
          if (kDebugMode) {
            print('Permisos denegados para siempre, no se puede solicitar');
          }

          // reenvio a la pantalla de configuración de la aplicación

          await Geolocator.openAppSettings();
        } else if (await Geolocator.checkPermission() ==
            LocationPermission.denied) {
          // permisos denegados
          if (kDebugMode) {
            print('Permisos denegados, solicitar permisos');
          }
          // espero que esté inicializado el controlador
          // reenvio a la pagina de  /gps-access
        } else {
          // permisos concedidos
          if (kDebugMode) {
            print('Permisos concedidos, solicitar ubicación');
          }
        }
      } else {
        // permisos denegados
        if (kDebugMode) {
          print('Permisos denegados, solicitar permisos');
        }

        // reenvio a la pagina de  /gps-access

        Get.toNamed('/gps-access');
      }
    }
  }

  Future<void> searchLocations(String searchText) async {
    try {
      if (searchText.isEmpty) {
        searchResults.clear();
        return;
      }

      // limpio la lista de resultados de búsqueda

      searchResults.clear();

      List<Location> locations = await locationFromAddress(searchText);

      // recorro la lista de ubicaciones y las convierto en Placemark usando el método placemarkFromCoordinates

      for (Location location in locations) {
        List<Placemark> placemarkList = await placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );

        // recorro la lista de Placemark y creo un mapa con los datos que necesito

        for (Placemark placemark in placemarkList) {
          Map<String, dynamic> result = {
            'name': placemark.name,
            'thoroughfare': placemark.thoroughfare,
            'subThoroughfare': placemark.subThoroughfare,
            'street': placemark.street,
            'locality': placemark.locality,
            'administrativeArea': placemark.administrativeArea,
            'country': placemark.country,
            'subAdministrativeArea': placemark.subAdministrativeArea,
            'postalCode': placemark.postalCode,
            'latitude': location.latitude,
            'longitude': location.longitude,
          };

          searchResults.add(result);
        }

        // update controller
      }
      //  update();
      /* _searchResults.value = placemarks
          .map((placemark) => Placemark(
              name: placemark.street,
              thoroughfare: placemark.street,
              locality: placemark.locality,
              administrativeArea: placemark.administrativeArea,
              country: placemark.country,
              postalCode: placemark.postalCode))
          .toList();*/

      if (searchResults.isNotEmpty) {
        // Imprimir los resultados de la búsqueda
        if (kDebugMode) {
          print('Resultados de la búsqueda: $searchResults');
        }
      }
    } catch (e) {
      // Manejar errores al realizar la búsqueda de ubicaciones
      if (kDebugMode) {
        print('Error al buscar ubicaciones: $e');
      }
      _isError.value = true;
    }
  }

  void handleLocationSelection(Placemark placemark) {
    // Manejar la selección de una ubicación en la lista de resultados
    String selectedAddress = '';
    if (placemark.name != null && placemark.name!.isNotEmpty) {
      selectedAddress += '${placemark.name!}, ';
    }
    if (placemark.thoroughfare != null && placemark.thoroughfare!.isNotEmpty) {
      selectedAddress += '${placemark.thoroughfare!}, ';
    }
    if (placemark.locality != null && placemark.locality!.isNotEmpty) {
      selectedAddress += '${placemark.locality!}, ';
    }
    if (placemark.administrativeArea != null &&
        placemark.administrativeArea!.isNotEmpty) {
      selectedAddress += '${placemark.administrativeArea!}, ';
    }
    if (placemark.country != null && placemark.country!.isNotEmpty) {
      selectedAddress += placemark.country!;
    }
    _address.value = selectedAddress;
  }

  // Definición de la variable selectedLocation

  // Definición del método updateSelectedLocation
  updateSelectedLocation(LatLng location, [bool buildMarket = false]) async {
    _selectedLocation.value = location;

    if (buildMarket) {
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('selected-location'),
          position: location,
        ),
      );

      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);

      // Obtener la primera dirección del resultado de geocoding

      Placemark placemark = placemarks.first;

      // actualizo la seleccion

      //placemark
      _selectedPlacemark.value = placemark;

      _selectedLocation.value = location;

      String address = '';

      if (placemark.name != null && placemark.name!.isNotEmpty) {
        address += '${placemark.name!}, ';
      }

      if (placemark.street != null && placemark.street!.isNotEmpty) {
        address += '${placemark.street!}, ';
      }

      if (placemark.subAdministrativeArea != null &&
          placemark.subAdministrativeArea!.isNotEmpty) {
        address += '${placemark.subAdministrativeArea!}, ';
      }

      if (placemark.locality != null && placemark.locality!.isNotEmpty) {
        address += '${placemark.locality!}, ';
      }

      if (placemark.administrativeArea != null &&
          placemark.administrativeArea!.isNotEmpty) {
        address += '${placemark.administrativeArea!}, ';
      }

      if (placemark.country != null && placemark.country!.isNotEmpty) {
        address += placemark.country!;
      }

      textUbication.text = address;

      _initialCameraPosition.value = location;
    }

    update();

    // Obtener la dirección a partir de las coordenadas de latitud y longitud
    //  getAddressFromLatLng();
  }

  void getAddressFromLatLng() async {
    try {
      if (selectedLocation != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            selectedLocation!.latitude, selectedLocation!.longitude);
        // Obtener la primera dirección del resultado de geocoding
        Placemark placemark = placemarks.first;
        // Obtener la dirección completa como un string
        _selectedAddress.value =
            '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
        // Actualizar el estado de la dirección en la clase
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error obteniendo la dirección: $e');
      }
    }
  }

  Future<void> buildmarket() async {
    // Agregar un marcador si se ha seleccionado una ubicación
    if (selectedLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: selectedLocation!,
          draggable: true,
          onDragEnd: (LatLng newPosition) {
            updateSelectedLocation(newPosition);
          },
        ),
      );

      update();
    } else {
      markers.add(
        Marker(
          markerId: const MarkerId('initialLocation'),
          position: initialCameraPosition != null
              ? LatLng(initialCameraPosition!.latitude,
                  initialCameraPosition!.longitude)
              : const LatLng(37.42796133580664,
                  -122.085749655962), // Usa la ubicación actual o una ubicación predeterminada si no se ha obtenido la ubicación actual
          draggable: true,
          onDragEnd: (LatLng newPosition) {
            // Manejar el evento de arrastrar el marcador
            // _controllerLocation.updateSelectedLocation(newPosition);
          },
        ),
      );
    }
  }
}
