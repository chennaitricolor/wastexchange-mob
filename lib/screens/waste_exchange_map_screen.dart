import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class WasteExchangeMapScreen extends StatefulWidget {
  @override
  _WasteExchangeMapState createState() => _WasteExchangeMapState();
}

class _WasteExchangeMapState extends State<WasteExchangeMapScreen> {
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

  ///Callback when map created
  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps demo'),
      ),
      body: GoogleMap(
          initialCameraPosition: _options,
          onMapCreated: onMapCreated,
          mapType: _type,
          myLocationEnabled: true,
          markers: Set<Marker>.of(markers.values),
    ),
    );
  }

  ///Drop marker at the Ahmadabad
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
