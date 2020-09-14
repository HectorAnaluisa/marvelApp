import 'dart:math' as math;
import 'package:flutter/material.dart';

class ResponsiveUtils {
  double width, height, inch;

  ResponsiveUtils(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    width = screenSize.width;
    height = screenSize.height;
    inch = math.sqrt(math.pow(width, 2) + math.pow(height, 2)); 
  }

  double wp( double percent ) {
    return width * percent/100;
  }
  double hp( double percent ) {
    return height * percent/100;
  }
  double ip( double percent ) {
    return inch * percent/100;
  }
}