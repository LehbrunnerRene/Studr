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
    Provider.of<Hairdressers>(context, listen: false).getInformation();
    Provider.of<Hairdressers>(context, listen: false).getPrices();
    Provider.of<Hairdressers>(context, listen: false).getRatings();
    Provider.of<Hairdressers>(context, listen: false).getHairdressers();

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
