// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'deliveryclass.dart';

class DeliveryAdmin extends StatefulWidget {
  DeliveryAdmin({Key? key}) : super(key: key);

  @override
  State<DeliveryAdmin> createState() => _DeliveryAdminState();
}

class _DeliveryAdminState extends State<DeliveryAdmin> {
  int lengthdl = 0;
  List<Delivery> deliveryitems = [];

  Future<List<Delivery>> viewdeliveryorder() async {
    var url = Uri.parse('http://192.168.0.201:4000/delivery/delivery');
    var response = await http.get(url);
    var orderjson = json.decode(response.body.toString());

    for (var u in orderjson) {
      Delivery delivery = Delivery(u["deliveryid"], u["custid"], u["orderid"],
          u["address"], u["items"], u["totalamount"], u["isreceived"]);
      deliveryitems.add(delivery);
    }
    lengthdl = deliveryitems.length;
    setState(() {
      deliveryitems;
    });
    print(lengthdl);
    return deliveryitems;
  }

  @override
  void initState() {
    super.initState();
    viewdeliveryorder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Text(
                      " Delivery Orders",
                      style: TextStyle(
                          fontFamily: "Comfortaa",
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(21, 102, 59, 1)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              DataTable(
                  // ignore: prefer_const_literals_to_create_immutables
                  columns: [
                    DataColumn(label: Text("Customer ID")),
                    DataColumn(label: Text("Order ID")),
                    DataColumn(label: Text("Address")),
                    DataColumn(label: Text("Total amount")),
                    DataColumn(label: Text("Status")),
                  ],
                  rows: deliveryitems
                      .map<DataRow>((e) => DataRow(cells: [
                            DataCell(
                              Text(e.custid.toString()),
                              onTap: () {},
                            ),
                            DataCell(Text(e.orderid.toString())),
                            DataCell(Expanded(
                                child: Text(
                              e.address.toString(),
                              softWrap: true,
                            ))),
                            DataCell(Text(e.totalamount.toString())),
                            DataCell(Text(e.isreceived.toString()))
                          ]))
                      .toList()),
              Divider(
                thickness: 2,
                color: Colors.black,
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
