// ignore_for_file: file_names, camel_case_types, prefer_const_constructors, unused_import, prefer_final_fields, avoid_print

import 'dart:math';
import 'package:coffeeshopapp/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:coffeeshopapp/Register_Page.dart';
import 'package:flutter/material.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  late TextEditingController _emailcontroller = TextEditingController();
  late TextEditingController _passwordcontroller = TextEditingController();

  String email = "";
  String password = "";

  void authenticateuser() async {
    final body = {'custemail': email, 'custpassword': password};
    var url = Uri.parse('http://localhost:4000/customer/$email/$password');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body.toString());
      print("successfull.!!!");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } else {
      print(response.body.toString());
      print("wrong username");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Image.asset("assets/images/Ellipse 5.png"),
                Positioned(
                    top: 110,
                    left: 135,
                    child: Image.asset("assets/images/logo.png"))
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Center(
                child: Text("Log In",
                    style: TextStyle(
                        fontFamily: "Comfortaa",
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromRGBO(101, 30, 62, 1)))),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _emailcontroller,
                decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onChanged: (value) {
                  email = value;
                  print(email);
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _passwordcontroller,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onChanged: (value) {
                  password = value;
                  print(password);
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: (ElevatedButton(
                    onPressed: () {
                      if (email == "" || password == "") {
                        print("Fill all the fields...!!");
                      } else {
                        authenticateuser();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(101, 30, 62, 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Log in",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    )))),
            SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => register_page()));
                },
                child: Text(
                  "Create a new account",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(101, 30, 62, 1)),
                ))
          ],
        ),
      ),
    ));
  }
}
