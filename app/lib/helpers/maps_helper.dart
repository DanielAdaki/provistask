import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

bool getDistanceBetweenPoints( { required LatLng latng1, required LatLng latng2, required double limite }) {

    final theta = latng1.longitude - latng2.longitude;

    final distance = 60 * 1.1515 * (180/ math.pi ) * math.acos(
        math.sin(latng1.latitude * (math.pi/180)) * math.sin(latng2.latitude * (math.pi/180)) + 
        math.cos(latng1.latitude * (math.pi/180)) * math.cos(latng2.latitude * (math.pi/180)) * math.cos(theta * (math.pi/180))
    );
    return distance * 1.609344 <= limite;
}


Future<BitmapDescriptor> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    final markerIcon = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(markerIcon);
  }
