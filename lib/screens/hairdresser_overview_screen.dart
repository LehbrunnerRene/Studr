import 'package:flutter/material.dart';
import 'package:studr/widgets/categoriesScroller.dart';

import '../main.dart';
import '../models/hairdresser.dart';
import 'detail_screen.dart';

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
      title: 'Barbershop',
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
  ];
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.cyan,
        //bottomNavigationBar: MyAppBar(),
        body: CategoriesScroller(this.loadedItems),
      ),
    );
  }
}
