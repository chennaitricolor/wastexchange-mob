import 'package:google_maps_flutter/google_maps_flutter.dart';

class AggregatedPoints {
  AggregatedPoints(this.location, this.count) {
    bitmabAssetName = getBitmapDescriptor();
  }

  AggregatedPoints.fromMap(
    Map<String, dynamic> map)
      : count = map['n_marker'],
        location = LatLng(map['lat'], map['long']) {
      bitmabAssetName = getBitmapDescriptor();
  }
  final LatLng location;
  final int count;
  String bitmabAssetName; 

  String getBitmapDescriptor() {
    String bitmapDescriptor;
    if (count < 10) {
      // + 2
      bitmapDescriptor = 'assets/images/m1.png';
    } else if (count < 25) {
      // + 10
      bitmapDescriptor = 'assets/images/m2.png';
    } else if (count < 50) {
      // + 25
      bitmapDescriptor = 'assets/images/m3.png';
    } else if (count < 100) {
      // + 50
      bitmapDescriptor = 'assets/images/m4.png';
    } else if (count < 500) {
      // + 100
      bitmapDescriptor = 'assets/images/m5.png';
    } else if (count < 1000) {
      // +500
      bitmapDescriptor = 'assets/images/m6.png';
    } else {
      // + 1k
      bitmapDescriptor = 'assets/images/m7.png';
    }
    return bitmapDescriptor;
  }

  String getId() {
    return location.latitude.toString() +
        '_' +
        location.longitude.toString() +
        '_$count';
  }
}
