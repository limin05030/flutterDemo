import 'dart:async';

import 'package:flutter/material.dart';
import '../message/MemberDetailPage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../location/LocationManager.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  Completer<GoogleMapController> _mapCompleter = Completer();

  LatLng _currentLocation;

  Set<Marker> _markers = Set();

  Set<Marker> _getMarkers() {
    if (_markers.isNotEmpty) {
      _markers.clear();
    }

    if (_currentLocation != null) {
      final String markerMyId = 'marker_my_id';
      final Marker marker = Marker(
        markerId: MarkerId(markerMyId),
        position: _currentLocation,
        infoWindow: InfoWindow(title: markerMyId, snippet: '*'),
        onTap: () {
        },
      );
      _markers.add(marker);
    }

    return _markers;
  }

  LatLng _locationDataToLocationData(LocationData location) {
    if (location == null) {
      return LatLng(30.615638,104.068074);
    } else {
      return LatLng(location.latitude, location.longitude);
    }
  }

  @override
  void initState() {
    super.initState();
    _currentLocation = _locationDataToLocationData(null);
  }


  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // map layout
          GoogleMap(
            mapType: MapType.normal,
            rotateGesturesEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _locationDataToLocationData(null),
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapCompleter.complete(controller);
            },
            markers: _getMarkers(),
          ),

          // Controller layout
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                // MediaQuery.of(context).padding.top：状态栏高度
                // kToolbarHeight: appBar高度
                padding: EdgeInsets.fromLTRB(13.0, 31.0 + MediaQuery.of(context).padding.top, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MemberDetailPage()));
                      },
                      child: Image.asset("images/btn_main_team.png", width: 46, height: 46,),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0, 31 + MediaQuery.of(context).padding.top, 13, 31),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Image.asset("images/btn_main_map.png", width: 46, height: 46,),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Image.asset("images/btn_main_pin.png", width: 46, height: 46,),
                        ),
                        Image.asset("images/btn_main_fence.png", width: 46, height: 46,),
                      ],
                    ),

                   Column(
                     children: <Widget>[
                        Card(
                          elevation: 5.0,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),  //设置圆角
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  _zoom(true);
                                },
                                child: Image.asset("images/btn_main_zoom_add.png", width: 46, height: 46,),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                height: 1,
                                color: Colors.red,
                              ),
                              InkWell(
                                onTap: () {
                                  _zoom(false);
                                },
                                child: Image.asset("images/btn_main_zoom_less.png", width: 46, height: 46,),
                              ),
                            ],
                          ),
                        ),

                       InkWell(
                         onTap: () {
                           _getLocation();
                         },
                         child: Padding(
                           padding: EdgeInsets.fromLTRB(0, 9, 0, 0),
                           child: Image.asset("images/btn_main_position.png", width: 46, height: 46,),
                         ),
                       ),
                     ],
                   ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // https://github.com/flutter/plugins/blob/master/packages/google_maps_flutter/example
  Future<void> _zoom(bool zoomIn) async {
    final GoogleMapController controller = await _mapCompleter.future;
    if (zoomIn) {
      controller.animateCamera(CameraUpdate.zoomIn());
    } else {
      controller.animateCamera(CameraUpdate.zoomOut());
    }
  }

  void _getLocation() async {
    var location = await LocationManager.getLocation();
    if (location != null) {
      CameraPosition position = CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 18.0
      );

      final GoogleMapController controller = await _mapCompleter.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(position));

      setState(() {
        _currentLocation = LatLng(location.latitude, location.longitude);
      });
    }
  }
}
