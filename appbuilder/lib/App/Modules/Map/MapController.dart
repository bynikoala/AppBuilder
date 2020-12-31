import 'dart:async';
import 'package:appbuilder/App/Modules/Map/MapView.dart';
import 'package:appbuilder/App/Settings/GlobalSettings.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'Model/MapPoint.dart';

class MapController {
  MapView _view;
  GoogleMapController gmc;
  Stream<List<MapPoint>> stream;
  StreamSubscription<LocationData> locationSub;
  Location location;
  LatLng _userLocation = LatLng(51.163361, 10.447683);
  bool followingMode = false;
  bool followButton = false;

  MapController() {
    initStream();
    _view = MapView(this);
  }

  Widget getView() => _view;

  LatLng getUserLocation() {
    return _userLocation;
}

  initStream() {
    stream = GlobalSettings.getStore().doc('map').collection('points').snapshots().map(
          (query) => query.docs.map((doc) => MapPoint.fromStream(doc.id, doc.data())).toList()
        );
  }

  initPosition() async {
    location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> toggleFollowmode() async {
    initPosition();
    followButton = !followButton;

    LocationData _locationData = await location.getLocation();

    _userLocation = LatLng(_locationData.latitude, _locationData.longitude);

    if (followingMode) {
      followingMode = false;
      locationSub.pause();
    } else {
      followingMode = true;
      locationSub = location.onLocationChanged.listen((LocationData ld) {
        gmc.animateCamera(CameraUpdate.newLatLngZoom(LatLng(ld.latitude, ld.longitude), 10));
        _userLocation = LatLng(_locationData.latitude, _locationData.longitude);
      });
    }
  }
}
