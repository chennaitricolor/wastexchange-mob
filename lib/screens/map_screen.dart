import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wastexchange_mobile/resources/user_client.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/logger.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';
import 'package:wastexchange_mobile/models/user.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapScreen> {
  final logger = getLogger('MapScreen');
  final MapType _type = MapType.normal;
  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  static final _options = CameraPosition(
    target: const LatLng(Constants.CHENNAI_LAT, Constants.CHENNAI_LONG),
    zoom: Constants.DEFAULT_ZOOM,
  );

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void populateUsers(List<User> users) {
    final markers = users.map((user) => Marker(
          markerId: MarkerId(user.id.toString()),
          position: LatLng(user.lat, user.long),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              user.persona == Constants.USER_SELLER ? 200.0 : 0.0),
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
    logger.i('Markers Ready');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: FutureBuilder(
          future: UserClient().getAllUsers(),
          builder: (BuildContext context, AsyncSnapshot snapShot) {
            final isSuccess =
                snapShot.connectionState == ConnectionState.done &&
                    snapShot.hasData;
            if (!isSuccess) {
              return Center(child: const CircularProgressIndicator());
            }
            populateUsers(snapShot.data);
            logger.i('Initialize Google Map');
            return GoogleMap(
                initialCameraPosition: _options,
                onMapCreated: onMapCreated,
                mapType: _type,
                markers: Set<Marker>.of(markers.values));
          }),
    );
  }

  void _onMarkerTapped(MarkerId markerId) {
    logger.i('Marker $markerId Tapped!');
  }
}
