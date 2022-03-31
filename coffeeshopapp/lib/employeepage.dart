// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
