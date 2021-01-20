import 'package:flutter/material.dart';
import 'package:studr/widgets/appBar.dart';
import 'package:studr/widgets/categoriesScroller.dart';

import '../models/hairdresser.dart';
import 'detail_screen.dart';

import '../widgets/appBar.dart';
import '../widgets/hairdresserList.dart';

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
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.cyan.shade50,
        bottomNavigationBar: MyAppBar(),
        body: CategoriesScroller(this.loadedItems),
      ),
    );
  }
}
