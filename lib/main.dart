import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studr/providers/google_sign_in.dart';
import 'package:studr/providers/hairdressers.dart';
import 'package:studr/screens/auth_screen.dart';
import 'package:studr/screens/map_screen.dart';
import 'package:studr/screens/search_screen.dart';
import 'package:studr/screens/signup_screen.dart';
import 'package:studr/widgets/auth.dart';
import 'package:studr/widgets/categoriesScroller.dart';

import 'screens/hairdresser_overview_screen.dart';
import 'widgets/hairdresserList.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Hairdressers>(
          update: (ctx, auth, previousHairdressers) => Hairdressers(
            auth.token,
            previousHairdressers == null ? [] : previousHairdressers.items,
          ),
        ),
        /*ChangeNotifierProvider(
          create: (ctx) => Hairdressers(),
        ),*/
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          theme: ThemeData.from(
            colorScheme: const ColorScheme.light(),
          ).copyWith(
              pageTransitionsTheme: const PageTransitionsTheme(
                  builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
              })),
          title: 'Studr',
          //home: auth.isAuth ? MyAppBar() : AuthScreen(),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, userSnapshot) {
                print(userSnapshot.hasData);
                if (userSnapshot.hasData) {
                  return MyAppBar();
                }
                return AuthScreen();
              }),
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
    HairdresserList(),
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
