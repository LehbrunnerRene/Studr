import 'package:flutter/foundation.dart';

class Hairdresser {
  final int id;
  final String title;
  final String description;
  final String priceSection;
  final String icon;

  Hairdresser({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.priceSection,
    @required this.icon,
  });
}
