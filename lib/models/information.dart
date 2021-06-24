import 'package:flutter/material.dart';

class Information {
  final String city;
  final String postalCode;
  final String street;
  final String email;
  final String openingTimes;
  final int hId;
  final String phoneNumber;
  final String priceSegment;
  final double rating;

  Information(
      this.city,
      this.postalCode,
      this.street,
      this.email,
      this.openingTimes,
      this.hId,
      this.phoneNumber,
      this.priceSegment,
      this.rating);
}
