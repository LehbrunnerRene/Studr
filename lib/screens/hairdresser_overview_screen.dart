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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.cyan.shade50,
        bottomNavigationBar: MyAppBar(),
        body: Container(
          child: TopAppBar(),
        ),
      ),
    );
  }
}
