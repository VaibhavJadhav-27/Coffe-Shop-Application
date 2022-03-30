// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable, avoid_unnecessary_containers

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
  late int lengthdl;
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
          'http:192.168.0.103:4000/delivery/delivery/deliveryid/$custid/false');
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
              SizedBox(
                height: 200,
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
                              return Container(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text("#O" +
                                              snapshot.data[index].orderid
                                                  .toString()),
                                          Text(snapshot.data[index].items),
                                          Text("Total Price : " +
                                              snapshot.data[index].totalamount
                                                  .toString()),
                                          Text("Type: Delivery"),
                                          Text("Status : " +
                                              snapshot.data[index].isreceived)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
