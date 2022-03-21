// ignore_for_file: avoid_unnecessary_containers, unused_local_variable, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:coffeeshopapp/menupage.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  final String profile;
  const Homepage({Key? key, required this.profile}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    String profile = "nisha";

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Center(
                      child: Text(
                    "lazy beans",
                    style: TextStyle(
                        fontFamily: "Pacifico",
                        fontSize: 25,
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
                  height: 10,
                ),
                Text("Lets have a coffee and unwind",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.normal)),
                Image.asset(
                  "assets/images/unsplash_homepic.png",
                  height: 200,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Recommended to you",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Sweet Delights",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.home,
                                color: Color.fromRGBO(21, 102, 59, 1),
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
                                          builder: (context) => MenuPage()));
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
                                  color: Color.fromRGBO(21, 102, 59, 1),
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
                              onPressed: () {},
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
                              icon: Icon(Icons.person),
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
          ),
        ),
      ),
    );
  }
}
