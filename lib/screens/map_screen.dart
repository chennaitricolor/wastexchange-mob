import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wastexchange_mobile/blocs/map_bloc.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_bottom_sheet.dart';
import 'package:wastexchange_mobile/widgets/views/drawer_view.dart';
import 'package:wastexchange_mobile/widgets/views/loading_progress_indicator.dart';
import 'package:wastexchange_mobile/widgets/views/menu_app_bar.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/mapScreen';
  @override
  _MapState createState() => _MapState();
}

enum _MapStatus { LOADING, ERROR, COMPLETED }

class _MapState extends State<MapScreen> {
  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MapBloc _bloc;
  _MapStatus _mapStatus = _MapStatus.LOADING;
  final SellerItemBottomSheet _bottomSheet =
      SellerItemBottomSheet(seller: null);

  static const double _bottomSheetMinHeight = 120.0;
  static const double _mapPinHue = 200.0;
  double _screenHeight() => MediaQuery.of(context).size.height;

  static final _initialCameraPosition = CameraPosition(
    target: const LatLng(Constants.CHENNAI_LAT, Constants.CHENNAI_LONG),
  );

  static final _animateCameraTo = CameraUpdate.newLatLngZoom(
      const LatLng(Constants.CHENNAI_LAT, Constants.CHENNAI_LONG),
      Constants.DEFAULT_MAP_ZOOM);

  @override
  void initState() {
    _bloc = MapBloc();
    _bloc.allUsersStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.LOADING:
          setState(() {
            _mapStatus = _MapStatus.LOADING;
          });
          break;
        case Status.ERROR:
          setState(() {
            _mapStatus = _MapStatus.ERROR;
          });
          break;
        case Status.COMPLETED:
          setState(() {
            _mapStatus = _MapStatus.COMPLETED;
            _setMarkers(_snapshot.data);
          });
          break;
      }
    });
    _bloc.getAllUsers();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    controller.animateCamera(_animateCameraTo);
  }

  void _onMarkerTapped(int userId) {
    _bottomSheet.setUser(_bloc.getUser(userId));
  }

  // TODO(Sayeed): Should we move markers logic to its own class
  void _setMarkers(List<User> users) {
    final markers = users.map((user) {
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
          _mapPinHue,
        ),
        infoWindow: InfoWindow(
          title: '${user.name}',
        ),
        onTap: callback,
      );
    });
    this.markers = Map.fromIterable(markers,
        key: (marker) => marker.markerId, value: (marker) => marker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerView(),
      ),
      appBar: MenuAppBar(),
      body: SlidingUpPanel(
        minHeight: _bottomSheetMinHeight,
        maxHeight: _screenHeight() * 0.6,
        backdropEnabled: true,
        backdropOpacity: 0.4,
        backdropColor: Colors.black,
        panel: _bottomSheet,
        body: _widgetForMapStatus(),
      ),
    );
  }

// TODO(Sayeed): Is it bad that we have created a new method for getting widgets instead of having it in build()
  Widget _widgetForMapStatus() {
    switch(_mapStatus){
      case _MapStatus.LOADING: 
        return FractionallySizedBox(
            heightFactor:
                (_screenHeight() - _bottomSheetMinHeight) / _screenHeight(),
            alignment: Alignment.topCenter,
            child: const LoadingProgressIndicator());
      case _MapStatus.COMPLETED:
        return GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: onMapCreated,
          mapType: MapType.normal,
          markers: Set<Marker>.of(markers.values));
      default: 
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            Constants.MAP_LOADING_FAILED,
            style: AppTheme.body1,
            textAlign: TextAlign.center,
          ));
    }
  }
}
