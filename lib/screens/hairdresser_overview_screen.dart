import 'package:flutter/material.dart';

import '../models/hairdresser.dart';
import 'detail_screen.dart';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  final List<Hairdresser> loadedItems = [
    Hairdresser(
      id: 1,
      title: 'Figarouno',
      description: 'Neues Styling, kreative Schnitte oder klassisch.',
      priceSection: '€',
      icon: 'figarouno2.png',
    ),
    Hairdresser(
      id: 2,
      title: 'Klipp',
      description: 'Neues Styling, kreative Schnitte oder klassisch',
      priceSection: '€€€',
      icon: 'Klipp.jpg',
    ),
    Hairdresser(
      id: 3,
      title: 'Sturmayr',
      description: 'Neues Styling, kreative Schnitte oder klassisch.',
      priceSection: '€€',
      icon: 'Sturmayr2.jpg',
    ),
    Hairdresser(
      id: 4,
      title: 'Red Level',
      description: 'Neues Styling, kreative Schnitte oder klassisch.',
      priceSection: '€€',
      icon: 'RedLevel1.png',
    ),
    Hairdresser(
      id: 5,
      title: 'Schnittzone',
      description: 'Neues Styling, kreative Schnitte oder klassisch.',
      priceSection: '€',
      icon: 'Schnittzone.jpg',
    ),
    Hairdresser(
      id: 6,
      title: 'Fessler Barbershop',
      description: 'Neues Styling, kreative Schnitte oder klassisch.',
      priceSection: '€',
      icon: 'fessler_barbershop.png',
    ),
    Hairdresser(
      id: 7,
      title: 'Stylepark',
      description: 'Neues Styling, kreative Schnitte oder klassisch.',
      priceSection: '€',
      icon: 'Stylepark.png',
    ),
    Hairdresser(
      id: 8,
      title: 'Simple Barber Shop',
      description: 'Neues Styling, kreative Schnitte oder klassisch.',
      priceSection: '€',
      icon: 'Simple_barber-shop.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home_outlined),
              color: Colors.grey,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search_outlined),
              color: Colors.grey,
              onPressed: () {},
            ),
            FloatingActionButton(
              backgroundColor: Colors.cyan.shade800,
              elevation: 7,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.location_on_outlined),
              color: Colors.grey,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person_outline),
              color: Colors.grey,
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: loadedItems.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            color: Colors.white,
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(loadedItems[index])));
              },
              title: Text(
                loadedItems[index].title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                children: [
                  Text(
                    loadedItems[index].description,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        loadedItems[index].priceSection,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                            height: 1.5),
                      ),
                      Text(
                        'Haarstudio',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        'Geöffnet',
                        style: TextStyle(color: Colors.green),
                      )
                    ],
                  ),
                ],
              ),
              contentPadding: EdgeInsets.all(20.0),
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage:
                    AssetImage('assets/icons/${loadedItems[index].icon}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
