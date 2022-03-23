// ignore_for_file: prefer_const_constructors, deprecated_member_use, unused_local_variable, avoid_print, unused_import, unnecessary_null_comparison, avoid_unnecessary_containers

import 'dart:convert';
import 'dart:async';
import 'package:coffeeshopapp/detailpage.dart';
import 'package:coffeeshopapp/display%20products.dart';
import 'package:coffeeshopapp/menuclass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late List data;
  int lengthit = 5;

  Future<List<Menu>> displayMenu() async {
    //var url = Uri.parse('http://10.0.2.2:4000/menu/menu');
    var url = Uri.parse('http://192.168.0.103:4000/menu/menu');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.get(url, headers: requestHeaders);
    var menujson = json.decode(response.body);
    List<Menu> menuitems = [];
    for (var u in menujson) {
      Menu menu = Menu(u["itemid"], u["itemname"], u["itemdesc"],
          u["itemcategory"], u["itemimage"], u["itemprice"]);
      menuitems.add(menu);
    }

    //print(menuitems.length);
    lengthit = menuitems.length;
    print(lengthit);
    return menuitems;
  }

  @override
  void initState() {
    super.initState();
    displayMenu();
  }

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
                ElevatedButton(
                    onPressed: () {
                      displayMenu();
                    },
                    child: Text("data")),
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
                /*
                ListView.builder(
                    itemCount: data == null ? 0 : data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    data[index].itemimage,
                                    height: 50,
                                  ),
                                  Column(
                                    children: [
                                      Text(data[index].itemname),
                                      Text(data[index].itemprice.toString())
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    })
                SizedBox(
                  height: 500,
                  child: FutureBuilder(
                      future: displayMenu(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return ListView.builder(
                            itemCount: lengthit,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              if (snapshot.data == null) {
                                return Container(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Card(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    /*SizedBox(
                                      height: 100,
                                      child: */
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: Image.asset(
                                            snapshot.data[index].itemimage,
                                            //scale: 0.9,
                                            //height: 50,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(snapshot.data[index].itemname),
                                            Text(snapshot.data[index].itemprice
                                                .toString())
                                          ],
                                        )
                                      ],
                                    ),
                                    //)
                                  ],
                                ));
                              }
                            });
                      }),
                ),*/
                SizedBox(
                  height: 470,
                  child: FutureBuilder(
                      future: displayMenu(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return GridView.builder(
                            itemCount: lengthit,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
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
                                      String iname =
                                          snapshot.data[index].itemname;
                                      print(iname);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  detailpage(itemname: iname)));
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
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Text(
                                              "Rs. " +
                                                  snapshot.data[index].itemprice
                                                      .toString(),
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
