// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, unused_field

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'employeeclass.dart';

class EmployeePage extends StatefulWidget {
  EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  String name = "";
  String email = "";
  String password = "";
  String phoneno = "";
  String designation = "";
  int salary = 0;
  late TextEditingController _namecontroller = TextEditingController();
  late TextEditingController _emailcontroller = TextEditingController();
  late TextEditingController _passcontroller = TextEditingController();
  late TextEditingController _designationcontroller = TextEditingController();
  late TextEditingController _salarycontroller = TextEditingController();
  late TextEditingController _phonenocontroller = TextEditingController();

  List<Employee> emprecords = [];
  Future<List<Employee>> fetchdetails() async {
    var url = Uri.parse('http://192.168.0.103:4000/employee/employee');
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
                height: 50,
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
              SizedBox(
                height: 30,
              ),
              Text(name),
              SizedBox(
                height: 40,
                width: 130,
                child: TextField(
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name",
                  ),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 40,
                width: 130,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name",
                  ),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 40,
                width: 130,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name",
                  ),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 40,
                width: 130,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name",
                  ),
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 40,
                width: 130,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Name",
                  ),
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
