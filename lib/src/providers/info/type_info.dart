import 'package:flutter/material.dart';

class TypeInfo with ChangeNotifier {

  String typeCharacter;
  Color loadingColor;
  List<Color> headerColors = [Colors.red, Colors.red[900]];

  get getTypeCharacter {
    return this.typeCharacter; 
  }

  set setTypeCharacter(String typeCharacter) {
    this.typeCharacter = typeCharacter;
  }

  get getLoadingColor {
    return this.loadingColor; 
  }

  set setLoadingColor(Color loadingColor) {
    this.loadingColor = loadingColor;
  }

  get getHeaderColors {
    return this.headerColors;
  }

  set setHeaderColor( List<Color> headerColors){
    this.headerColors.clear();
    this.headerColors.addAll(headerColors);
  }

}