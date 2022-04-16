// ignore_for_file: avoid_print, prefer_const_constructors_in_immutables, annotate_overrides, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'menuclass.dart';

class MenuAdmin extends StatefulWidget {
  MenuAdmin({Key? key}) : super(key: key);

  @override
  State<MenuAdmin> createState() => _MenuAdminState();
}

class _MenuAdminState extends State<MenuAdmin> {
  String name = "";
  List<Menu> menurecords = [];
  Future<List<Menu>> fetchdetails() async {
    var url = Uri.parse('http://192.168.0.103:4000/menu/menu');
    var response = await http.get(url);
    var empjson = json.decode(response.body);
    for (var u in empjson) {
      Menu menu = Menu(u["itemid"], u["itemname"], u["itemdesc"],
          u["itemcategory"], u["itemimage"], u["itemprice"]);
      menurecords.add(menu);
    }
    print(menurecords.length);
    setState(() {
      menurecords;
    });
    return menurecords;
  }

  void initState() {
    super.initState();
    fetchdetails();
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
                      width: MediaQuery.of(context).size.width * 0.17,
                    ),
                    Text(
                      "Menu Items",
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
                  columns: [
                    DataColumn(label: Text("Image")),
                    DataColumn(label: Text("Item name")),
                    DataColumn(label: Text("Category")),
                    DataColumn(label: Text("Price")),
                  ],
                  rows: menurecords
                      .map<DataRow>((e) => DataRow(cells: [
                            DataCell(SizedBox(
                                child: Image.asset(
                                  e.itemimage,
                                  scale: 0.2,
                                ),
                                height: 100,
                                width: 80)),
                            DataCell(
                              Text(e.itemname.toString()),
                              onTap: () {
                                setState(() {
                                  name = e.itemname.toString();
                                });
                              },
                            ),
                            DataCell(Text(e.itemcategory.toString())),
                            DataCell(Text(e.itemprice.toString())),
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
