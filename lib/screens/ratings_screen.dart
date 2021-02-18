import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studr/models/hairdresser.dart';
import 'package:studr/widgets/divider.dart';

class RatingsScreen extends StatelessWidget {
  RatingsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Bewertungen",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
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
                    "Tobias Fraunberger",
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
                  Icons.star_border,
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
                Icon(
                  Icons.star_border,
                  size: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "13.01.2021",
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
                    "Der Schnitt gefällt mir leider nicht sehr gut, und ich musste sehr lange warten.",
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
                    "Tobias Brückler",
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
                  Icons.star,
                  size: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "20.01.2021",
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
                    "Ich bin sehr überzeugt von diesem Friseur, das Personal ist hervoragend.",
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
                    "Baran Sen",
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
                  Icons.star_border,
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
                  "01.01.2021",
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
                    "Die erbrachte Leistung war ernüchternd!",
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
                    "Yunus Öztirak",
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
                  Icons.star_border,
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
                  "11.01.2021",
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
                    "Mittelmässiger Haarschnitt. Lange Wartezeiten. Jedoch freundliches Personal.",
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
                    "Vedad Helac",
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
                  "09.01.2021",
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
                    "Alles perfekt. Wenn da nicht die viel zu langen Wartezeiten wären.",
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
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
