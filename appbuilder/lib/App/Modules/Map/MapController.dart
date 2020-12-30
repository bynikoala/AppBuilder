import 'package:appbuilder/App/Modules/Map/MapView.dart';
import 'package:flutter/material.dart';

class MapController {
  MapView _view;

  MapController() {
    _view = MapView(this);
  }

  Widget getView() => _view;
}