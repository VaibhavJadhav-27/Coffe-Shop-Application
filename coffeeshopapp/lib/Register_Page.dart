// ignore_for_file: prefer_const_constructors, prefer_final_fields, camel_case_types, avoid_print, file_names, must_be_immutable

import 'package:flutter/material.dart';

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
                onSubmitted: (value) {
                  name = value;
                  print(name);
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
                onSubmitted: (value) {
                  email = value;
                  print(email);
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
                controller: _phone,
                decoration: InputDecoration(
                    hintText: "Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onSubmitted: (value) {
                  phoneno = value;
                  print(phoneno);
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
                controller: _pass,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onSubmitted: (value) {
                  pass = value;
                  print(pass);
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
                controller: _cpass,
                decoration: InputDecoration(
                    hintText: "Confirm Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
                onSubmitted: (value) {
                  cpass = value;
                  print(cpass);
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
                      if (email == "" ||
                          pass == "" ||
                          name == "" ||
                          phoneno == "") {
                        print("Fill all the fields...!!");
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
                            color: Color.fromRGBO(101, 30, 62, 1)),
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
