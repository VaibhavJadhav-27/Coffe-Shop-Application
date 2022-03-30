// ignore_for_file: must_be_immutable, avoid_print, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:coffeeshopapp/cartpage.dart';
import 'package:coffeeshopapp/home_page.dart';
import 'package:coffeeshopapp/menupage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  String custname;
  ProfilePage({Key? key, required this.custname}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String profile = "";
  String email = "";
  String phoneno = "";
  String custid = "";

  void getUserDetails() async {
    profile = widget.custname;
    print(profile);
    var url = Uri.parse('http://192.168.0.103:4000/customer/customer/$profile');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.get(url);
    var resultjson = json.decode(response.body);
    print(resultjson);
    print(resultjson[0]["custid"].toString());
    setState(() {
      custid = resultjson[0]["custid"].toString();
      email = resultjson[0]["custemail"];
      phoneno = resultjson[0]["custphoneno"];
    });
  }

  @override
  void initState() {
    super.initState();
    //profile = widget.custname;
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    String custname = widget.custname;

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
            Spacer(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Homepage(profile: profile)));
                          },
                          icon: Icon(
                            Icons.home,
                            color: Colors.black,
                          ),
                          iconSize: 30,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MenuPage(profile: profile)));
                            },
                            icon: Image.asset(
                              "assets/images/cup.png",
                              height: 24,
                            )),
                        Text(
                          "Menu",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              "assets/images/document.png",
                              height: 24,
                              color: Colors.black,
                            )),
                        Text(
                          "Orders",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        cartpage(profile: profile)));
                          },
                          icon: Icon(Icons.shopping_cart_outlined),
                          iconSize: 30,
                        ),
                        Text(
                          "Cart",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.person,
                            color: Color.fromRGBO(21, 102, 59, 1),
                          ),
                          iconSize: 30,
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))
              ],
            )
          ],
        ),
      )),
    );
  }
}
