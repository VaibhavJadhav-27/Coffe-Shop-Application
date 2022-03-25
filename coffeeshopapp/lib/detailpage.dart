// ignore_for_file: camel_case_types, prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables, unused_local_variable, unused_element, prefer_const_literals_to_create_immutables

import 'package:coffeeshopapp/menuclass.dart';
import 'package:flutter/material.dart';

class detailpage extends StatefulWidget {
  final String itemname;
  final String itemdesc;
  final String itemimage;
  final String itemprice;
  detailpage(
      {Key? key,
      required this.itemname,
      required this.itemdesc,
      required this.itemimage,
      required this.itemprice})
      : super(key: key);

  @override
  State<detailpage> createState() => _detailpageState();
}

class _detailpageState extends State<detailpage> {
  @override
  Widget build(BuildContext context) {
    String itemname = widget.itemname;
    late List data;
    var lengthit = 1;
    int quantity = 1;

    String itemdesc = widget.itemdesc;
    String itemprice = widget.itemprice;
    String itemimage = widget.itemimage;
    int totalprice = int.parse(itemprice);
    String tot = "";

    void updatequantity() {
      quantity;
      totalprice = int.parse(itemprice) * quantity;
      tot = "Rs. " + totalprice.toString();
    }

    @override
    void initState() {
      super.initState();
      updatequantity();
    }

    @override
    void dispose() {
      this.dispose();
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
                IconButton(
                    onPressed: () {
                      if (quantity < 2) {
                        quantity = 1;
                      } else {
                        quantity = quantity - 1;
                      }
                      totalprice = int.parse(itemprice) * quantity;
                      print(totalprice);
                      updatequantity();
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Colors.black,
                      size: 25,
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(quantity.toString()),
                ),
                IconButton(
                    onPressed: () {
                      if (quantity > 20) {
                        quantity = 20;
                      } else {
                        quantity = quantity + 1;
                      }

                      totalprice = int.parse(itemprice) * quantity;
                      print(totalprice);
                      updatequantity();
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 25,
                    )),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 13),
            child: Text(
              "Total",
              style: TextStyle(
                  color: Color.fromRGBO(21, 102, 59, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 13, right: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tot),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
