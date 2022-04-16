// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore, prefer_const_constructors_in_immutables, prefer_final_fields, prefer_const_literals_to_create_immutables, avoid_print, unused_import, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:coffeeshopapp/orderconfirm.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cartclass.dart';

class checkout extends StatefulWidget {
  final String profile;
  final int totalprice;
  checkout({Key? key, required this.profile, required this.totalprice})
      : super(key: key);

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  late TextEditingController _address = TextEditingController();
  late TextEditingController _pincode = TextEditingController();
  late TextEditingController _phoneno = TextEditingController();

  late int custid;
  String add1 = "";
  String pin = "";
  String phone = "";
  late int oid;

  @override
  Widget build(BuildContext context) {
    String custname = widget.profile;
    int total = widget.totalprice;
    int pricewithcharges = total + 50;
    // ignore: prefer_const_constructors
    void getcartitems() async {
      //for getting customer id from customer name
      var url =
          Uri.parse('http://192.168.0.103:4000/customer/customer/$custname');
      var response = await http.get(url);
      var custjson = json.decode(response.body);
      print(custjson);
      custid = custjson[0]["custid"];
      print(custid);

      var url1 = Uri.parse('http://192.168.0.103:4000/cart/cart/$custid');
      var response1 = await http.get(url1);
      var cartjson = json.decode(response1.body);
      print(cartjson);
      var items = "";
      var listitems = "";
      for (var u in cartjson) {
        items = " Item Name : " +
            u["itemname"] +
            "  Quantity: " +
            u["itemquantity"].toString();
        listitems = listitems + items;
      }
      print(listitems);

      var url2 = Uri.parse('http://192.168.0.103:4000/orderdb/order');
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var now1 = DateTime.now();
      var ordertime =
          "${now1.year}-${now1.month}-${now1.day} ${now1.hour}:${now1.minute}:${now1.second}";
      var ordertime1 = ordertime;
      print(ordertime);
      print(ordertime1);
      var body = jsonEncode({
        'custid': custid,
        'items': listitems,
        'totalamount': total,
        'payment_type': 'cod',
        'ordertime': ordertime,
        'delivery_type': 'cod',
        'isreceived': 'false'
      });
      var response2 =
          await http.post(url2, headers: requestHeaders, body: body);

      if (response2.statusCode == 200) {
        print("Response status = ${response1.statusCode}");
        print("Response body : " + response2.body.toString());
      }
      // to find orderid
      var url3 = Uri.parse(
          'http://192.168.0.103:4000/orderdb/order/orderid/$custid/$ordertime');
      var response3 = await http.get(url3);
      var orderjson = json.decode(response3.body);
      var orderid = orderjson[0]["orderid"];
      oid = orderid;
      print(orderjson);
      print(orderid);

      //to enter recorde in delivery table;
      String combined_address =
          add1 + ", Mumbai : " + pin + ", Contact number : " + phone;
      var url4 = Uri.parse('http://192.168.0.103:4000/delivery/delivery');
      var body4 = jsonEncode({
        'custid': custid,
        'orderid': orderid,
        'address': combined_address,
        'items': listitems,
        'totalamount': pricewithcharges,
        'isreceived': 'false'
      });
      var response4 =
          await http.post(url4, headers: requestHeaders, body: body4);
      if (response4.statusCode == 200) {
        print("Response Status : ${response4.statusCode}");
        print("Response Body : " + response4.body);
      }
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
                "Fill all the address details...!!",
                style: TextStyle(fontSize: 25, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ))
              ],
            );
          });
    }

    return SafeArea(
        // ignore: prefer_const_constructors
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        size: 25,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                  ),
                  Text("Checkout",
                      style: TextStyle(
                          fontFamily: "Comfortaa",
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(21, 102, 59, 1))),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Delivery Address :",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: SizedBox(
                child: TextField(
                  controller: _address,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Address",
                  ),
                  onChanged: (value) {
                    setState(() {
                      add1 = value;
                      print(add1);
                    });
                  },
                ),
                height: 100,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Pincode :",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: SizedBox(
                child: TextField(
                  controller: _pincode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Pin code",
                  ),
                  onChanged: (value) {
                    setState(() {
                      pin = value;
                      print(pin);
                    });
                  },
                ),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Phone Number :",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: SizedBox(
                child: TextField(
                  controller: _phoneno,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Phone Number",
                  ),
                  onChanged: (value) {
                    setState(() {
                      phone = value;
                      print(phone);
                    });
                  },
                ),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "City :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Mumbai",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 2,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sub Total :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      total.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Charges :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      "50",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    " Total :",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      "${pricewithcharges}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (add1 == "" || pin == "" || phone == "") {
                    createAlertDialog(context);
                  } else {
                    getcartitems();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OrderConfirm(profile: custname)));
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  child: Text(
                    "Place Order",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(21, 102, 59, 1)),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
