// ignore_for_file: prefer_const_constructors

import 'package:coffeeshopapp/detailpage.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
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
                    "Menu",
                    style: TextStyle(
                      //fontFamily: "Pacifico",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Category",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(onPressed: () {}, child: Text("data")),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Products",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
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
                              },
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
                                onPressed: () {},
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
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => detailpage()));
                                },
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
