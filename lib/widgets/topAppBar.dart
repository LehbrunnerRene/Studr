import 'package:flutter/material.dart';
import 'package:studr/models/hairdresser.dart';
import 'package:studr/widgets/hairdresserList.dart';

import 'categoriesScroller.dart';

class TopAppBar extends StatelessWidget {
  final List<Hairdresser> loadedItems = [
    Hairdresser(
      id: 1,
      title: 'Figarouno',
      description: 'Neues Styling, kreative Schnitte oder klassisch.',
      priceSection: '€',
      icon: 'figarouno2.png',
      salon: 'sturmayr-salon.png',
    ),
    Hairdresser(
      id: 2,
      title: 'Klipp',
      description: 'Neues Styling, kreative Schnitte oder klassisch',
      priceSection: '€€€',
      icon: 'Klipp.jpg',
      salon: 'sturmayr-salon.png',
    ),
    Hairdresser(
      id: 3,
      title: 'Sturmayr',
      description:
          'Entdecke die Welt der Sturmayr Coiffeure und die ästhetische Schönheit, geschaffen durch einzigartig kreative Stylings.',
      priceSection: '€€',
      icon: 'Sturmayr2.jpg',
      salon: 'sturmayr-salon.png',
    ),
    Hairdresser(
      id: 4,
      title: 'Red Level',
      description: 'Neues Styling, kreative Schnitte oder klassisch.',
      priceSection: '€€',
      icon: 'RedLevel1.png',
      salon: 'sturmayr-salon.png',
    ),
    Hairdresser(
      id: 5,
      title: 'Schnittzone',
      description: 'Neues Styling, kreative Schnitte oder klassisch.',
      priceSection: '€',
      icon: 'Schnittzone.jpg',
      salon: 'sturmayr-salon.png',
    ),
    Hairdresser(
      id: 6,
      title: 'Fessler Barbershop',
      description: 'Neues Styling, kreative Schnitte oder klassisch.',
      priceSection: '€',
      icon: 'fessler_barbershop.png',
      salon: 'sturmayr-salon.png',
    ),
    Hairdresser(
      id: 7,
      title: 'Stylepark',
      description: 'Neues Styling, kreative Schnitte oder klassisch.',
      priceSection: '€',
      icon: 'Stylepark.png',
      salon: 'sturmayr-salon.png',
    ),
    Hairdresser(
      id: 8,
      title: 'Simple Barber Shop',
      description: 'Neues Styling, kreative Schnitte oder klassisch.',
      priceSection: '€',
      icon: 'Simple_barber-shop.png',
      salon: 'sturmayr-salon.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade100,
        child: Column(children: [
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
          SizedBox(height: 100,),
          AnimatedOpacity(
            duration: const Duration(microseconds: 200),
            opacity: 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: CategoriesScroller(loadedItems),
            ),
          ),
          Text(
            "sdfgdfgthdfgtgdhdhdthdhg",
            style: TextStyle(fontSize: 30),
          ),
        ]),
      ),
    );
  }
}
