import 'package:appbuilder/App/CustomWidgets/CustomWidgets.dart';
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
            builder: (context, AsyncSnapshot<List<MapPoint>> mapPoints) {

              if (mapPoints.hasError) {
                print('Error while loading Map: ${mapPoints.error} ${mapPoints.connectionState}');
                print(mapPoints.error.toString());
                return InkWell(
                  onTap: () => setState(() {}),
                  child: Padding(
                    padding: EdgeInsets.all(ad.vBigSpace),
                    child: Center(
                      child: Text("Fehler. Tippen um zu wiederholen.", textAlign: TextAlign.center),
                    ),
                  ),
                );
              }

              switch (mapPoints.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Text('Verbindungsfehler. Bitte versuchen Sie es erneut.'),
                  );
                case ConnectionState.waiting:
                  return CustomWidgets().getViewLoader(ac, 'Map wird geladen...', ad);
                case ConnectionState.active:
                  return GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      widget._controller.gmc = controller;
                    },
                    markers: getMarkers(mapPoints.data),
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(target: widget._controller.getUserLocation(), zoom: 5.7),
                  );
                  break;
                case ConnectionState.done:
                  return ListView(
                    children: mapPoints.data.map((point) => Text(point.name)).toList(),
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
