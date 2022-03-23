// ignore_for_file: file_names, unused_local_variable, prefer_const_constructors, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:coffeeshopapp/menuclass.dart';

class DisplayMenuIt extends StatefulWidget {
  const DisplayMenuIt({Key? key}) : super(key: key);

  @override
  State<DisplayMenuIt> createState() => _DisplayMenuItState();
}

class _DisplayMenuItState extends State<DisplayMenuIt> {
  var menuitems = <Menu>[];
  Future displayMenu() async {
    var url = Uri.parse('http://localhost:4000/menu/menu');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var menujson = json.decode(response.body);
      for (var menujson in menujson) {
        //menuitems.add(Menu.fromJson(menujson));
      }
      print(menujson.length);
    }
  }

  @override
  void initState() {
    super.initState();
    displayMenu();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        menuitems[index].itemimage,
                        height: 50,
                      ),
                      Column(
                        children: [
                          Text(menuitems[index].itemname),
                          Text(menuitems[index].itemprice.toString())
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
