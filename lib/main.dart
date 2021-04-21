import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studr/providers/hairdressers.dart';
import 'package:studr/screens/auth_screen.dart';
import 'package:studr/screens/map_screen.dart';
import 'package:studr/screens/search_screen.dart';
import 'package:studr/widgets/auth.dart';

import 'screens/hairdresser_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Hairdressers(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Studr',
          home: /*auth.isAuth ?*/ MyAppBar() /*: AuthScreen()*/,
        ),
      ),
    );
  }
}

class MyAppBar extends StatefulWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  int _currentTab = 0;
  final List<Widget> _children = [
    ProductsOverviewScreen(),
    SearchScreen(),
    MapScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 30,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_outlined,
              size: 30,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on_outlined,
              size: 30,
            ),
            title: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
