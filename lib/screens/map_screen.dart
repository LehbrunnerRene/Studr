import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/cupertino.dart';



class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps',
      home: MapSample(),
    );
  }
}

LatLng point = LatLng(48.30587653268775, 14.28663119387035);

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
      var googleMap = GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  setState(() {
                    _markers.clear();
                    _setMarkers(LatLng(48.30602929070519, 14.28703947571657));
                    _setMarkers(LatLng(48.30439984828077, 14.291428505563399));
                    _setMarkers(LatLng(48.30443379552855, 14.283415974331396));
                  });       
                },
              );
            return new Scaffold(
              body: googleMap,
      );
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