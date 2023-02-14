
import 'dart:math' as math;
import 'package:flutter/material.dart';

class Responsive {

  static final Responsive _instance = Responsive._internal();
  factory Responsive() => _instance;
  Responsive._internal();

  double _width, _height, _inch;
  static const int maxPercent = 100;

  void initResponsive (BuildContext context){
    final size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
    _inch = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2));
  }

  double wp(double percent) {
    return _width * percent / maxPercent;
  }

  double hp(double percent) {
    return _height * percent / maxPercent;
  }

  double ip(double percent) {
    return _inch * percent / maxPercent;
  }

  double hpConsolidatedPosition(double ra) {
    return ra * (_width/7);
  }
}