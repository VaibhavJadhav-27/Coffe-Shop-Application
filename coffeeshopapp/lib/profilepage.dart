import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  String custname;
  ProfilePage({Key? key, required this.custname}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    String custname = widget.custname;

    return Container(
      child: Text("profile"),
    );
  }
}
