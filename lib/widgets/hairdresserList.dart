import 'package:flutter/material.dart';
import '../models/hairdresser.dart';
import '../screens/detail_screen.dart';

class HairdresserList extends StatelessWidget {
  final List<Hairdresser> loadedItems;

  HairdresserList(this.loadedItems);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                      builder: (context) => DetailScreen(loadedItems[index])));
            },
            title: Text(
              loadedItems[index].title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Column(
              children: [
                Text(
                  loadedItems[index].description,
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
                      loadedItems[index].priceSection,
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
              backgroundImage:
                  AssetImage('assets/icons/${loadedItems[index].icon}'),
            ),
          ),
        );
      },
    );
  }
}
