import 'package:flutter/material.dart';
import 'package:news/pages/tab.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'newsList by pandaterminator',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: TabBarMain());
  }
}
