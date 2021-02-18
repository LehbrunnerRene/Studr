import 'package:flutter/material.dart';

class DividerPadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: Divider(
        color: Colors.grey,
        thickness: 2,
      ),
    );
  }
}
