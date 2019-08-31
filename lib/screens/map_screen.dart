import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/user_client.dart';
import 'package:wastexchange_mobile/screens/seller_item_bottom_sheet.dart';
import 'package:wastexchange_mobile/utils/app_logger.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/views/home_app_bar.dart';
import 'package:wastexchange_mobile/widgets/views/loading_progress_indicator.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/mapScreen';
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapScreen> {
  final logger = AppLogger.get('MapScreen');
  final MapType _type = MapType.normal;
  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  User _selectedUser;
  List<User> _users;
  final _panelController = PanelController();
  StreamController<User> sellerStreamController;

  static final _options = CameraPosition(
    target: const LatLng(Constants.CHENNAI_LAT, Constants.CHENNAI_LONG),
    zoom: Constants.DEFAULT_ZOOM,
  );

  @override
  void initState() {
    sellerStreamController = StreamController();
    super.initState();
  }

  @override
  void dispose() {
    sellerStreamController.close();
    super.dispose();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMarkerTapped(int userId) {
    logger.i('Marker $userId Tapped!');
    _selectedUser = _getUser(userId);
    sellerStreamController.sink.add(_selectedUser);
  }

  User _getUser(int id) {
    return _users.firstWhere((user) => user.id == id);
  }

  void populateUsers(List<User> users) {
    _users = users;
    final markers = users.map((user) {
      final isSeller = user.persona == Constants.USER_SELLER;
      final hue = isSeller ? 200.0 : 0.0;
      void callback() => _onMarkerTapped(user.id);
      return Marker(
        markerId: MarkerId(
          user.id.toString(),
        ),
        position: LatLng(
          user.lat,
          user.long,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          hue,
        ),
        infoWindow: InfoWindow(
          title: '${user.name}',
          snippet: '${user.address}',
        ),
        onTap: callback,
      );
    });
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
        panel: StreamBuilder(
          stream: sellerStreamController.stream,
          builder: (context, snapshot) {
            return SellerItemBottomSheet(_selectedUser);
          },
        ),
        body: FutureBuilder(
            future: UserClient().getAllUsers(),
            builder: (BuildContext context, AsyncSnapshot snapShot) {
              final isSuccess =
                  snapShot.connectionState == ConnectionState.done &&
                      snapShot.hasData;
              if (!isSuccess) {
                return Center(
                  child: const LoadingProgressIndicator(),
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
}
