// ignore_for_file: prefer_const_constructors

import 'package:coffeeshopapp/Login_Page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Login_Page(),
      ),
    );
  }
}
