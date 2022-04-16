// ignore_for_file: prefer_const_constructors_in_immutables, unused_local_variable, avoid_print, unused_element, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileAdmin extends StatefulWidget {
  final String profile;
  ProfileAdmin({Key? key, required this.profile}) : super(key: key);

  @override
  State<ProfileAdmin> createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  @override
  Widget build(BuildContext context) {
    String profile = widget.profile;
    String designation = "";
    String email = "";
    String phoneno = "";

    void getUserDetails() async {
      var url =
          Uri.parse('http://192.168.0.103:4000/employee/employee/$profile');
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var response = await http.get(url);
      var resultjson = json.decode(response.body);
      print(resultjson);
      print(resultjson[0]["custid"].toString());
      setState(() {
        designation = resultjson[0]["empdesignation"].toString();
        email = resultjson[0]["empemail"];
        phoneno = resultjson[0]["empphoneno"];
      });
    }

    @override
    void initState() {
      super.initState();
      getUserDetails();
    }

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                  child: Image.asset(
                    "assets/images/profile1.png",
                    scale: 1.2,
                  ),
                  radius: 80,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.black,
              thickness: 5,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Name : ",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Text(
                  profile,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Email id : ",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Text(
                  email,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Phone no : ",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Text(
                  phoneno,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
