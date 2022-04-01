// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field, prefer_const_constructors_in_immutables, avoid_print, unnecessary_null_comparison, curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'employeeclass.dart';

enum Designation { employee, deliveryperson }

class EmployeePage extends StatefulWidget {
  EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  Designation? _employee = Designation.employee;
  String name = "";
  String email = "";
  String password = "";
  String phoneno = "";
  String designation = "";
  int salary = 0;
  bool switchbutton = false;
  late TextEditingController _namecontroller = TextEditingController();
  late TextEditingController _emailcontroller = TextEditingController();
  late TextEditingController _passcontroller = TextEditingController();
  late TextEditingController _designationcontroller = TextEditingController();
  late TextEditingController _salarycontroller = TextEditingController();
  late TextEditingController _phonenocontroller = TextEditingController();

  List<Employee> emprecords = [];
  Future<List<Employee>> fetchdetails() async {
    var url = Uri.parse('http://192.168.0.201:4000/employee/employee');
    var response = await http.get(url);
    var empjson = json.decode(response.body);
    for (var u in empjson) {
      Employee emp = Employee(u["empid"], u["empname"], u["empphoneno"],
          u["empemail"], u["emppassword"], u["empdesignation"], u["empsalary"]);
      emprecords.add(emp);
    }
    print(emprecords.length);
    setState(() {
      emprecords;
    });
    return emprecords;
  }

  void addemployee() async {
    var url = Uri.parse('http://192.168.0.201:4000/employee/employee');
    Map<String, String> requestHeaders1 = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var body = jsonEncode({
      'empname': name,
      'empphoneno': phoneno,
      'empemail': email,
      'emppassword': password,
      'empdesignation': designation,
      'empsalary': salary.toString()
    });
    var response = await http.post(url, headers: requestHeaders1, body: body);
    if (response.statusCode == 200) {
      var resullt = json.decode(response.body.toString());
      print(resullt);
    }
  }

  @override
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
                height: 40,
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
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    Text(
                      "Employee Records",
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
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Phone no")),
                    DataColumn(label: Text("Email")),
                    DataColumn(label: Text("Designation")),
                    DataColumn(label: Text("Salary"))
                  ],
                  rows: emprecords
                      .map<DataRow>((e) => DataRow(cells: [
                            DataCell(
                              Text(e.empname.toString()),
                              onTap: () {
                                setState(() {
                                  name = e.empname.toString();
                                });
                              },
                            ),
                            DataCell(Text(e.empphoneno.toString())),
                            DataCell(Text(e.empemail.toString())),
                            DataCell(Text(e.empdesignation.toString())),
                            DataCell(Text(e.empsalary.toString()))
                          ]))
                      .toList()),
              Divider(
                thickness: 2,
                color: Colors.black,
              ),
              SizedBox(
                height: 30,
              ) /*
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text("Enter Name :"),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: 40,
                      width: 220,
                      child: TextField(
                        controller: _namecontroller,
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "Enter Name...",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Text("Enter Phone no :"),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: 40,
                      width: 220,
                      child: TextField(
                        controller: _phonenocontroller,
                        onChanged: (value) {
                          setState(() {
                            phoneno = value;
                          });
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "Enter Phone no...",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Text("Enter Email id :"),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: 40,
                      width: 220,
                      child: TextField(
                        controller: _emailcontroller,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Enter Email...",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text("Enter Password :"),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: 40,
                      width: 220,
                      child: TextField(
                        controller: _passcontroller,
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                            hintText: "Enter Password...",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text("Enter Salary :"),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: 40,
                      width: 220,
                      child: TextField(
                        controller: _salarycontroller,
                        onChanged: (value) {
                          salary = int.parse(value);
                        },
                        decoration: InputDecoration(
                            hintText: "Enter Salary...",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text("Designation :"),
                    SizedBox(
                      width: 40,
                    ),
                    Radio<Designation>(
                      value: Designation.employee,
                      groupValue: _employee,
                      onChanged: (Designation? value) {
                        setState(() {
                          _employee = value;
                          designation = "employee";
                        });
                      },
                    ),
                    Text("Employee"),
                    SizedBox(
                      width: 40,
                    ),
                    Radio<Designation>(
                      value: Designation.deliveryperson,
                      groupValue: _employee,
                      onChanged: (Designation? value) {
                        setState(() {
                          _employee = value;
                          designation = "deliveryperson";
                        });
                      },
                    ),
                    Text("Delivery Person"),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if(name==null ) ||( phoneno="") || (email="")|| (password="")||(salary==null){

                          }
                          addemployee();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(21, 102, 59, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 19),
                          child: Text(
                            "Add Employee",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          var url = Uri.parse(
                              'http://192.168.0.201:4000/employee/employee');
                          var response = await http.delete(url);
                          var result = json.decode(response.body);
                          print(result);
                          setState(() {
                            fetchdetails();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(21, 102, 59, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 19),
                          child: Text(
                            "Delete Employee",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ))
                  ],
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
