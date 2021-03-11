import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'hairdresser.dart';

class Hairdressers with ChangeNotifier {
  Future<void> addHairdresser(List<Hairdresser> hairdressers) async {
    const url =
        'https://studr-305121-default-rtdb.firebaseio.com/hairdressers.json';
    try {
      for (var item in hairdressers) {
        final response = await http.post(
          url,
          body: json.encode({
            'id': item.id,
            'title': item.title,
            'description': item.description,
            'priceSection': item.priceSection,
            'icon': item.icon,
            'salon': item.salon,
          }),
        );
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
