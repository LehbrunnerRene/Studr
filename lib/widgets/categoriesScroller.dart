import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:studr/providers/hairdressers.dart';
import 'package:studr/screens/detail_screen.dart';

class CategoriesScroller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hairdresserData = Provider.of<Hairdressers>(context);
    final loadedHairdresser = hairdresserData.hairdressers;
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 45;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 1.7,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                        0.2,
                        1,
                      ],
                      colors: [Colors.purple, Colors.blue],
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Hi Tobias!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 20.0, top: 15.0),
              child: Text(
                "In deiner Nähe:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: loadedHairdresser.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(loadedHairdresser[index])));
                    },
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 8),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          alignment: Alignment.topCenter,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 150,
                                margin: EdgeInsets.only(right: 5),
                                height: categoryHeight,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        spreadRadius: 0.5,
                                        blurRadius: 5,
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/icons/${loadedHairdresser[index]["icon"]}',
                                        fit: BoxFit.cover,
                                        width: 85,
                                        height: 75,
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 3,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          loadedHairdresser[index]["title"],
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            loadedHairdresser[index]
                                                ["priceSection"],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            'Geöffnet',
                                            style: TextStyle(
                                                color: Colors.green.shade800),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
                height: 200,
                width: 390,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    child: MapSample())),
          ],
        ),
      ),
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
      mapToolbarEnabled: false,
      zoomGesturesEnabled: false,
      rotateGesturesEnabled: false,
      zoomControlsEnabled: false,
      scrollGesturesEnabled: false,
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

  void _setMarkers(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      print(
          'Marker | Latitude: ${point.latitude} Longitude: ${point.longitude}');
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }
}
