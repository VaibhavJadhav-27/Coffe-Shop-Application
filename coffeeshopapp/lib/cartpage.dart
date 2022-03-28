// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_constructors_in_immutables, unused_local_variable, avoid_print, unused_element, avoid_unnecessary_containers, non_constant_identifier_names

import 'dart:convert';

import 'package:coffeeshopapp/cartclass.dart';
import 'package:coffeeshopapp/checkout.dart';
import 'package:coffeeshopapp/menupage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class cartpage extends StatefulWidget {
  final String profile;
  cartpage({Key? key, required this.profile}) : super(key: key);

  @override
  State<cartpage> createState() => _cartpageState();
}

class _cartpageState extends State<cartpage> {
  int lengthct = 0;
  int total = 0;
  late int previous_total;
  bool check = false;
  late int cid;
  late int iid;
  @override
  Widget build(BuildContext context) {
    String profile = widget.profile;

    Future<List<Cart>> displaycart() async {
      //getting the customer id using customer name
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
//getting cart item from cart using custid
      var url = Uri.parse('http://192.168.0.103:4000/cart/cart/$custid');
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var response = await http.get(url, headers: requestHeaders);
      var cartjson = json.decode(response.body);
      print(cartjson);
      List<Cart> cartitems = [];
      for (var u in cartjson) {
        Cart cart = Cart(
            u["custid"],
            u["itemid"],
            u["itemname"],
            u["itemimage"],
            u["itemprice"],
            u["itemquantity"],
            u["totalamount"]);

        total = total + cart.totalamount;

        cartitems.add(cart);
      }
      lengthct = cartitems.length;
      print(lengthct);
      //print(cartitems);
      print("Total price : " + total.toString());
      return cartitems;
    }

    createAlertDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(10),
              backgroundColor: Color.fromRGBO(21, 102, 59, 1),
              elevation: 20,
              title: Text(
                "Delete item from Cart ?",
                style: TextStyle(fontSize: 25, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      check = true;
                      previous_total = total;
                      var url = Uri.parse(
                          'http://192.168.0.103:4000/cart/cart/delete/$cid/$iid');
                      var response = await http.delete(url);
                      var result = json.decode(response.body);
                      print("Response Status code : ${response.statusCode}");
                      print("Response body : " + response.body.toString());
                      setState(() {
                        displaycart();
                        if (previous_total < total) {
                          total = previous_total;
                        }
                        print(total);
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ))
              ],
            );
          });
    }

    @override
    void initState() {
      super.initState();
      displaycart();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  Text("Cart",
                      style: TextStyle(
                          fontFamily: "Comfortaa",
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(21, 102, 59, 1)))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1, style: BorderStyle.solid)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MenuPage(profile: profile)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 90, right: 90, top: 10, bottom: 10),
                    child: Text(
                      "Add More Items",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                "Added Items",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 400,
              child: FutureBuilder(
                  future: displaycart(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return ListView.builder(
                        itemCount: lengthct,
                        itemBuilder: (BuildContext context, int index) {
                          if (snapshot.data == null) {
                            return Container(
                              child: Text(
                                "No items in Cart..!!",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            );
                          } else {
                            return Container(
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: Expanded(
                                          child: Image.asset(
                                              snapshot.data[index].itemimage),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              snapshot.data[index].itemname,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index].itemquantity
                                                    .toString() +
                                                "x",
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "Rs. " +
                                                snapshot.data[index].itemprice
                                                    .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            cid = snapshot.data[index].custid;
                                            iid = snapshot.data[index].itemid;
                                            createAlertDialog(context);
                                          },
                                          icon: Icon(
                                            Icons.delete_rounded,
                                            size: 25,
                                          )),
                                    ],
                                  )),
                            );
                          }
                        });
                  }),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => checkout(
                              profile: profile,
                              totalprice: total,
                            )));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Text(
                  "Checkout",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(21, 102, 59, 1)),
            )
          ],
        ),
      ),
    );
  }
}
