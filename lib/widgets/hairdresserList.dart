import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/hairdresser.dart';
import '../providers/hairdressers.dart';
import '../screens/detail_screen.dart';

class HairdresserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedItems = Provider.of<Hairdressers>(context).hairdressers;
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 5.0,
            right: 5.0,
          ),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Search",
            ),
          ),
        ),
        Divider(
          color: Colors.black,
          thickness: 2,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: loadedItems.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                color: Colors.white,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(loadedItems[index])));
                  },
                  title: Text(
                    loadedItems[index]["title"],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Column(
                    children: [
                      Text(
                        loadedItems[index]["description"],
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            loadedItems[index]["priceSection"],
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 15,
                                height: 1.5),
                          ),
                          Text(
                            'Haarstudio',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            'Geöffnet',
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    ],
                  ),
                  contentPadding: EdgeInsets.all(20.0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage(
                        'assets/icons/${loadedItems[index]["icon"]}'),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
