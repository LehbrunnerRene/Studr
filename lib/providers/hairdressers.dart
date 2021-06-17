import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:studr/models/hairdresser.dart';
import 'package:http/http.dart' as http;

class Hairdressers with ChangeNotifier {
  final String authToken;
  List<Hairdresser> _items = [];
  List<dynamic> _information = [];
  List<dynamic> _prices = [];
  List<dynamic> _ratings = [];
  List<dynamic> _hairdressers = [];

  Hairdressers(this.authToken, this._items);

  List<Hairdresser> get items {
    return [..._items];
  }

  List<dynamic> get information {
    return [..._information];
  }

  List<dynamic> get prices {
    return [..._prices.reversed.toList()];
  }

  List<dynamic> get ratings {
    return [..._ratings];
  }

  List<dynamic> get hairdressers {
    return [..._hairdressers];
  }

  /*Future<void> fetchAndSetHairdresser() async {
    final url =
        'https://studr-305121-default-rtdb.firebaseio.com/hairdresser.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData == null) {
        return null;
      }
      final List<Hairdresser> loadedHairdresser = [];
      extractedData.forEach((value) {
        loadedHairdresser.add(Hairdresser(
          id: value['id'],
          title: value['title'],
          description: value['description'],
          priceSection: value['priceSection'],
          icon: value['icon'],
          salon: value['salon'],
        ));
      });
      _items = loadedHairdresser;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }*/

  Future<dynamic> getInformation() async {
    await FirebaseFirestore.instance
        .collection("Hairdresser/5IQWZYUyMCjNxFdM07lE/Information")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _information.add(element.data());
      });
    });
    notifyListeners();
  }

  Future<dynamic> getInfo() async {
    await FirebaseFirestore.instance
        .collection("Hairdresser")
        .orderBy("id")
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference
                  .collection("Information")
                  .get()
                  .then((value) => value.docs.forEach((element) {
                        print(element.data());
                        _information.add(element.data());
                      }));
            }));
  }

  Future<dynamic> getPric() async {
    await FirebaseFirestore.instance
        .collection("Hairdresser")
        .orderBy("id")
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference
                  .collection("Prices")
                  .get()
                  .then((value) => value.docs.forEach((element) {
                        print(element.data());
                        _prices.add(element.data());
                      }));
            }));
  }

  Future<dynamic> getRating() async {
    await FirebaseFirestore.instance
        .collection("Hairdresser")
        .orderBy("id")
        .get()
        .then((value) => value.docs.forEach((element) {
              element.reference
                  .collection("Ratings")
                  .get()
                  .then((value) => value.docs.forEach((element) {
                        _ratings.add(element.data());
                      }));
            }));
    notifyListeners();
  }

  Future<dynamic> getPrices() async {
    await FirebaseFirestore.instance
        .collection("Hairdresser/5IQWZYUyMCjNxFdM07lE/Prices")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _prices.add(element.data());
      });
    });
    notifyListeners();
  }

  Future<dynamic> getRatings() async {
    await FirebaseFirestore.instance
        .collection("Hairdresser/5IQWZYUyMCjNxFdM07lE/Ratings")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _ratings.add(element.data());
      });
    });
    notifyListeners();
  }

  Future<dynamic> getHairdressers() async {
    await FirebaseFirestore.instance
        .collection("Hairdresser")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _hairdressers.add(element.data());
      });
    });
    notifyListeners();
  }
}
