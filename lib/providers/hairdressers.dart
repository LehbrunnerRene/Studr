import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:studr/models/hairdresser.dart';
import 'package:http/http.dart' as http;

class Hairdressers with ChangeNotifier {
  List<Hairdresser> _items = [];

  List<Hairdresser> get items {
    return [..._items];
  }

  Future<void> fetchAndSetHairdresser() async {
    const url =
        'https://studr-305121-default-rtdb.firebaseio.com/hairdresser.json';
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
  }
}
