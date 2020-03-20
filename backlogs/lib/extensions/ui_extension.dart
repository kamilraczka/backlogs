import 'package:flutter/material.dart';

extension UIExtensions on Widget {
  Widget embedInCard() {
    return Card(
      child: this,
    );
  }
}
