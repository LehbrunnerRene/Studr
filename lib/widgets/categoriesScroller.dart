import 'package:flutter/material.dart';
import 'package:studr/models/hairdresser.dart';
import 'package:studr/screens/detail_screen.dart';
import 'package:studr/widgets/topAppBar.dart';

class CategoriesScroller extends StatelessWidget {
  final List<Hairdresser> loadedItems;

  const CategoriesScroller(this.loadedItems);

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 1.7,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                        0.2,
                        1,
                      ],
                      colors: [Colors.purple, Colors.blue],
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Hi Tobias!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 20.0, top: 15.0),
              child: Text(
                "In deiner Nähe:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: this.loadedItems.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(loadedItems[index])));
                    },
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 8),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          alignment: Alignment.topCenter,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 150,
                                margin: EdgeInsets.only(right: 5),
                                height: categoryHeight,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        spreadRadius: 0.5,
                                        blurRadius: 5,
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/icons/${loadedItems[index].icon}',
                                        fit: BoxFit.cover,
                                        width: 85,
                                        height: 75,
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        thickness: 3,
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          loadedItems[index].title,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            loadedItems[index].priceSection,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            'Geöffnet',
                                            style: TextStyle(
                                                color: Colors.green.shade800),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
