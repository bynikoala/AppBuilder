import 'package:appbuilder/App/Modules/Map/Model/MapPoint.dart';
import 'package:flutter/widgets.dart';

class Map with ChangeNotifier {
  List<MapPoint> points;

  Map({List<MapPoint> points}) : points = points ?? new List<MapPoint>();

  List<MapPoint> getPoints() => points;

  importPoints(List<MapPoint> points) {
    this.points = points;
  }

  addPoint(MapPoint point) {
    points.add(point);
  }

  removePoint(MapPoint point) {
    points.remove(point);
  }
}
