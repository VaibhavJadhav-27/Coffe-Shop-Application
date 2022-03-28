// ignore_for_file: camel_case_types, prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables, unused_local_variable, unused_element, prefer_const_literals_to_create_immutables, avoid_print, prefer_final_fields, unused_import

import 'package:coffeeshopapp/menuclass.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class detailpage extends StatefulWidget {
  final String profile;
  final int itemid;
  final String itemname;
  final String itemdesc;
  final String itemimage;
  final String itemprice;
  detailpage(
      {Key? key,
      required this.profile,
      required this.itemid,
      required this.itemname,
      required this.itemdesc,
      required this.itemimage,
      required this.itemprice})
      : super(key: key);

  @override
  State<detailpage> createState() => _detailpageState();
}

class _detailpageState extends State<detailpage> {
  TextEditingController _controller = TextEditingController();
  late int totalprice;
  String quantity1 = "1";

  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(10),
            backgroundColor: Color.fromRGBO(21, 102, 59, 1),
            elevation: 20,
            title: Text(
              "Added to cart",
              style: TextStyle(
                  fontFamily: "Comfortaa", fontSize: 25, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            content: Image.asset("assets/images/Vector.png"),
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

  @override
  Widget build(BuildContext context) {
    String itemname = widget.itemname;
    late List data;
    var lengthit = 1;
    int quantity = 1;

    String custname = widget.profile;
    int itemid = widget.itemid;
    String itemdesc = widget.itemdesc;
    String itemprice = widget.itemprice;
    String itemimage = widget.itemimage;
    totalprice = int.parse(itemprice);

    void updatequantity() {
      setState(() {
        if (int.parse(quantity1) < 1) {
          quantity1 = "1";
        } else {
          quantity1;
        }
        print("value of quantity in updatequantity inset state : " + quantity1);
        totalprice = int.parse(itemprice) * int.parse(quantity1);
        print(totalprice.toString());
      });
      print("value of quantity outside set state : " + quantity1);
      print("total out of set state :" + totalprice.toString());
    }

    @override
    void initState() {
      super.initState();
    }

    @override
    void dispose() {
      this.dispose();
    }

    void updatecartitems() async {
      //For getting customer id from customer name
      var url1 =
          Uri.parse('http://192.168.0.103:4000/customer/customer/$custname');
      Map<String, String> requestHeaders1 = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var response = await http.get(url1, headers: requestHeaders1);
      var custjson = json.decode(response.body);
      print(custjson);
      int custid = custjson[0]["custid"];
      print(custid);

// checking if the item is present in the cart of that particular customer
      var url2 =
          Uri.parse('http://192.168.0.103:4000/cart/cart/$custid/$itemid');
      Map<String, String> requestHeaders2 = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var response2 = await http.get(url2, headers: requestHeaders2);
      var itemjson = json.decode(response2.body);
      print(itemjson);
      try {
        //if data is present, update the quantity
        int iid = itemjson[0]["itemid"];
        int iprice = itemjson[0]["itemprice"];
        int res = iprice * int.parse(quantity1);
        print("data available");
        var url = Uri.parse('http://192.168.0.103:4000/cart/cart');
        Map<String, String> requestHeaders = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
        print(totalprice);
        print(quantity1);
        var body = jsonEncode({
          'custid': custid,
          'itemid': itemid,
          'itemprice': int.parse(itemprice),
          'itemquantity': int.parse(quantity1),
          'totalamount': res,
        });
        var response1 =
            await http.put(url, headers: requestHeaders, body: body);
        if (response1.statusCode == 200) {
          print("Response Status : ${response1.statusCode}");
          print("Response body : " + response1.body.toString());
        }
      } on RangeError {
        //if data is not present, insert all the details
        var url4 = Uri.parse('http://192.168.0.103:4000/menu/menu/$itemname');
        Map<String, String> requestHeaders2 = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
        var response2 = await http.get(url4, headers: requestHeaders2);
        var item1json = json.decode(response2.body);
        print(item1json);
        int iprice = item1json[0]["itemprice"];
        int res = iprice * int.parse(quantity1);
        print("Not available");
        var url = Uri.parse('http://192.168.0.103:4000/cart/cart');
        Map<String, String> requestHeaders = {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        };
        var body = jsonEncode({
          'custid': custid,
          'itemid': itemid,
          'itemname': itemname,
          'itemimage': itemimage,
          'itemprice': int.parse(itemprice),
          'itemquantity': int.parse(quantity1),
          'totalamount': res
        });
        var response1 =
            await http.post(url, headers: requestHeaders, body: body);
        if (response1.statusCode == 200) {
          print("Response Status : ${response1.statusCode}");
          print("Response body : " + response1.body.toString());
        }
      } catch (e) {
        print("Not available");
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Stack(alignment: AlignmentDirectional.topStart, children: [
              Image.asset(
                itemimage,
                scale: 0.3,
                fit: BoxFit.cover,
              ),
              Positioned(
                  top: 10,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      color: Colors.white,
                    ),
                  )),
              Positioned(
                child: Image.asset("assets/images/rectangle.png"),
                bottom: -10.0,
              ),
              Positioned(
                bottom: 15.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    itemname,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Text(itemdesc,
                style: TextStyle(
                  fontSize: 19,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(13),
            child: Text(
              "Price : " + itemprice,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontSize: 19),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8, left: 13),
            child: Row(
              children: [
                Text(
                  "Amount ",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 19),
                ),
                Spacer(),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          quantity1 = value;
                          print(
                              "Value of quantity when pressed : " + quantity1);
                          updatequantity();
                        });
                      },
                    ),
                  ),
                ),
                /*IconButton(
                    onPressed: () {
                      decrementquantity();
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Colors.black,
                      size: 25,
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text("$quantity"),
                ),
                IconButton(
                    onPressed: incrementq,
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 25,
                    )),
                SizedBox(
                  width: 15,
                ),*/
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 13, right: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    //updatequantity();
                    updatecartitems();
                    createAlertDialog(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(21, 102, 59, 1)),
                ),
              ],
            ),
          )
        ],
      )) /*
        child: FutureBuilder(
          future: getdetails(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return GridView.builder(
                itemCount: lengthit,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data == null) {
                    return Container(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Image.asset(snapshot.data[index].itemimage),
                            Positioned(
                              child: Image.asset("assets/images/rectangle.png"),
                              bottom: -10.0,
                            ),
                          ],
                        ),
                        Text(snapshot.data[index].itemname),
                        Text(snapshot.data[index].itemdesc),
                        Text(snapshot.data[index].itemprice.toString()),
                      ],
                    );
                  }
                });
          },
        ),*/
          ),
    );
  }
}
