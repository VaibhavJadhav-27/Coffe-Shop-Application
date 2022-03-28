// ignore_for_file: avoid_unnecessary_containers, unused_local_variable, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, avoid_print

import 'package:coffeeshopapp/detailpage.dart';
import 'package:coffeeshopapp/menuclass.dart';
import 'package:coffeeshopapp/menupage.dart';
import 'package:coffeeshopapp/profilepage.dart';
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
    String profile = widget.profile;
    int lengthit = 2;

    Future<List<Menu>> recommend() async {
      List<Menu> recommenditems = [];
      Menu items = Menu(
          1,
          "Cappuccino",
          "A cappuccino is a popular coffee drink that is made by topping a shot of espresso with steamed milk and milk foam.",
          "hotcoffee",
          "assets/images/cappuccino.png",
          80);
      recommenditems.add(items);

      items = Menu(
          12,
          "Donuts",
          "A small fried cake of sweetened dough, typically in the shape of a ball or ring",
          "desserts",
          "assets/images/donuts.png",
          90);
      recommenditems.add(items);

      items = Menu(
          4,
          "Cafe Latte",
          "Latte is a unique coffee drink that is commonly made by using espresso, steamed milk, and milk foam.",
          "hotcoffee",
          "assets/images/cafelatte.png",
          100);
      recommenditems.add(items);

      items = Menu(
          14,
          "Muffins",
          " A bread made of batter containing egg and baked in a pan having cuplike molds",
          "desserts",
          "assets/images/muffin.jpg",
          80);
      recommenditems.add(items);

      lengthit = recommenditems.length;
      print(recommenditems);
      return recommenditems;
    }

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
                Text(
                  "Life is like coffee; the darker it gets, the more it energizes",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(101, 30, 62, 1),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 38,
                ),
                Text(
                  "Recommended to you",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 150,
                  child: FutureBuilder(
                      future: recommend(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return GridView.builder(
                            itemCount: lengthit,
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1),
                            itemBuilder: (BuildContext context, int index) {
                              if (snapshot.data == null) {
                                return Container(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white),
                                    onPressed: () {
                                      int iid = snapshot.data[index].itemid;
                                      String iname =
                                          snapshot.data[index].itemname;
                                      String iimage =
                                          snapshot.data[index].itemimage;
                                      String idesc =
                                          snapshot.data[index].itemdesc;
                                      String iprice = snapshot
                                          .data[index].itemprice
                                          .toString();
                                      print(iname);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => detailpage(
                                                    profile: profile,
                                                    itemid: iid,
                                                    itemname: iname,
                                                    itemdesc: idesc,
                                                    itemimage: iimage,
                                                    itemprice: iprice,
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          /*SizedBox(
                                        height: 100,
                                        child: */
                                          Expanded(
                                            child: Image.asset(
                                              snapshot.data[index].itemimage,
                                              fit: BoxFit.cover,
                                              //scale: 0.9,
                                              //height: 50,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Text(
                                              snapshot.data[index].itemname,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          //)
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            });
                      }),
                ),
                SizedBox(
                  height: 25,
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
                                          builder: (context) => MenuPage(
                                                profile: profile,
                                              )));
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    (MaterialPageRoute(
                                        builder: (context) => ProfilePage(
                                              custname: profile,
                                            ))));
                              },
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
