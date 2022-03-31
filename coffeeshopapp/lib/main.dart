// ignore_for_file: prefer_const_constructors, unused_import

import 'package:coffeeshopapp/Login_Page.dart';
import 'package:coffeeshopapp/Register_Page.dart';
import 'package:coffeeshopapp/deliverypersonpage.dart';
import 'package:coffeeshopapp/home_page.dart';
import 'package:coffeeshopapp/orderconfirm.dart';
import 'package:coffeeshopapp/orderspage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: Login_Page()),
      debugShowCheckedModeBanner: false,
    );
  }
}
