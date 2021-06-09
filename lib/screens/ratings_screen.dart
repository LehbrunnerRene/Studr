import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:studr/models/hairdresser.dart';
import 'package:studr/providers/hairdressers.dart';
import 'package:studr/widgets/divider.dart';

class RatingsScreen extends StatelessWidget {
  final dynamic selectedItem;

  RatingsScreen(this.selectedItem);

  @override
  Widget build(BuildContext context) {
    final information = Provider.of<Hairdressers>(context).information;
    final ratings = Provider.of<Hairdressers>(context).ratings;

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
                  information
                          .elementAt(this.selectedItem["id"] - 1)["rating"]
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
                      .elementAt(this.selectedItem["id"] - 1)["rating"]
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
              itemCount: ratings.length,
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
                            ratings[index]["name"],
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
                          rating: ratings[index]["rating"].toDouble(),
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
                            ratings[index]["comment"],
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
          ],
        ),
      ),
    );
  }
}
