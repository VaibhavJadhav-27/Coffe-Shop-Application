// ignore_for_file: prefer_const_constructors_in_immutables, unused_local_variable, prefer_const_constructors

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
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Center(
                    child: Text(
                  "lazy beans",
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      color: Color.fromRGBO(21, 102, 59, 1)),
                )),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Welcome $profile",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 15,
              ),
              Text("Lets have a coffee and unwind",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
              Image.asset(
                "assets/images/unsplash_homepic.png",
                height: 230,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(101, 30, 62, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "Employee",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
