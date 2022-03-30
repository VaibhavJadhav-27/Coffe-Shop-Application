// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'deliveryclass.dart';

class OrderPage extends StatefulWidget {
  final String profile;
  OrderPage({Key? key, required this.profile}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    String profile = widget.profile;

    Future<List<Order>> viewcustomerorder() async {
      var url =
          Uri.parse('http://192.168.0.103:4000/customer/customer/$profile');
      Map<String, String> requestHeaders1 = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var response1 = await http.get(url, headers: requestHeaders1);
      var custjson = json.decode(response1.body);
      print(custjson);
      int custid = custjson[0]["custid"];

      //fetching active orders using customer id and isreceived as false
      var url1 = Uri.parse(
          'http:192.168.0.103:4000/delivery/delivery/deliveryid/$custid/false');
          var
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      width: MediaQuery.of(context).size.width * 0.3,
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
                child: Text("Active Orders"),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
