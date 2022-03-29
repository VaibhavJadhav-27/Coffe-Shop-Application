// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:coffeeshopapp/home_page.dart';
import 'package:flutter/material.dart';

class OrderConfirm extends StatefulWidget {
  final int orderid;
  OrderConfirm({Key? key, required this.orderid}) : super(key: key);

  @override
  State<OrderConfirm> createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  String profile = "purva";
  String detail =
      "Aight ....!!! \nWe have received your order and will get to it soon. You can keep track of the status order by clicking on the button below.";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(child: Image.asset("assets/images/coffeeenergy.png")),
            SizedBox(
              height: 50,
            ),
            Text("Order Confirmed"),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Wrap(children: [
                Text(
                  detail,
                  textAlign: TextAlign.center,
                )
              ]),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70),
                  child: Center(
                    child: Text("Back to Home"),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Homepage(profile: profile)));
                },
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ));
  }
}
