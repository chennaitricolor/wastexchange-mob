import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:clustering_google_maps/clustering_google_maps.dart' show AggregationSetup;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wastexchange_mobile/blocs/map_bloc.dart';
import 'package:wastexchange_mobile/models/result.dart';
import 'package:wastexchange_mobile/models/user.dart';
import 'package:wastexchange_mobile/resources/clustering_helper.dart';
import 'package:wastexchange_mobile/screens/seller_item_bottom_sheet.dart';
import 'package:wastexchange_mobile/utils/app_theme.dart';
import 'package:wastexchange_mobile/utils/constants.dart';
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
 ClusteringHelper clusteringHelper;
  Set<Marker> clusterMarkers;
  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MapBloc _bloc;
  _MapStatus _mapStatus = _MapStatus.LOADING;
  final SellerItemBottomSheet _bottomSheet =
      SellerItemBottomSheet(seller: null);

  static const double _bottomSheetMinHeight = 120.0;
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
            initMemoryClustering(_snapshot.data);
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

  Future onMapCreated(GoogleMapController mapController) async {
    clusteringHelper.mapController = mapController;
    clusteringHelper.updateMap();
    mapController.animateCamera(_animateCameraTo);
  }

  void onMarkerTapped(int userId) {
    _bottomSheet.setUser(_bloc.getUser(userId));
  }
  
  void updateMarkers(Set<Marker> markers) {
    setState(() {
      clusterMarkers = markers;
    });
  }

  void initMemoryClustering(List<User> userList) {
    clusteringHelper = ClusteringHelper.forMemory(
      list:_bloc.getUsersLocationList(),
      users: userList,
      updateMarkers: updateMarkers,
      onMarkerTapped: onMarkerTapped,
      aggregationSetup: AggregationSetup(markerSize: Constants.CLUSTER_MARKER_SIZE),
    );
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

  Widget _widgetForMapStatus() {
    if (_mapStatus == _MapStatus.LOADING) {
      return FractionallySizedBox(
          heightFactor:
              (_screenHeight() - _bottomSheetMinHeight) / _screenHeight(),
          alignment: Alignment.topCenter,
          child: const LoadingProgressIndicator());
    } else if (_mapStatus == _MapStatus.LOADING) {
      return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            Constants.MAP_LOADING_FAILED,
            style: AppTheme.body1,
            textAlign: TextAlign.center,
          ));
    } else {
      return 
        GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: onMapCreated,
          markers: clusterMarkers,
          onCameraMove: (newPosition) =>
              clusteringHelper.onCameraMove(newPosition, forceUpdate: true),
          onCameraIdle: clusteringHelper?.onMapIdle,
        );
    }
  }  
}
