import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:clustering_google_maps/clustering_google_maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/aggregated_points.dart';

class ClusteringHelper {

  ClusteringHelper.forMemory({
    @required this.list,
    @required this.users,
    @required this.updateMarkers,
    @required this.onMarkerTapped,
    this.maxZoomForAggregatePoints = 13.5,
    @required this.aggregationSetup,
    this.bitmapAssetPathForSingleMarker,
  })  : assert(list != null),
        assert(aggregationSetup != null);

  List<User> users;

  //After this value the map show the single points without aggregation
  final double maxZoomForAggregatePoints;

  //Database where we performed the queries
  Database database;

  //Name of table of the databasa SQLite where are stored the latitude, longitude and geoahash value
  String dbTable;

  //Name of column where is stored the latitude
  String dbLatColumn;

  //Name of column where is stored the longitude
  String dbLongColumn;

  //Name of column where is stored the geohash value
  String dbGeohashColumn;

  //Custom bitmap: string of assets position
  final String bitmapAssetPathForSingleMarker;

  //Custom bitmap: string of assets position
  final AggregationSetup aggregationSetup;

  //Where clause for query db
  String whereClause;

  GoogleMapController mapController;

  //Variable for save the last zoom
  double _currentZoom = 0.0;

  //Function called when the map must show single point without aggregation
  // if null the class use the default function
  Function showSinglePoint;

  //Function for update Markers on Google Map
  Function updateMarkers;

  Function onMarkerTapped;

  //List of points for memory clustering
  List<LatLngAndGeohash> list;

  static const double _mapMCCHue = BitmapDescriptor.hueViolet;
  static const double _mapRRCHue = BitmapDescriptor.hueOrange;
  static const double _mapOtherHue = BitmapDescriptor.hueRose;

  //Call during the editing of CameraPosition
  //If you want updateMap during the zoom in/out set forceUpdate to true
  //this is NOT RECCOMENDED
  void onCameraMove(CameraPosition position, {forceUpdate = false}) {
    _currentZoom = position.zoom;
    if (forceUpdate) {
      updateMap();
    }
  }

  //Call when user stop to move or zoom the map
  Future<void> onMapIdle() async {
    updateMap();
  }

  void updateMap() {
    if (_currentZoom < maxZoomForAggregatePoints) {
      updateAggregatedPoints(zoom: _currentZoom);
    } else {
      if (showSinglePoint != null) {
        showSinglePoint();
      } else {
        updatePoints(_currentZoom);
      }
    }
  }

  // Used for update list
  // NOT RECCOMENDED for good performance (SQL IS BETTER)
  void updateData(List<LatLngAndGeohash> newList, List<User> users) {
    list = newList;
    this.users = users;
    updateMap();
  }

  Future<List<AggregatedPoints>> getAggregatedPoints(double zoom) async {
    int level = 5;

    if (zoom <= aggregationSetup.maxZoomLimits[0]) {
      level = 1;
    } else if (zoom < aggregationSetup.maxZoomLimits[1]) {
      level = 2;
    } else if (zoom < aggregationSetup.maxZoomLimits[2]) {
      level = 3;
    } else if (zoom < aggregationSetup.maxZoomLimits[3]) {
      level = 4;
    } else if (zoom < aggregationSetup.maxZoomLimits[4]) {
      level = 5;
    } else if (zoom < aggregationSetup.maxZoomLimits[5]) {
      level = 6;
    } else if (zoom < aggregationSetup.maxZoomLimits[6]) {
      level = 7;
    }

    try {
      List<AggregatedPoints> aggregatedPoints;
      final latLngBounds = await mapController.getVisibleRegion();
      final listBounds = list.where((p) {
          final double leftTopLatitude = latLngBounds.northeast.latitude;
          final double leftTopLongitude = latLngBounds.southwest.longitude;
          final double rightBottomLatitude = latLngBounds.southwest.latitude;
          final double rightBottomLongitude = latLngBounds.northeast.longitude;

          final bool latQuery = (leftTopLatitude > rightBottomLatitude)
              ? p.location.latitude <= leftTopLatitude &&
                  p.location.latitude >= rightBottomLatitude
              : p.location.latitude <= leftTopLatitude ||
                  p.location.latitude >= rightBottomLatitude;

          final bool longQuery = (leftTopLongitude < rightBottomLongitude)
              ? p.location.longitude >= leftTopLongitude &&
                  p.location.longitude <= rightBottomLongitude
              : p.location.longitude >= leftTopLongitude ||
                  p.location.longitude <= rightBottomLongitude;
          return latQuery && longQuery;
        }).toList();

        aggregatedPoints = _retrieveAggregatedPoints(listBounds, List(), level);
      return aggregatedPoints;
    } catch (e) {
      return List<AggregatedPoints>();
    }
  }

