import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studr/models/hairdresser.dart';
import 'package:studr/providers/hairdressers.dart';
import 'package:studr/widgets/categoriesScroller.dart';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  @override
  void initState() {
    //Provider.of<Hairdressers>(context, listen: false).fetchAndSetHairdresser();
    //Provider.of<Hairdressers>(context, listen: false).getInformation();
    Provider.of<Hairdressers>(context, listen: false).getHairdressers();
    Provider.of<Hairdressers>(context, listen: false).getInfo();
    Provider.of<Hairdressers>(context, listen: false).getPric();
    Provider.of<Hairdressers>(context, listen: false).getRating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.cyan,
        //bottomNavigationBar: MyAppBar(),
        body: CategoriesScroller(),
      ),
    );
  }
}
