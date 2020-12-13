import 'package:flutter/material.dart';
import 'package:studr/models/hairdresser.dart';

class DetailScreen extends StatelessWidget {
  final Hairdresser selectedItem;

  DetailScreen(this.selectedItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => {Navigator.pop(context)},
              ),
              CircleAvatar(
                radius: 75,
                backgroundImage:
                    AssetImage('assets/icons/${selectedItem.icon}'),
              ),
              IconButton(icon: Icon(Icons.settings), onPressed: () => {})
            ],
          ),
          SizedBox(height: 50),
          Text(
            selectedItem.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 20),
          Text(
            selectedItem.description,
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 200),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.blue)),
            padding: const EdgeInsets.all(20.0),
            onPressed: () {},
            color: Colors.blue,
            textColor: Colors.white,
            child: Text("TERMIN BUCHEN".toUpperCase(),
                style: TextStyle(fontSize: 25)),
          ),
        ],
      ),
    );
  }
}