  final List<AggregatedPoints> aggList = [];

  List<AggregatedPoints> _retrieveAggregatedPoints(
      List<LatLngAndGeohash> inputList,
      List<AggregatedPoints> resultList,
      int level) {

    if (inputList.isEmpty) {
      return resultList;
    }
    final List<LatLngAndGeohash> newInputList = List.from(inputList);
    List<LatLngAndGeohash> tmp;
    final t = newInputList[0].geohash.substring(0, level);
    tmp =
        newInputList.where((p) => p.geohash.substring(0, level) == t).toList();
    newInputList.removeWhere((p) => p.geohash.substring(0, level) == t);
    double latitude = 0;
    double longitude = 0;
    tmp.forEach((l) {
      latitude += l.location.latitude;
      longitude += l.location.longitude;
    });
    final count = tmp.length;
    final a =
        AggregatedPoints(LatLng(latitude / count, longitude / count), count);
    resultList.add(a);
    return _retrieveAggregatedPoints(newInputList, resultList, level);
  }

  Future<void> updateAggregatedPoints({double zoom = 0.0}) async {
    final List<AggregatedPoints> aggregation = await getAggregatedPoints(zoom);
    final Set<Marker> markers = {};

    for (var i = 0; i < aggregation.length; i++) {
      final a = aggregation[i];

      BitmapDescriptor bitmapDescriptor;

      final Uint8List markerIcon =
          await getBytesFromCanvas(a.count.toString(), getColor(a.count));
      bitmapDescriptor = BitmapDescriptor.fromBytes(markerIcon);
      final InfoWindow infoWindow = InfoWindow(title: a.count.toString()+ ' sellers in this area');
      final MarkerId markerId = MarkerId(a.getId());

      final Marker marker = Marker(
        markerId: markerId,
        position: a.location,
        infoWindow: infoWindow,
        icon: bitmapDescriptor,
      );
      markers.add(marker);
    }
    updateMarkers(markers);
  }

  void updatePoints(double zoom) {
    try {
      final Set<Marker> markers = users.map((user) {
        return createMarker(user);
      }).toSet();
      updateMarkers(markers);
    } catch (ex) {
        throw Exception('Unknown error occured while creating Google Map Markers with user data');
    }
  }

  Marker createMarker(User user) {
    if(user != null){
      final hue = _markerHue(user);
      final MarkerId markerId = MarkerId(user.id.toString());
      void callback() => onMarkerTapped(user.id);
      return Marker(
        markerId: markerId,
        position: LatLng(
        user.lat,
        user.long,
      ),
        infoWindow: InfoWindow(
          title: '${user.name}',
          snippet: '${user.address}',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          hue,
        ), 
        onTap: callback,
      );
    }
    return null;
  }
  double _markerHue(User user) {
    final lowerCaseName = user.name.toLowerCase();
    if (lowerCaseName.contains(' mcc')) {
      return _mapMCCHue;
    } else if (lowerCaseName.contains(' rrc')) {
      return _mapRRCHue;
    } else {
      return _mapOtherHue;
    }
  }

  Future<Uint8List> getBytesFromCanvas(String text, MaterialColor color) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = color[400];
    final Paint paint2 = Paint()..color = color[300];
    final Paint paint3 = Paint()..color = color[100];
    final int size = aggregationSetup.markerSize;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint3);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.4, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 3.3, paint1);
    final TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    painter.text = TextSpan(
      text: text,
      style: TextStyle(
          fontSize: size / 6, color: Colors.black, fontWeight: FontWeight.bold),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
    );

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }

  MaterialColor getColor(int count) {
    if (count < aggregationSetup.maxAggregationItems[0]) {
      // + 2
      return aggregationSetup.colors[0];
    } else if (count < aggregationSetup.maxAggregationItems[1]) {
      // + 10
      return aggregationSetup.colors[1];
    } else if (count < aggregationSetup.maxAggregationItems[2]) {
      // + 25
      return aggregationSetup.colors[2];
    } else if (count < aggregationSetup.maxAggregationItems[3]) {
      // + 50
      return aggregationSetup.colors[3];
    } else if (count < aggregationSetup.maxAggregationItems[4]) {
      // + 100
      return aggregationSetup.colors[4];
    } else if (count < aggregationSetup.maxAggregationItems[5]) {
      // +500
      return aggregationSetup.colors[5];
    } else {
      // + 1k
      return aggregationSetup.colors[6];
    }
  }
}