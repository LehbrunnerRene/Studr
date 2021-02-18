import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studr/models/hairdresser.dart';

class MapScreen extends StatelessWidget {
  MapScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(
          "MAP\nIN PROGRESS ...",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
