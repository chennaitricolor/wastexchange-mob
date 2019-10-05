import 'dart:convert';
import 'package:flutter/material.dart';

//Courtesy: https://stackoverflow.com/questions/49611724/dart-how-to-json-decode-0-as-double
JsonCodec codecForIntToDoubleConversion({@required String key}) {
  return JsonCodec.withReviver((dynamic _key, dynamic _value) {
    if (_key == key && _value is int) {
      return _value.toDouble();
    }
    return _value;
  });
}
