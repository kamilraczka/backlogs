import 'package:flutter/material.dart';

extension IconDataExtension on IconData {
  Map<String, dynamic> get mapValue => _toMap(this);

  Map<String, dynamic> _toMap(IconData data) => {
        "codePoint": data.codePoint,
        "fontFamily": data.fontFamily,
        "fontPackage": data.fontPackage,
      };

  static IconData fromMap(Map<String, dynamic> map) => IconData(
        map['codePoint'],
        fontFamily: map['fontFamily'],
        fontPackage: map['fontPackage'],
      );
}
