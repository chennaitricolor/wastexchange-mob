import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wastexchange_mobile/resources/user_client.dart';
import 'package:wastexchange_mobile/screens/seller_inventory_detail_screen.dart';
import 'package:wastexchange_mobile/util/constants.dart';
import 'package:wastexchange_mobile/util/logger.dart';
import 'package:wastexchange_mobile/widgets/home_app_bar.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/widgets/loading_progress_indicator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapScreen> {
  final logger = getLogger('MapScreen');
  final MapType _type = MapType.normal;
  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  User _selectedUser;
  List<User> _users;
  final _panelController = PanelController();

  static final _options = CameraPosition(
    target: const LatLng(Constants.CHENNAI_LAT, Constants.CHENNAI_LONG),
    zoom: Constants.DEFAULT_ZOOM,
  );

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void populateUsers(List<User> users) {
    _users = users;
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
      body: SlidingUpPanel(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
        controller: _panelController,
        backdropEnabled: true,
        backdropOpacity: 0.4,
        backdropColor: Colors.black,
        panel: SellerInventoryDetailScreen(_selectedUser),
        body: FutureBuilder(
            future: UserClient().getAllUsers(),
            builder: (BuildContext context, AsyncSnapshot snapShot) {
              final isSuccess =
                  snapShot.connectionState == ConnectionState.done &&
                      snapShot.hasData;
              if (!isSuccess) {
                return Center(
                  child: LoadingProgressIndicator(),
                );
              }
              populateUsers(snapShot.data);
              logger.i('Initialize Google Map');
              return GoogleMap(
                  initialCameraPosition: _options,
                  onMapCreated: onMapCreated,
                  mapType: _type,
                  markers: Set<Marker>.of(markers.values));
            }),
      ),
    );
  }

  void _onMarkerTapped(MarkerId markerId) {
    logger.i('Marker $markerId Tapped!');
    setState(() {
      _selectedUser = _getUser(markerId.value);
    });
  }

  User _getUser(String stringIdentifier) {
    final id = int.parse(stringIdentifier);
    return _users.firstWhere((user) => user.id == id);
  }
}
