// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_final_fields, avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'deliveryclass.dart';

class DPpage extends StatefulWidget {
  final String profile;
  DPpage({Key? key, required this.profile}) : super(key: key);

  @override
  State<DPpage> createState() => _DPpageState();
}

class _DPpageState extends State<DPpage> {
  late TextEditingController _orderidcontroller = TextEditingController();
  late int orderid;
  int lengthdl = 0;
  late var record;
  var status = "";
  late int confirmorderid;
  @override
  Widget build(BuildContext context) {
    String profile = widget.profile;

    Future<List<Delivery>> viewdeliveryorder() async {
      var url =
          Uri.parse('http://192.168.0.103:4000/delivery/delivery/$orderid');
      var response = await http.get(url);
      var orderjson = json.decode(response.body.toString());
      status = orderjson[0]["isreceived"];
      print(orderjson);
      //print("Record : " + record);
      List<Delivery> deliveryitems = [];
      for (var u in orderjson) {
        Delivery delivery = Delivery(u["deliveryid"], u["custid"], u["orderid"],
            u["address"], u["items"], u["totalamount"], u["isreceived"]);
        deliveryitems.add(delivery);
      }
      lengthdl = deliveryitems.length;
      print(lengthdl);
      return deliveryitems;
    }

    void initState() {
      super.initState();
      viewdeliveryorder();
    }

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                    "Delivery  Orders",
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
            Text("Welcome $profile",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Text(
                  "Enter Order Id : ",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  width: 15,
                ),
                SizedBox(
                  height: 40,
                  width: 130,
                  child: TextField(
                    controller: _orderidcontroller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Order Id.....",
                    ),
                    onChanged: (value) {
                      orderid = int.parse(value);
                      print(orderid);
                    },
                  ),
                ),
                SizedBox(width: 30),
              ],
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: ElevatedButton(
                    onPressed: () {
                      if (_orderidcontroller.text == "") {
                        print("Orderid is empty..!!!");
                      } else {
                        setState(() {
                          orderid = int.parse(_orderidcontroller.text);
                          viewdeliveryorder();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(21, 102, 59, 1)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 19, vertical: 10),
                      child: Text("Search"),
                    )),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: 180,
              width: MediaQuery.of(context).size.width * 0.9,
              child: FutureBuilder(
                  future: viewdeliveryorder(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return ListView.builder(
                        itemCount: lengthdl,
                        itemBuilder: (BuildContext context, int index) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: Text(
                                "No Orders ..!!",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                                                  fontWeight: FontWeight.bold),
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
                                                  fontWeight: FontWeight.bold),
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(snapshot
                                                .data[index].totalamount
                                                .toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Delivery Address : ",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Expanded(
                                                child: Text(snapshot
                                                    .data[index].address))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Type : ",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
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
                                                  fontWeight: FontWeight.bold),
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
            SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    if (status == "") {
                      print("Empty");
                    } else {
                      if (_orderidcontroller.text == "") {
                        print("Please enter order id");
                      } else {
                        if (lengthdl != 0 && status == "false") {
                          confirmorderid = orderid;
                          status = "Departed";
                          var url = Uri.parse(
                              'http://192.168.0.103:4000/delivery/delivery/customer/$confirmorderid/$status');
                          Map<String, String> requestHeaders1 = {
                            'Content-type': 'application/json',
                            'Accept': 'application/json',
                          };
                          var response =
                              await http.put(url, headers: requestHeaders1);
                          print("Response Status : ${response.statusCode}");
                          print("Response body : " + response.body);
                          setState(() {
                            viewdeliveryorder();
                          });
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(21, 102, 59, 1)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: Text("Departure"),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    if (status == "") {
                      print("Empty");
                    } else {
                      if (_orderidcontroller.text == "") {
                        print("Please enter order id");
                      } else {
                        if (lengthdl != 0 && status == "Departed") {
                          confirmorderid = orderid;
                          status = "Delivered";
                          var url = Uri.parse(
                              'http://192.168.0.103:4000/delivery/delivery/customer/$confirmorderid/$status');
                          Map<String, String> requestHeaders1 = {
                            'Content-type': 'application/json',
                            'Accept': 'application/json',
                          };
                          var response =
                              await http.put(url, headers: requestHeaders1);
                          print("Response Status : ${response.statusCode}");
                          print("Response body : " + response.body);
                          setState(() {
                            viewdeliveryorder();
                          });
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(21, 102, 59, 1)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: Text("Delivered"),
                  )),
            )
          ],
        ),
      )),
    ));
  }
}
