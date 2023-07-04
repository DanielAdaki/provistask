import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/pages/locations/UI/locations_controller.dart';
import 'package:provitask_app/pages/locations/UI/locations_widgets.dart';

class LocationsPage extends GetView<LocationsController> {
  final _widgets = LocationsWidgets();

  LocationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _widgets.locationsAppBar(),
        bottomNavigationBar: const ProvitaskBottomBar(),
        body: const SafeArea(child: Text('LocationsController')));
  }
}
