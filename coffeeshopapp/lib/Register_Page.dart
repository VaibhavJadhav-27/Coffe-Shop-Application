// ignore_for_file: prefer_const_constructors, prefer_final_fields, camel_case_types, avoid_print, file_names, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class register_page extends StatelessWidget {
  register_page({Key? key}) : super(key: key);

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
      }
    } else {
      print("Duplicate Entries ..!!");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      }
                      if (pass != cpass) {
                        print("password should be same..!!");
                      }

                      //print(pass);
                      createUserRequest();
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
                ))
          ],
        ),
      ),
    ));
  }
}
