import 'dart:async';
import 'dart:collection';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:studr/models/hairdresser.dart';
import 'package:studr/providers/hairdressers.dart';
import 'package:studr/screens/map_saloon.dart';
import 'package:studr/screens/rating_add_screen.dart';
import 'package:studr/screens/ratings_screen.dart';
import 'package:studr/screens/scheduler_screen.dart';
import 'package:studr/widgets/divider.dart';
import 'map_saloon.dart';

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

class DetailScreen extends StatefulWidget {
  final dynamic selectedItem;

  DetailScreen(this.selectedItem);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final hairdressers = Provider.of<Hairdressers>(context).hairdressers;
    final information = Provider.of<Hairdressers>(context).information;
    final prices = Provider.of<Hairdressers>(context).prices;
    final ratings = Provider.of<Hairdressers>(context).ratings;

    /*Map address =
        information.elementAt(widget.selectedItem["id"] - 1)["address"];*/
    final malePrice = prices.elementAt(1)["Male"];
    final femalePrice =
        prices.elementAt(widget.selectedItem["id"] - 1)["Female"];
    List diffRating = [];
    for (var element in ratings) {
      if (element["ratingId"] == widget.selectedItem["id"]) {
        diffRating.add(element);
      }
    }

    var text = Text(
      "Bewertung schreiben",
      style: TextStyle(
        fontSize: 15.5,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade800,
      ),
    );
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
                image:
                    AssetImage('assets/salons/${widget.selectedItem["salon"]}'),
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
                  width: 200,
                  child: Text(
                    hairdressers
                        .elementAt(widget.selectedItem["id"] - 1)["title"],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  information != null
                      ? information
                          .elementAt(widget.selectedItem["id"] - 1)
                          .priceSegment
                      : "",
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SchedulerScreen(widget.selectedItem)));
                    },
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
                    widget.selectedItem["description"],
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
                  information
                      .elementAt(widget.selectedItem["id"] - 1)
                      .phoneNumber,
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
                  information.elementAt(widget.selectedItem["id"] - 1).email,
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
                  information
                      .elementAt(widget.selectedItem["id"] - 1)
                      .openingTimes,
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
                  information
                          .elementAt(widget.selectedItem["id"] - 1)
                          .postalCode +
                      " " +
                      information
                          .elementAt(widget.selectedItem["id"] - 1)
                          .city +
                      ", " +
                      information
                          .elementAt(widget.selectedItem["id"] - 1)
                          .street,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
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
            ListView.builder(
              itemCount: malePrice != null ? malePrice.length : 0,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              padding: EdgeInsets.all(0),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 23,
                      ),
                      Container(
                        width: 280,
                        child: Text(
                          malePrice[index]["name"],
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Text(
                        malePrice[index]["price"].toString() + "€",
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                );
              },
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
            ListView.builder(
              itemCount: femalePrice.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              padding: EdgeInsets.all(0),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 23,
                      ),
                      Container(
                        width: 280,
                        child: Text(
                          femalePrice != null ? femalePrice[index]["name"] : "",
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Text(
                        femalePrice[index]["price"].toString() + "€",
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                );
              },
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
                  information
                          .elementAt(widget.selectedItem["id"] - 1)
                          .rating
                          .toString()
                          .replaceAll('.', ',') +
                      " / 5,0",
                  style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                RatingBarIndicator(
                  itemCount: 5,
                  rating: information
                      .elementAt(widget.selectedItem["id"] - 1)
                      .rating
                      .toDouble(),
                  direction: Axis.horizontal,
                  itemSize: 40,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            DividerPadding(),
            ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              padding: EdgeInsets.all(0),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(
                        left: 25.0,
                      ),
                      child: Column(
                        children: [
                          Text(
                            diffRating.isEmpty ? "" : diffRating[index]["name"],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 22,
                        ),
                        RatingBarIndicator(
                          itemCount: 5,
                          rating: diffRating.isEmpty
                              ? 0
                              : diffRating[index]["rating"].toDouble(),
                          direction: Axis.horizontal,
                          itemSize: 30,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.black,
                          ),
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
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Container(
                          width: 300,
                          child: Text(
                            diffRating.isEmpty
                                ? ""
                                : diffRating[index]["comment"],
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
                      height: 5,
                    ),
                    DividerPadding(),
                  ],
                );
              },
            ),
            FlatButton(
              visualDensity: VisualDensity(
                vertical: -4,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RatingsScreen(widget.selectedItem)));
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddRating(this.widget.selectedItem)));
                    },
                    child: text,
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
