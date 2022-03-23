// ignore_for_file: camel_case_types, prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class detailpage extends StatefulWidget {
  final String itemname;
  detailpage({Key? key, required this.itemname}) : super(key: key);

  @override
  State<detailpage> createState() => _detailpageState();
}

class _detailpageState extends State<detailpage> {
  @override
  Widget build(BuildContext context) {
    String itemname = widget.itemname;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Stack(alignment: AlignmentDirectional.center, children: [
              Image.asset(
                "assets/images/cafemocha.png",
              ),
              Positioned(
                child: Image.asset("assets/images/rectangle.png"),
                bottom: -10.0,
              ),
            ]),
            Text("hello" + itemname)
          ],
        )),
      ),
    );
  }
}
