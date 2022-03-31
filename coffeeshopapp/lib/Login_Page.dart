// ignore_for_file: file_names, camel_case_types, prefer_const_constructors, unused_import, prefer_final_fields, avoid_print, unused_local_variable, non_constant_identifier_names

import 'dart:convert';
import 'dart:math';
import 'package:coffeeshopapp/admindashboard.dart';
import 'package:coffeeshopapp/deliverypersonpage.dart';
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

  @override
  Widget build(BuildContext context) {
    createAlertDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(10),
              backgroundColor: Color.fromRGBO(101, 30, 62, 1),
              elevation: 20,
              title: Text(
                "Wrong inputs..!!",
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

    void verify_password() async {
      var url1 =
          Uri.parse('http://192.168.0.103:4000/login/login/$email/$password');
      var response1 = await http.get(url1);
      var responsejson = json.decode(response1.body.toString());
      var status = responsejson[0]["status"];
      print(status);
      if (response1.body == "NO entries") {
        createAlertDialog(context);
      } else {
        if (status == "admin") {
          var url2 = Uri.parse(
              'http://192.168.0.103:4000/employee/employee/empid/$email/$password');
          var response2 = await http.get(url2);
          var empjson = json.decode(response2.body.toString());
          var profile = empjson[0]["empname"];
          print(profile);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminDashboard(profile: profile)));
        }
        if (status == "deliveryperson") {
          var url2 = Uri.parse(
              'http://192.168.0.103:4000/employee/employee/empid/$email/$password');
          var response2 = await http.get(url2);
          var empjson = json.decode(response2.body.toString());
          var profile = empjson[0]["empname"];
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DPpage(profile: profile)));
        }
        if (status == "customer") {
          var url = Uri.parse(
              'http://192.168.0.103:4000/customer/customer1/$email/$password');

          Map<String, String> requestHeaders = {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          };
          var response = await http.get(url);
          var jsonresponse = json.decode(response.body.toString());
          var profile = jsonresponse[0]["custname"];
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Homepage(
                        profile: profile,
                      )));
        }
      }
    }

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
                obscureText: true,
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
                        verify_password();
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
