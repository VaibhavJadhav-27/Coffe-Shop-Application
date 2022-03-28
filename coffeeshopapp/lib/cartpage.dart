// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:coffeeshopapp/cartclass.dart';
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
      var response = await http.get(url1, headers: requestHeaders);
      var cartjson = json.decode(response.body);
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
        cartitems.add(cart);
      }
      lengthct = cartitems.length;
      print(lengthct);
      return cartitems;
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
                      onPressed: () {},
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
                  onPressed: () {},
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
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}
