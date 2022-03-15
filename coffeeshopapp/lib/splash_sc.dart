// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:coffeeshopapp/Login_Page.dart';
import 'package:flutter/material.dart';

class Splash_SC extends StatefulWidget {
  const Splash_SC({Key? key}) : super(key: key);

  @override
  State<Splash_SC> createState() => _Splash_SCState();
}

class _Splash_SCState extends State<Splash_SC> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    if (_controller.isCompleted) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Login_Page()));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/splashscreen_basic.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            Positioned(
                top: 200,
                left: 190,
                child: Image.asset("assets/images/logo.png"))
          ],
        ),
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(offset: Offset(0.0, 0.0));
        });
  }
}
