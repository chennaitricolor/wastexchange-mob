// TODO(Sayeed): Is this a good design. Discuss with others.
import 'dart:math';

bool isNull(Object object) => object == null;

bool isNotNull(Object object) => object != null;

bool isListNullOrEmpty(List value) => value == null || value.isEmpty;

bool isMapNullOrEmpty(Map value) => value == null || value.isEmpty;

bool isValidIndex(int size, int index) => index < size;

bool isInValidIndex(int size, int index) => index >= size;

bool isNullOrEmpty(String value) => isNull(value) || value.isEmpty;

bool isZero(String value) => value == '0';

bool isDouble(String value) => double.tryParse(value) != null;

bool isPositive(String value) => double.tryParse(value) > 0;

const String EMPTY = '';

double roundToPlaces(double value, int places) {
  final int fac = pow(10, places);
  return (value * fac).round() / fac;
}
