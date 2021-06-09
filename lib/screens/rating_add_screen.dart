import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:studr/models/hairdresser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class AddRating extends StatefulWidget {
  final dynamic selectedItem;

  AddRating(this.selectedItem);

  @override
  _AddRatingState createState() => _AddRatingState();
}

class _AddRatingState extends State<AddRating> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    var name;
    var comment;
    var rating = 0.0;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: 260,
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Image.asset(
                'assets/icons/${widget.selectedItem["icon"]}',
                fit: BoxFit.cover,
                height: deviceSize.height * 0.25,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
                onSaved: (value) => name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Kommentar'),
                keyboardType: TextInputType.text,
                onSaved: (value) => comment = value,
              ),
              RatingBar.builder(
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (v) {
                  rating = v;
                },
                allowHalfRating: true,
              ),
              SizedBox(height: deviceSize.height * 0.10),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState.save();

                  FirebaseFirestore.instance
                      .collection("Hairdresser/5IQWZYUyMCjNxFdM07lE/Ratings")
                      .add(
                    {
                      'name': name,
                      'comment': comment,
                      'rating': rating,
                    },
                  );
                  Navigator.pop(context);
                },
                child: const Text("Bewerten"),
                style: ElevatedButton.styleFrom(
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    elevation: 5,
                    fixedSize: Size(
                      deviceSize.width * 0.50,
                      deviceSize.height * 0.10,
                    ),
                    primary: Colors.teal,
                    side: BorderSide(width: 5, color: Colors.teal.shade100)),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
