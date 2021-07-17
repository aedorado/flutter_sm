import 'package:flutter/material.dart';
import 'package:flutter_social_media/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Social Media',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.purpleAccent,
      ),
      home: Home(),
    );
  }
}
