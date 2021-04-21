import 'dart:async';
import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:studr/models/hairdresser.dart';
import 'package:studr/providers/hairdressers.dart';
import 'package:studr/screens/map_saloon.dart';
import 'package:studr/screens/map_screen.dart';
import 'package:studr/screens/ratings_screen.dart';
import 'package:studr/screens/search_screen.dart';
import 'package:studr/widgets/divider.dart';
import 'map_saloon.dart';

import '../main.dart';

LatLng point = LatLng(48.26865011002132, 14.251855200210889);

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
      onTap: (LatLng latLng) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MapScreenSaloon()));
      },
      initialCameraPosition: _kGooglePlex,
      markers: _markers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        setState(() {
          _markers.clear();
          _setMarkers(point);
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

class DetailScreen extends StatelessWidget {
  final Hairdresser selectedItem;

  DetailScreen(this.selectedItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 262,
              width: double.infinity,
              child: Image(
                width: double.infinity,
                image: AssetImage('assets/salons/${selectedItem.salon}'),
              ),
            ),
            Container(
              height: 5,
              color: Colors.black,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 195,
                  child: Text(
                    selectedItem.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  selectedItem.priceSection,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  width: 35,
                ),
                ButtonTheme(
                  minWidth: 0,
                  child: RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color: Colors.black)),
                    padding: const EdgeInsets.all(16.0),
                    onPressed: () {},
                    color: Colors.blue.shade800,
                    textColor: Colors.white,
                    child: Icon(
                      Icons.calendar_today_outlined,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: 220,
                  child: Text(
                    selectedItem.description,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                    ),
                  ),
                ),
                Icon(
                  Icons.location_on_outlined,
                  size: 40,
                ),
                Text(
                  "10 km",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(
                left: 15.0,
              ),
              child: Text(
                "Friseurinformationen",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.phone,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "+43 676 842803815",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            DividerPadding(),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.email,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "info@figarouno.at",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            DividerPadding(),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.lock_clock,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Jetzt Geöffnet",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 65,
                ),
                Text(
                  "8:00 - 18:00",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            DividerPadding(),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.location_on_outlined,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Nelkenweg 2, 4062 Thening",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
                height: 150,
                width: 350,
                child: FlatButton(
                    padding: EdgeInsets.all(0.0), child: MapSample())),
            SizedBox(
              height: 35,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(
                left: 15.0,
              ),
              child: Column(
                children: [
                  Text(
                    "Preise",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(
                left: 20.0,
              ),
              child: Column(
                children: [
                  Text(
                    "Männer",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            DividerPadding(),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 23,
                ),
                Container(
                  width: 280,
                  child: Text(
                    "Schnitt ohne Waschen",
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Text(
                  "20€",
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 23,
                ),
                Container(
                  width: 280,
                  child: Text(
                    "Schnitt mit Waschen",
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Text(
                  "25€",
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(
                left: 20.0,
              ),
              child: Column(
                children: [
                  Text(
                    "Frauen",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            DividerPadding(),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 23,
                ),
                Container(
                  width: 280,
                  child: Text(
                    "Langhaar Schnitt",
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Text(
                  "40€",
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 23,
                ),
                Container(
                  width: 280,
                  child: Text(
                    "Kurzhaar Schnitt",
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Text(
                  "30€",
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 23,
                ),
                Container(
                  width: 280,
                  child: Text(
                    "Färben",
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Text(
                  "70€",
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(
                left: 15.0,
              ),
              child: Column(
                children: [
                  Text(
                    "Bewertungen",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Text(
                  "3,0 / 5,0",
                  style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                Icon(
                  Icons.star,
                  size: 35,
                ),
                Icon(
                  Icons.star,
                  size: 35,
                ),
                Icon(
                  Icons.star,
                  size: 35,
                ),
                Icon(
                  Icons.star_border,
                  size: 35,
                ),
                Icon(
                  Icons.star_border,
                  size: 35,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            DividerPadding(),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(
                left: 25.0,
              ),
              child: Column(
                children: [
                  Text(
                    "Paul Pils",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Icon(
                  Icons.star,
                  size: 25,
                ),
                Icon(
                  Icons.star,
                  size: 25,
                ),
                Icon(
                  Icons.star,
                  size: 25,
                ),
                Icon(
                  Icons.star,
                  size: 25,
                ),
                Icon(
                  Icons.star_border,
                  size: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "16.01.2021",
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Container(
                  width: 300,
                  child: Text(
                    "Mein absoluter Liebliengsfriseur, gehe gerne dort hin. Top Beratung und sehr nettes Personal!",
                    style: TextStyle(
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
            DividerPadding(),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(
                left: 25.0,
              ),
              child: Column(
                children: [
                  Text(
                    "Rene Lehbrunner",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Icon(
                  Icons.star,
                  size: 25,
                ),
                Icon(
                  Icons.star,
                  size: 25,
                ),
                Icon(
                  Icons.star,
                  size: 25,
                ),
                Icon(
                  Icons.star_border,
                  size: 25,
                ),
                Icon(
                  Icons.star_border,
                  size: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "10.01.2021",
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Container(
                  width: 300,
                  child: Text(
                    "Der Schnitt gefällt mir sehr gut, jedoch musste ich etwas lange warten.",
                    style: TextStyle(
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            DividerPadding(),
            FlatButton(
              visualDensity: VisualDensity(
                vertical: -4,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RatingsScreen()));
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    "Mehr Bewertungen anzeigen",
                    style: TextStyle(
                      fontSize: 15.5,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 18,
                  ),
                ],
              ),
            ),
            DividerPadding(),
            FlatButton(
              visualDensity: VisualDensity(
                vertical: -4,
              ),
              onPressed: null,
              child: Row(
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    "+",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Bewertung schreiben",
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
