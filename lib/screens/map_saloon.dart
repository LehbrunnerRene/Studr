import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:studr/providers/hairdressers.dart';

LatLng point = LatLng(48.26865011002132, 14.251855200210889);

class MapScreenSaloon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final information = Provider.of<Hairdressers>(context).information;
    //var lat = information.elementAt(this.selectedItem["id"] - 1).lat.toString();
    //var lng = information.elementAt(this.selectedItem["id"] - 1).lng.toString();
    return MaterialApp(
      title: 'Flutter Google Maps',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: point,
    zoom: 14.4746,
  );

  static final CameraPosition _kSaloon = CameraPosition(
      bearing: 192.8334901395799,
      target: point,
      tilt: 59.440717697143555,
      zoom: 18.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,

        initialCameraPosition: _kGooglePlex,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          setState(() {
            _markers.clear();
            _setMarkers(point);
          });       
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToSaloon,
        label: Text('Zum Friseur'),
        icon: Icon(Icons.map),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop
    );
  }

  Future<void> _goToSaloon() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kSaloon));
  }

  int _markerIdCounter = 1;
  Set<Marker> _markers = HashSet<Marker>();

  void _setMarkers(LatLng point){
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState((){
      print('Marker | Latitude: ${point.latitude} Longitude: ${point.longitude}');
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }

}