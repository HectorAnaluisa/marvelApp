import 'package:flutter/material.dart';
import 'package:inhered_widget/src/pages/details_page.dart';
import 'package:inhered_widget/src/pages/home_page.dart';
import 'package:inhered_widget/src/pages/type_page.dart';

Map<String, WidgetBuilder> getRoutesApp(){
  return <String, WidgetBuilder> {
    'home' : (BuildContext context) => HomePage() ,
    'type' : (BuildContext context) => TypePage() ,
    'details' : (BuildContext context) => DetailsPage()
  };
}