import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studr/providers/hairdressers.dart';
import 'package:studr/widgets/categoriesScroller.dart';

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  @override
  void initState() {
    Provider.of<Hairdressers>(context, listen: false).fetchAndSetHairdresser();
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
