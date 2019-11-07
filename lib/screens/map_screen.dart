import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wastexchange_mobile/blocs/map_bloc.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/ui_state.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
import 'package:wastexchange_mobile/widgets/selleritems/seller_item_bottom_sheet.dart';
import 'package:wastexchange_mobile/widgets/views/drawer_view.dart';
import 'package:wastexchange_mobile/widgets/views/error_view.dart';
import 'package:wastexchange_mobile/widgets/views/loading_progress_indicator.dart';
import 'package:wastexchange_mobile/widgets/views/menu_app_bar.dart';

// TODO(Sayeed): Extract all map related logic to its own class
class MapScreen extends StatefulWidget {
  static const routeName = '/mapScreen';
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapScreen> {
  GoogleMapController _mapController;
  static const double _mapMCCHue = BitmapDescriptor.hueViolet;
  static const double _mapRRCHue = BitmapDescriptor.hueOrange;
  static const double _mapOtherHue = BitmapDescriptor.hueRose;

  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  String _errorMessage = Constants.GENERIC_ERROR_MESSAGE;

  final SellerItemBottomSheet _bottomSheet =
      SellerItemBottomSheet(seller: null);
  static const double _bottomSheetMinHeight = 120.0;

  static final _initialCameraPosition = CameraPosition(
    target: const LatLng(Constants.CHENNAI_LAT, Constants.CHENNAI_LONG),
  );

  static final _animateCameraTo = CameraUpdate.newLatLngZoom(
      const LatLng(Constants.CHENNAI_LAT, Constants.CHENNAI_LONG),
      Constants.DEFAULT_MAP_ZOOM);

  UIState _uiState = UIState.loading;
  MapBloc _bloc;

  @override
  void initState() {
    _bloc = MapBloc();
    _bloc.allUsersStream.listen((_snapshot) {
      switch (_snapshot.status) {
        case Status.loading:
          setState(() {
            _uiState = UIState.loading;
          });
          break;
        case Status.error:
          setState(() {
            _uiState = UIState.error;
            _errorMessage = _snapshot.message;
          });
          break;
        case Status.completed:
          setState(() {
            _uiState = UIState.completed;
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
    _mapController = controller;
    _mapController.animateCamera(_animateCameraTo);
  }

  void _onMarkerTapped(int userId) {
    _bottomSheet.setUser(_bloc.getUser(userId));
  }

  // TODO(Sayeed): Should we move markers logic to its own class
  void _setMarkers(List<User> users) {
    final markers = users.map((user) {
      final hue = _markerHue(user);
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
        ),
        onTap: callback,
      );
    });
    _markers = Map.fromIterable(markers,
        key: (marker) => marker.markerId, value: (marker) => marker);
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
        body: _widgetForUIState(),
      ),
    );
  }

// TODO(Sayeed): Is it bad that we have created a new method for getting widgets instead of having it in build()
  Widget _widgetForUIState() {
    switch (_uiState) {
      case UIState.loading:
        return FractionallySizedBox(
            heightFactor:
                (_screenHeight() - _bottomSheetMinHeight) / _screenHeight(),
            alignment: Alignment.topCenter,
            child: const LoadingProgressIndicator());
      case UIState.completed:
        return GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: onMapCreated,
            mapType: MapType.normal,
            markers: Set<Marker>.of(_markers.values));
      default:
        return ErrorView(message: _errorMessage);
    }
  }

  double _screenHeight() => MediaQuery.of(context).size.height;
}
