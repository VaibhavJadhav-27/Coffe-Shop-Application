// ignore_for_file: prefer_const_constructors, prefer_final_fields, camel_case_types, avoid_print, file_names, must_be_immutable, unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class register_page extends StatefulWidget {
  register_page({Key? key}) : super(key: key);

  @override
  State<register_page> createState() => _register_pageState();
}

class _register_pageState extends State<register_page> {
  late TextEditingController _name = TextEditingController();

  late TextEditingController _email = TextEditingController();

  late TextEditingController _phone = TextEditingController();

  late TextEditingController _pass = TextEditingController();

  late TextEditingController _cpass = TextEditingController();

  String email = "";

  String name = "";

  String phoneno = "";

  String pass = "";

  String cpass = "";

  String notify = "";

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
                "Email id or phone number already registered..!!",
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

    void createUserRequest() async {
      var url = Uri.parse('http://192.168.0.103:4000/customer/customer');
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      print(name);
      var body = jsonEncode({
        'custname': name,
        'custemail': email,
        'custphoneno': phoneno,
        'custpassword': pass
      });
      var response = await http.post(url, headers: requestHeaders, body: body);
      if (response.statusCode == 200) {
        print("Response Status : ${response.statusCode}");
        print("Response body : " + response.body.toString());
        if (response.body.toString() == "Duplicate entries..!!!") {
          print("Email or phone no is already registered..!!!");
          createAlertDialog(context);
        } else {
          var url1 = Uri.parse('http://192.168.0.103:4000/login/login');
          Map<String, String> requestHeaders = {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          };
          var body1 = jsonEncode(
              {'custemail': email, 'custpassword': pass, 'status': 'customer'});
          var response1 =
              await http.post(url1, headers: requestHeaders, body: body1);
          if (response1.statusCode == 200) {
            print("Response status = ${response1.statusCode}");
            print("Response body : " + response1.body.toString());
            Navigator.pop(context);
          }
        }
      }
    }

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            /*Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Image.asset(
                  "assets/images/Ellipse 5.png",
                  //height: 200,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                    top: 80,
                    left: 185,
                    child: Image.asset("assets/images/logo.png"))
              ],
            ),*/
            SizedBox(
              height: 70,
            ),
            Center(
                child: Text("Register",
                    style: TextStyle(
                      fontFamily: "Comfortaa",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ))),
            SizedBox(
              height: 35,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _name,
                decoration: InputDecoration(
                    hintText: "Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onChanged: (value) {
                  name = value;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                    hintText: "Email ID",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _phone,
                decoration: InputDecoration(
                    hintText: "Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _pass,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: _cpass,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Confirm Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: (ElevatedButton(
                    onPressed: () {
                      name = _name.text;
                      email = _email.text;
                      phoneno = _phone.text;
                      pass = _pass.text;
                      cpass = _cpass.text;
                      if (email == "" ||
                          pass == "" ||
                          name == "" ||
                          phoneno == "") {
                        print("Fill all the fields...!!");
                        setState(() {
                          notify = "Fill all the fields";
                        });
                        createAlertDialog(BuildContext context) {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.all(10),
                                  backgroundColor:
                                      Color.fromRGBO(101, 30, 62, 1),
                                  elevation: 20,
                                  title: Text(
                                    "Fill all the fields..!!",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Back",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ))
                                  ],
                                );
                              });
                        }
                      } else if (pass != cpass) {
                        print("password should be same..!!");
                        setState(() {
                          notify = "Password should be same";
                        });
                        createAlertDialog(BuildContext context) {
                          return showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.all(10),
                                  backgroundColor:
                                      Color.fromRGBO(101, 30, 62, 1),
                                  elevation: 20,
                                  title: Text(
                                    "Password and Confirm password should be same..!!",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Back",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        ))
                                  ],
                                );
                              });
                        }
                      } else {
                        createUserRequest();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(101, 30, 62, 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )))),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Back",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(101, 30, 62, 1)),
                )),
            SizedBox(
              height: 30,
            ),
            Text(notify),
          ],
        ),
      ),
    ));
  }
}
