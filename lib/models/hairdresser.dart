import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Hairdresser {
  final int id;
  final String title;
  final String description;
  final String priceSection;
  final String icon;
  final String salon;

  Hairdresser({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.priceSection,
    @required this.icon,
    @required this.salon,
  });
}
