import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Social Media',
      home: Container(
        child: Text('Flutter Social Media'),
      ),
    );
  }
}

// WidgetsFlutterBinding.ensureInitialized();
// Firebase
// await Firebase.initializeApp();
