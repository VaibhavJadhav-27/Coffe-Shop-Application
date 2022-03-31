import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  final String profile;
  AdminDashboard({Key? key, required this.profile}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    String profile = widget.profile;
    return Scaffold(
      body: SingleChildScrollView(
        child: Text("Welcome " + profile),
      ),
    );
  }
}
