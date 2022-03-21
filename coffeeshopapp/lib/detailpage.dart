// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';

class detailpage extends StatefulWidget {
  const detailpage({Key? key}) : super(key: key);

  @override
  State<detailpage> createState() => _detailpageState();
}

class _detailpageState extends State<detailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Stack(alignment: AlignmentDirectional.center, children: [
              Image.asset(
                "assets/images/cafemoocha.png",
              ),
              Positioned(
                child: Image.asset("assets/images/rectangle.png"),
                bottom: -10.0,
              ),
            ]),
            Text("hello")
          ],
        )),
      ),
    );
  }
}
