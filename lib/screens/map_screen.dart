import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/commons/constants.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapScreen> {
  GoogleMapController _mapController;
  MapType _type = MapType.normal;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Set<Polyline> polylines = { Polyline(width: 5, color: Colors.green, polylineId: PolylineId("1"), points: [Constants.LAT_LNG_THOUGHTWORKS, Constants.LAT_LNG_AIRPORT, Constants.LAT_LNG_CENTRAL]) };

  @override
  void initState() {
    super.initState();
    initMarker();
  }

  @override
  void dispose() {
    super.dispose();
  }

  static final _options = CameraPosition(
    target: Constants.LAT_LNG_AIRPORT,
    zoom: 12,
  );

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          polylines: polylines,
          initialCameraPosition: _options,
          onMapCreated: onMapCreated,
          mapType: _type,
          myLocationEnabled: true,
          markers: Set<Marker>.of(markers.values),
    ),
    );
  }

  void initMarker() {
    addMarker("1", "ThoughtWorks Technologies India Pvt Ltd", 'Taramani', Constants.LAT_LNG_THOUGHTWORKS);
    addMarker("2", "Kamaraj Domestic Terminal", 'Airport', Constants.LAT_LNG_AIRPORT);
    addMarker("3", "Chennai Central", 'Railway Station', Constants.LAT_LNG_CENTRAL);
  }

  void addMarker(String markerId, String title, String snippet, LatLng latLng) {
    markers[MarkerId(markerId)] = Marker(
      markerId: MarkerId(markerId),
      position: latLng,
      infoWindow: InfoWindow(
          title: title, snippet: snippet),
      onTap: () {
        _onMarkerTapped(MarkerId(markerId));
      },
    );
  }

  void _onMarkerTapped(MarkerId markerId) {
    print("Marker $markerId Tapped!");
  }
}
