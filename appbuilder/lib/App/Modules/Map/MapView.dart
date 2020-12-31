import 'package:appbuilder/App/Design/AppColors.dart';
import 'package:appbuilder/App/Design/AppDimensions.dart';
import 'package:appbuilder/App/Modules/Map/MapController.dart';
import 'package:appbuilder/App/Modules/Map/Model/MapPoint.dart';
import 'package:appbuilder/App/Settings/GlobalSettings.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final MapController _controller;

  MapView(this._controller);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  AppColors ac = GlobalSettings.ac;
  AppDimensions ad = GlobalSettings.ad;
  Map<String, BitmapDescriptor> icons = Map();
  bool ready = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: widget._controller.followButton ? null : Colors.black38,
        child: Icon(Icons.location_history),
        onPressed: () {
          setState(() {
            widget._controller.toggleFollowmode();
          });
        },
      ),
      body: Container(
        child: StreamBuilder(
            stream: widget._controller.stream,
            builder: (context, AsyncSnapshot<List<MapPoint>> asyncSnapshot) {
              if (asyncSnapshot.hasError) {
                print(asyncSnapshot.error.toString());
                return Center(
                  child: Text(
                    'Fehler. Bitte versuchen Sie es erneut.',
                  ),
                );
              }
              switch (asyncSnapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Text('Verbindungsfehler. Bitte versuchen Sie es erneut.'),
                  );
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        ad.vSmall(),
                        Text('Lade Kartenansicht...'),
                      ],
                    ),
                  );
                case ConnectionState.active:
                  return GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      widget._controller.gmc = controller;
                    },
                    markers: getMarkers(asyncSnapshot.data),
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(target: widget._controller.getUserLocation(), zoom: 5.7),
                  );
                  break;
                case ConnectionState.done:
                  return ListView(
                    children: asyncSnapshot.data.map((point) => Text(point.name)).toList(),
                  );
              }
              return null;
            }),
      ),
    );
  }

  Set<Marker> getMarkers(List<MapPoint> points) {
    Set<Marker> markers = Set<Marker>();
    points.forEach((point) {
      markers.add(
        Marker(
          //  icon: ready ? icons[point.data()['ccat']] ?? icons['Other'] : null,
          infoWindow: InfoWindow(
            title: point.name,
            snippet: point.snippet,
          //  onTap: () => {},
          ),
          markerId: MarkerId(point.id),
          position: point.position,
          onTap: () => {widget._controller.gmc.animateCamera(CameraUpdate.newLatLngZoom(point.position, 15))},
        ),
      );
    });
    if (markers.length == 0) {}
    return markers;
  }
}
