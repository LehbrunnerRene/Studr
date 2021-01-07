import 'package:flutter/material.dart';
import 'package:studr/widgets/appBar.dart';
import 'package:studr/widgets/categoriesScroller.dart';
import 'package:studr/widgets/topAppBar.dart';

import '../models/hairdresser.dart';
import 'detail_screen.dart';

import '../widgets/appBar.dart';
import '../widgets/hairdresserList.dart';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  int _currentTab = 0;
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.cyan.shade50,
        bottomNavigationBar: MyAppBar(),
        body: Container(
          child: Column(
            children: [
              AnimatedOpacity(
                duration: const Duration(microseconds: 200),
                opacity: 1,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.topCenter,
                  child: CategoriesScroller(loadedItems),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: HairdresserList(loadedItems),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
