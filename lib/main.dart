import 'package:Intern_Project_naxa/src/Views/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Intern Project",
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}