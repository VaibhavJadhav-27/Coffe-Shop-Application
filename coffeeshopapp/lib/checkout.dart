// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore, prefer_const_constructors_in_immutables, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'dart:convert';

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

  @override
  Widget build(BuildContext context) {
    String custname = widget.profile;
    int total = widget.totalprice;
    int pricewithcharges = total  + 50;
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
      List<Cart> cartitems = [];
      var items = "";
      var listitems = [];
      for (var u in cartjson) {
        items =
            "Item Name : " + u["itemname"]; ", Quantity: " + u["itemquantity"].toString();
        listitems.add(items);
      }
      print(listitems);

      var url2 = Uri.parse('http://192.168.0.103:4000/orderdb/order');
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var ordertime = DateTime.now();
      var body = jsonEncode({
        'custid': custid,
        'items' : listitems,
        'totalamount' : total,
        'payment_type': 'cod',
        'ordertime' : ordertime,
        'delivery_type': 'cod',
        'isreceived' : 'false'
      });
      var response2 = await http.post(url2,headers: requestHeaders,body : body);
      
      if (response2.statusCode == 200) {
        print("Response status = ${response1.statusCode}");
        print("Response body : " + response2.body.toString());
      }
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
                  Text("${total}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
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
                  Text("50",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
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
                  Text("${pricewithcharges}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  getcartitems();
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
