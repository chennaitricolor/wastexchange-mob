import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapScreen> {
  GoogleMapController _mapController;
  MapType _type = MapType.normal;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    super.initState();
    addMarker();
  }

  @override
  void dispose() {
    super.dispose();
  }

  static final _options = CameraPosition(
    target: LatLng(12.9838, 80.2459),
    zoom: 15,
  );

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: GoogleMap(
          initialCameraPosition: _options,
          onMapCreated: onMapCreated,
          mapType: _type,
          myLocationEnabled: true,
          markers: Set<Marker>.of(markers.values),
    ),
    );
  }

  void addMarker() {
    final Marker marker = Marker(
      markerId: MarkerId("1"),
      position: LatLng(12.9838, 80.2459),
      infoWindow: InfoWindow(title: "ThoughtWorks Technologies India Pvt Ltd", snippet: 'Taramani'),
      onTap: () {
        _onMarkerTapped(MarkerId("1"));
      },
    );
    setState(() {
      markers[MarkerId("1")] = marker;
    });
  }

  void _onMarkerTapped(MarkerId markerId) {
    print("Marker $markerId Tapped!");
  }
}
