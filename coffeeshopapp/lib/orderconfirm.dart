// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:coffeeshopapp/home_page.dart';
import 'package:flutter/material.dart';

class OrderConfirm extends StatefulWidget {
  final String profile;
  OrderConfirm({Key? key, required this.profile}) : super(key: key);

  @override
  State<OrderConfirm> createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  String detail =
      "Aight ....!!! \nWe have received your order and will get to it soon. You can keep track of the status order by clicking on the button below.\n\n Thank you for ordering..!!!";
  @override
  Widget build(BuildContext context) {
    String profile = widget.profile;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Image.asset("assets/images/coffeeenergy.png")),
          SizedBox(
            height: 50,
          ),
          Text(
            "Order Confirmed",
            style: TextStyle(
                fontFamily: "Comfortaa",
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(21, 102, 59, 1)),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Wrap(children: [
              Text(
                detail,
                style: TextStyle(
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              )
            ]),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(21, 102, 59, 1)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                child: Center(
                  child: Text(
                    "Back to Home",
                    style: TextStyle(fontSize: 20),
                  ),
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
    );
  }
}
