// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable, avoid_unnecessary_containers, unused_element

import 'dart:convert';

import 'package:coffeeshopapp/home_page.dart';
import 'package:coffeeshopapp/menupage.dart';
import 'package:coffeeshopapp/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cartpage.dart';
import 'deliveryclass.dart';

class OrderPage extends StatefulWidget {
  final String profile;
  OrderPage({Key? key, required this.profile}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int lengthdl = 0;
  int lengthdl1 = 0;
  @override
  Widget build(BuildContext context) {
    String profile = widget.profile;

    Future<List<Delivery>> viewcustomerorder() async {
      var url1 =
          Uri.parse('http://192.168.0.103:4000/customer/customer/$profile');
      Map<String, String> requestHeaders1 = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var response1 = await http.get(url1, headers: requestHeaders1);
      var custjson = json.decode(response1.body);
      print(custjson);
      int custid = custjson[0]["custid"];

      //fetching active orders using customer id and isreceived as false
      var url2 = Uri.parse(
          'http://192.168.0.103:4000/delivery/delivery/deliveryid/$custid/false');
      var response2 = await http.get(url2, headers: requestHeaders1);
      var deliveryjson = json.decode(response2.body);
      List<Delivery> deliveryitems = [];
      for (var u in deliveryjson) {
        Delivery delivery = Delivery(u["deliveryid"], u["custid"], u["orderid"],
            u["address"], u["items"], u["totalamount"], u["isreceived"]);
        deliveryitems.add(delivery);
      }
      lengthdl = deliveryitems.length;
      print(deliveryitems.length);
      return deliveryitems;
    }

    Future<List<Delivery>> viewcustomerorder1() async {
      var url1 =
          Uri.parse('http://192.168.0.103:4000/customer/customer/$profile');
      Map<String, String> requestHeaders1 = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var response1 = await http.get(url1, headers: requestHeaders1);
      var custjson = json.decode(response1.body);
      print(custjson);
      int custid = custjson[0]["custid"];

      //fetching active orders using customer id and isreceived as false
      var url2 = Uri.parse(
          'http://192.168.0.103:4000/delivery/delivery/deliveryid/$custid/true');
      var response2 = await http.get(url2, headers: requestHeaders1);
      var deliveryjson = json.decode(response2.body);
      List<Delivery> deliveryitems = [];
      for (var u in deliveryjson) {
        Delivery delivery = Delivery(u["deliveryid"], u["custid"], u["orderid"],
            u["address"], u["items"], u["totalamount"], u["isreceived"]);
        deliveryitems.add(delivery);
      }
      lengthdl1 = deliveryitems.length;
      print(deliveryitems.length);
      return deliveryitems;
    }

    void initState() {
      super.initState();
      viewcustomerorder();
      viewcustomerorder1();
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 15,
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                    Text("Orders",
                        style: TextStyle(
                            fontFamily: "Comfortaa",
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(21, 102, 59, 1)))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Active Orders",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width * 0.9,
                child: FutureBuilder(
                    future: viewcustomerorder(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return ListView.builder(
                          itemCount: lengthdl,
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.data == null) {
                              return Container(
                                child: Text(
                                  "No Orders yet..!!",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Order Number : ",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text("#O" +
                                                  snapshot.data[index].orderid
                                                      .toString()),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Ordered Items: ",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.start,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data[index].items,
                                                  /*softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,*/
                                                  //maxLines: 3,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Total Price : ",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(snapshot
                                                  .data[index].totalamount
                                                  .toString()),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Type : ",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text("Delivery"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Status : ",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text((snapshot.data[index]
                                                          .isreceived ==
                                                      "false")
                                                  ? "Ordered"
                                                  : snapshot
                                                      .data[index].isreceived),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                          });
                    }),
              ),
              Divider(),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Recently Ordered Items",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width * 0.9,
                child: FutureBuilder(
                    future: viewcustomerorder1(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return ListView.builder(
                          itemCount: lengthdl1,
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.data.length == 0) {
                              return Container(
                                child: Text(
                                  "No Orders yet..!!",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Order Number : ",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text("#O" +
                                                  snapshot.data[index].orderid
                                                      .toString()),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Ordered Items: ",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.start,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data[index].items,
                                                  /*softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,*/
                                                  //maxLines: 3,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Total Price : ",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(snapshot
                                                  .data[index].totalamount
                                                  .toString()),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Type : ",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text("Delivery"),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Status : ",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text((snapshot.data[index]
                                                          .isreceived ==
                                                      "true")
                                                  ? "Delivered"
                                                  : snapshot
                                                      .data[index].isreceived),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                          });
                    }),
              ),
              SizedBox(height: 10),
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
                                color: Colors.black,
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
                              icon: Image.asset("assets/images/document.png",
                                  height: 24,
                                  color: Color.fromRGBO(21, 102, 59, 1))),
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
    );
  }
}
