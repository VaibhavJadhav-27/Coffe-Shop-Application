// ignore_for_file: camel_case_types, prefer_const_constructors, duplicate_ignore, prefer_const_constructors_in_immutables, prefer_final_fields

import 'package:flutter/material.dart';

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
  late TextEditingController _city = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(
        // ignore: prefer_const_constructors
        child: Scaffold(
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
              padding: const EdgeInsets.only(left: 10),
              child: Text("Delivery Address :"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: TextField(
                  controller: _address,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Address",
                  ),
                ),
                height: 80,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("Pincode :"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: TextField(
                  controller: _pincode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Pincode",
                  ),
                ),
                height: 40,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("Phone Number :"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: TextField(
                  controller: _phoneno,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Phone Number",
                  ),
                ),
                height: 40,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text("City :"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: TextField(
                  controller: _city,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Mumbai",
                  ),
                ),
                height: 80,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Sub Total :"), Text("")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Delivery Charges :"), Text("")],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(" Total :"), Text("")],
            ),
            ElevatedButton(
              onPressed: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Text(
                  "Place Order",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(21, 102, 59, 1)),
            )
          ],
        ),
      ),
    ));
  }
}
