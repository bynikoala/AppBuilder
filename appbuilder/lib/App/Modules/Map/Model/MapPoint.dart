import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPoint {
  final String name;
  final String type;
  final String snippet;
  final String description;
  final LatLng position;
  final String id;

  MapPoint(this.snippet, this.description, this.name, this.type, this.id, this.position);

  MapPoint.fromStream(this.id, Map<String, dynamic> doc)
      : name = doc['name'],
        type = doc['type'],
        snippet = doc['snippet'],
        description = doc['description'],
        position = LatLng(doc['location'].latitude, doc['location'].longitude);
}
