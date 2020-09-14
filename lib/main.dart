import 'package:flutter/material.dart';
import 'package:inhered_widget/src/providers/info/type_info.dart';
import 'package:inhered_widget/src/routes/routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TypeInfo())
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'type',
        routes: getRoutesApp(),
      ),
    );
  }
}