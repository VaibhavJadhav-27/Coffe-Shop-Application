// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';

class DPpage extends StatefulWidget {
  final String profile;
  DPpage({Key? key, required this.profile}) : super(key: key);

  @override
  State<DPpage> createState() => _DPpageState();
}

class _DPpageState extends State<DPpage> {
  @override
  Widget build(BuildContext context) {
    String profile = widget.profile;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(),
    ));
  }
}
