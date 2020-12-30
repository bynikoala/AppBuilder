import 'package:appbuilder/App/Modules/Map/MapView.dart';

class MapController {
  MapView _view;

  MapController() {
    _view = MapView(this);
  }

  getView() => _view;
}