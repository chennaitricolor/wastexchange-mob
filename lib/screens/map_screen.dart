import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/util/user_client.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';
import 'package:wastexchange_mobile/models/user.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapScreen> {
  GoogleMapController mapController;
  MapType _type = MapType.normal;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    super.initState();
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
    this.mapController = controller;
  }

  populateUsers(List<User> users) {
    var markers = users.map((user) => Marker(
          markerId: MarkerId(user.id.toString()),
          position: LatLng(user.lat, user.long),
          infoWindow: InfoWindow(
            title: '${user.name}',
            snippet: '${user.address}',
          ),
          onTap: () {
            _onMarkerTapped(MarkerId(user.id.toString()));
          },
        ));
    this.markers = Map.fromIterable(markers,
        key: (marker) => marker.markerId, value: (marker) => marker);
    debugPrint('Markers Ready');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: FutureBuilder(
          future: UserClient.getAllUsers(),
          builder: (BuildContext context, AsyncSnapshot snapShot) {
            bool isSuccess = snapShot.connectionState == ConnectionState.done &&
                snapShot.hasData;
            if (!isSuccess) {
              return Center(child: CircularProgressIndicator());
            }
            populateUsers(snapShot.data);
            debugPrint('Initialize Google Map');
            return GoogleMap(
              initialCameraPosition: _options,
              onMapCreated: onMapCreated,
              mapType: _type,
              markers: Set<Marker>.of(markers.values),
            );
          }),
    );
  }

  void _onMarkerTapped(MarkerId markerId) {
    print("Marker $markerId Tapped!");
  }
}
