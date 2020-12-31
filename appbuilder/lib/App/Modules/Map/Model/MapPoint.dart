import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPoint {
  String name;
  String type;
  String snippet;
  String description;
  LatLng position;
  String id;

  MapPoint(this.snippet, this.description, this.name, this.type, this.id, this.position);

  MapPoint.fromStream(this.id, Map<String, dynamic> doc) {
    print("beebop");
    name = doc['name'];
    type = doc['type'];
    snippet = doc['snippet'];
    description = doc['description'];
    position = LatLng(doc['location'].latitude, doc['location'].longitude);
  }
}
